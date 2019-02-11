dir = File.dirname(__FILE__)
require dir + "/manifest"
require dir + "/changelog"
require dir + "/filelog"
require dir + "/walk"
require "fileutils"


class Repository
	attr_accessor :root
	attr_accessor :path
	attr_accessor :manifest
	attr_accessor :changelog
	attr_accessor :current
	attr_accessor :indexfile
	attr_accessor :datafile
	attr_accessor :nodemap
	attr_accessor :index
	def initialize(path = nil, create = 0)
		if path.nil?
			cur = Dir.pwd
			while not File.directory?(File.join(cur, ".hg"))
				cur = File.dirname(cur)
				if cur == "/"
					raise "No repo found"
				end
			end
			path = cur
		end


		@root = path
		@path = File.join(path, ".hg")

		if create == 1
			Dir.mkdir(@path)
			Dir.mkdir(File.join(@path, "data"))
			Dir.mkdir(File.join(@path, "index"))
		end


		@manifest = Manifest.new(self)
		@changelog = Changelog.new(self)

		begin
			@current = (File.read(self.open("current"))).to_i
		rescue
			@current = nil
		end

	end
	def open(path, mode="r", &block)
		f = self.join(path)
		if mode.eql?('a') && File.file?(f)
			s = File::stat(f)
			# p "nlink", s.nlink
			if s.nlink > 1
				# File.open(f + ".tmp", "w").write(File.open(f).read())
				File.open(f + ".tmp", "w") {|file| file.write(File.read(f))}
				FileUtils.mv(f + ".tmp", f)
				# File.rename(f + ".tmp", f)
			end
		end
		return File.open(self.join(path), mode, &block)
	end

	def join(f)
		return File.join(@path, f)
	end

	def file(f)
		return Filelog.new(self, f)
	end

	def commit()
		begin
			update = []
			for l in self.open("to-add")
				update << l[0...-1]
			end
		# update = [l[:-1] for l in open("to-add")]

		rescue 
			update = []
		end
		begin
			delete = []
			for l in self.open("to-delete")
				delete << l[0...-1]
			end
			# delete = [l[:-1] for l in open("to-delete")]
		rescue 
			delete = []
		end

		newFiles = Hash.new
		for f in update
			# p f
			r = Filelog.new(self, f)
			t = File.read(f)
			# p t
			r.addrevision(t)
			newFiles[f] = r.node(r.tip())
		end

		old = @manifest.manifest(@manifest.tip())

		old.update(newFiles)
		for f in delete
			old.delete(f)
		end

		rev = @manifest.addmanifest(old)

		newFiles = newFiles.keys
		newFiles = newFiles.sort
		n = @changelog.addchangeset(@manifest.node(rev), newFiles, "commit")
		@current = n
		self.open("current", "w") {|file| file.write(@current.to_s)}
		# self.open("current", "w").write(@current.to_s)

		if not update.empty?
			File.unlink(self.join("to-add"))
		end

		if not delete.empty?
			File.unlink(self.join("to-delete"))
		end
	end

	def checkdir(path)
		d = File.dirname(path)
		if not d
			return
		end

		if not File.directory?(d)
			self.checkdir(d)
			Dir.mkdir(d)
		end
	end

	def checkout(rev)
		 change = @changelog.changeset(rev)
		 mnode = change[0]
		 mmap = @manifest.manifest(@manifest.rev(mnode))

		 st = self.open("dircache", "w")
		 l = mmap.keys 
		 l = l.sort
		 for f in l
		 	r = Filelog.new(self, f)
		 	t = r.revision(r.rev(mmap[f]))
		 	begin
		 		File.open(f, "w"){|file| file.write(t)}
		 	rescue
		 		self.checkdir(f)
		 		File.open(f, "w"){|file| file.write(t)}
		 	end

		 	s = File::stat(f)
		 	e = [s.mode, s.size, s.mtime.to_i, f.length]
		 	e = e.pack("l>l>l>l>")
		 	st.write(e + f)
		 end

		 @current = change
		 self.open("current", "w"){|file| file.write(@current.to_s)}

	end
 	
	def diffdir(path)
		st = File.read(open("dircache"))
		dc = Hash.new
		pos = 0

		while pos < st.length
			e = st[pos...pos+16].unpack("l>l>l>l>")
			l = e[3]
			pos += 16
			f = st[pos...pos + l]
			dc[f] = e[0...3]
			pos += l
		end

		changed = []
		added = []

		Walk.walk(@root).each do |dir, subdir, files|
			# p dir
			# p @root
			d = dir[@root.length+1..-1]
			# p d
			if subdir.include?'.hg'
				subdir.delete('.hg')
			end
			# p subdir
			# p d
			# if dir == nil
			# 	break
			# end
			# p files
			for f in files
				if d == nil
					fn = f
				else
					fn = File.join(d, f)
				end

				s = File::stat(fn)
				if dc.has_key?(fn)
					c = dc[fn]
					# p "Commit " + fn
					dc.delete(fn)
					if c[1] != s.size
						changed << fn
						p "C " + fn
					elsif (not c[0].eql?(s.mode)) or (c[2] != s.mtime.to_i)
						t1 = File.read(fn)
						t2 = self.file(fn).revision(@current)
						if not t1.eql?(t2)
							changed << fn
							p "C " + fn
						end
					end
				else
					added << f
					p "A " + fn
				end
			end
		end

		deleted = dc.keys
		deleted = deleted.sort
		for f in deleted
			p "D " + f
		end

	end

	def add(list)
		al = self.open("to-add", "a")
		st = self.open("dircache", "a")
		# 
		for f in list
			al.write(f + "\n")
			s = File::stat(f) 
			e = [s.mode, s.size, s.mtime.to_i, f.length]
			e = e.pack("l>l>l>l>")
			st.write(e + f)
		end
		al.close()
		st.close()
	end

	def delete(list)
		dl = self.open("to-delete", "a")
		for f in list
			dl.write(f + "\n")
		end
	end

	def diff(rev1, rev2, f)
		r = Filelog.new(self, f)

		change1 = @changelog.changeset(rev1)
		mnode1 = change1[0]
		mmap1 = @manifest.manifest(@manifest.rev(mnode1))
		text1 = r.revision(r.rev(mmap1[f]))

		change2 = @changelog.changeset(rev2)
		mnode2 = change2[0]
		mmap2 = @manifest.manifest(@manifest.rev(mnode2))
		text2 = r.revision(r.rev(mmap2[f]))
        diff = Diff::LCS.sdiff(Mdiff.linesplit(text1), Mdiff.linesplit(text2))
		diff.each do |e|
			p e
		end
	end


	def cat(file, rev)

		change = @changelog.changeset(rev)
		mnode = change[0]
		mmap = @manifest.manifest(@manifest.rev(mnode))
		r = Filelog.new(self, file)
		text = r.revision(r.rev(mmap[file]))
  #       p "file", file
		# p "rev" ,rev
		return text
	end

	# TODO defaut target source
	def clone(org_dir = nil, new_dir)
		# org_dir .hg clone new_dir
		# 1. new_dir is
		# allow user only enter the directory which he/she wants to clone to
		if org_dir.nil?
			org_dir = Dir.pwd
		end
		if File.directory?(File.join(org_dir, ".hg"))
			if not File.directory?(File.join(new_dir, ".hg"))
				FileUtils.cp_r(org_dir, new_dir)
				p "Copied!!!"
			else
				p "Ops, you already have a repository in " + new_dir
			end
		else
			p "Ops, you dont's have a repository in " + old_dir
		end
	end
	# def clone(org_dir, new_dir)
	# 	FileUtils.cp_r(org_dir, new_dir)
	# 	p "Copied!!!"
	# end

	def merge(other)
		changed = Hash.new()
		newOne = Hash.new()

		accumulate = proc do (text)
			files = @changelog.extract(text)[3]
			for f in files
				puts " ", f, "changed"
				changed[f] = 1
			end
		end

		# begin the import/merge of changesets
		puts "Begin merge changeset"
		(co, cn) = self.changelog.mergedag(other.changelog, &accumulate)

		if co == cn
			return
		end

		changed = changed.keys
		changed = changed.sort

		# merge all files changed by the changesets,
	       # keeping track of the new tips
		for f in changed
			puts "now merging", f
			f1 = Filelog.new(self, f)
			f2 = Filelog.new(other, f)
			rev = f1.merge(f2)
			if rev
				newOne[f] = f1.node(rev)
			end
		end

		# begin the merge of the manifest
		puts "Begin merge manifest"
		(mm, mo) = @manifest.mergedag(other.manifest)
		ma = @manifest.ancestor(mm, mo)

		# resolve the manifest to point to all the merged files
	       puts "Begin resolve manifests"
	       mmap = @manifest.manifest(mm) # mine
	       omap = @manifest.manifest(mo) # other
	       amap = @manifest.manifest(ma) # ancestor
	       nmap = Hash.new()

	       mmap.each_value do |pair|
	       	f = pair[0]
	       	mid = pair[1]
	       	if f === omap
	       		if mid != omap[f]
	       			if newOne.has_key?("f")
	       				nmap[f] = newOne[f]
	       			else
	       				# newOne[f] = mid
	       				nmap[f] = mid
					end
				else
					if newOne.has_key?("f")
						nmap[f] = newOne[f]
					else
						# newOne[f] = mid
						nmap[f] = mid
					end
	       		end
	       		omap.delete(f)
	       	elsif f === amap
	       		if mid != amap[f]
	       		else
	       		end
	       	else
	       		if newOne.has_key?("f")
	       			nmap[f] = newOne[f]
				else
					# newOne[f] = mid
	       			nmap[f] = mid
	       		end
	       	end
	       end

	       mmap = nil

	       omap.each_value do |pair|
	       	f = pair[0]
	       	oid = pair[0]
	       	if f === amap
	       		if oid != amap[f]
	       		else
	       		end
	       	else
	       		if newOne.has_key?("f")
	       			nmap[f] = newOne[f]
	       		else
	       			# remote created it
					# newOne[f] = oid
	       			nmap[f] = oid
	       		end
	       	end
	       end

	       omap = nil
	       amap = nil

	       nm = @manifest.addmanifest(nmap, mm, mo)
	       node = @manifest.node(nm)

	       puts "Committing merge changeset"
	       newOne = newOne.keys
	       newOne = newOne.sort
	       if co == cn
	       	cn = -1
	       end

	       @changelog.addchangeset(node, newOne, "merge", co, cn)
	end

end

# stub: files that only contains name and return types of the methods,
# so we can test our own module without after other people finished