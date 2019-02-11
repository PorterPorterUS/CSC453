dir = File.dirname(__FILE__)
require 'digest'
require 'tempfile'
require 'zlib'
load dir + '/mdiff.rb'

$nullid = Digest::SHA1.digest('')

class Revlog
	attr_accessor :indexfile
	attr_accessor :datafile
	attr_accessor :index
	attr_accessor :nodemap
	
	def initialize(indexfile, datafile)
		@indexfile = indexfile
		@datafile = datafile
		@index = Array.new
		@nodemap = {-1 => $nullid, $nullid => -1}
		begin
			n = 0
			i = self.open(@indexfile).read.bytes
			(0...i.length).step(40).each do |f|
				# offset, size, base, p1, p2, nodeid
				e = i[f...f + 40].pack("c*").unpack("l>l>l>l>l>A20>")
				@nodemap[e[5]] = n
				 # index: store all revision entries
				 @index << e
				 n += 1
			end
		rescue
			# do nothing
		end
	end
	
	def open(fn, mode = "r", &block)
		File.open(fn, mode, &block)
	end

	def tip()
		@index.length - 1
	end

	def node(rev)
		# p rev
		# p @index[rev]
		rev < 0 and $nullid or @index[rev][5]
	end

	def rev(node)
		@nodemap[node]
	end

	def parents(rev)
		@index[rev][3...5]
	end

	def start(rev)
		@index[rev][0]
	end

	def length(rev)
		@index[rev][1]
	end

	def end(rev)
		self.start(rev) + self.length(rev)
	end

	def base(rev)
		# p @index[rev]
		@index[rev][2]
	end

	def ancestor(a, b)
		def expand(e1, e2, a1, a2)
			ne = Array.new()
			e1.each do |r|
				p1, p2 = self.parents(r)
				if a2.include? p1
					return p1
				end
				if a2.include? p2
					return p2
				end
				if not a1.include?p1 then
					a1[p1] = 1
					ne << p1
					if p2 >= 0 and not a1.include?p2
						a1[p2] = 1
						ne << p2
					end
				end
			end
			return expand(e2, ne, a2, a1)
		end
		return expand([a], [b], {a => 1}, {b => 1})
	end

	def mergedag(other, accumulate = nil)
		amap = @nodemap
		bmap = other.nodemap
		old = i = self.tip
		l = []
		(other.tip() + 1).times do |r|
			id = other.node(r)
			if not amap.include? id then
				i += 1
				x, y = other.parents(r)
				xn, yn = other.node(x), other.node(y)
				l << [r,  amap[xn],  amap[yn]]
				amap[id] = i
			end
		end

		ee = Array.new
		l.each do |e|
			ee << e[0]
		end
		r = other.revisions(ee)

		l.each do |e|
			t = r.next
			if accumulate
				accumulate{|t| t}
			end
			self.addrevision(t, e[1], e[2])
		end

		Array.new([old, self.tip])
	end

	def resolvedag(old, new)
		if old == new
			return nil
		end
		a = self.ancestor(old, new)
		puts old, new, a
		if old == a
			return new
		end
		self.merge3(old, new, a)
	end

	def merge(other)
		# this is where to handle rollback
		tmp = self.mergedag(other)
		o = tmp[0]
		n = tmp[1]
		self.resolvedag(o, n)
	end

	def revisions(list)
		# this can be optimized to do spans, etc
		# list.each do |r|
		# 	yield self.revision(r)
		# end
		Enumerator.new do |g|
			list.each do |r|
				g.yield self.revision(r)
			end
		end
	end

	def revision(rev)
		if rev == -1
			return ""
		end

		base = self.base(rev)
		start = self.start(base)
		endd = self.end(rev)

		f = self.open(@datafile)
		f.seek(start)
		data = f.read(endd - start)

		# base
		last = self.length(base)

		text = Zlib::Inflate.inflate(data[0...last])
		# p "before loop", text
		# for r in (base + 1...rev + 1).step(1)
		if base < rev
			# p "intoooooooo"
			(base+1..rev).each do |r|
				s = self.length(r)
				# TODO whether ... or ..
				b = Zlib::Inflate.inflate(data[last...last + s])
				text = Mdiff.patch(text, b)
				last = last + s
			end
		end

		# p "after loop", text

		p1, p2 = self.parents(rev)
		# p1 = tmp[0]
		# p2 = tmp[1]

		n1, n2 = self.node(p1), self.node(p2)
		# node = Digest::SHA256.hexdigest(n1 + n2 + text)[0...20]
		node = Digest::SHA1.digest(n1 + n2 + text)
		if self.node(rev) != node
			raise "Consistency check failed on %s:%d" % [@datafile, rev]
		end
		return text
	end

	def addrevision(text, p1 = nil, p2 = nil)
		if text.nil?
			text = ''
		end
		if p1.nil?
			p1 = self.tip()
		end
		if p2.nil?
			p2 = -1
		end

		t = self.tip
		# p "t", t
		n = t + 1

		# 	
		if n != 0
			start = self.start(self.base(t))
			endd = self.end(t)
			prev = self.revision(t)
			data = Zlib::Deflate.deflate(Mdiff.textdiff(prev, text))
		end

		# full versions are inserted when the needed deltas
		# become comparable to the uncompressed text
		if n == 0 or (endd + data.length - start) > text.length * 2
			data = Zlib::Deflate.deflate(text)
			base = n
		else
			base = self.base(t)
		end

		offset = 0
		if t >= 0
			offset = self.end(t)
		end
		# p self.end(2)
		n1, n2 = self.node(p1), self.node(p2)
		# node = Digest::SHA256.hexdigest(n1 + n2 + text)[0...20]
		node = Digest::SHA1.digest(n1 + n2 + text)
		# p text
		e = [offset, data.length, base, p1, p2, node]
		# p "THIS IS ERROR"
		@index << e
		entry = e.pack("l>l>l>l>l>A20>")
		@nodemap[node] = n

		self.open(@indexfile, "a") {|file| file.write(entry)}
		self.open(@datafile, "a") {|file| file.write(data)}
		# self.open(@indexfile, "a").write(entry)
		# self.open(@datafile, "a").write(data)

		return n
	end

	def merge3(my, other, base)
		def temp(prefix, rev)
			tmpfile = Tempfile.new(prefix)
			tmpname = tmpfile.path
			tmpfile.write(self.revision(my))
			tmpfile.close
			file.unlink
			return tmpname
		end
		a = temp("local", my)
		b = temp("remote", other)
		c = temp("parent", base)
		# call out to merge here, return success flag
		cmd = EVN["HGMERGE"]
		r = system("%s %s %s %s" % [cmd, a, b, c])
		if r
			raise "Merge failed, implement rollback!"
		end
		t = self.open(a).read()
		return self.addrevision(t, my, other)
	end
end

# node = Digest::SHA256.hexdigest(n1 + n2 + text)[0..19]