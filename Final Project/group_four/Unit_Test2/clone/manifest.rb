dir = File.dirname(__FILE__)
load dir + "/revlog.rb"

class Manifest < Revlog
	def initialize(repo)
		@repo = repo
		super("00manifest.i", "00manifest.d")
	end

	def open(file, mode="r", &block)
		return @repo.open(file, mode, &block)
	end

	def manifest(rev)
		text = self.revision(rev)
        map = Hash.new()
		Mdiff.linesplit(text).each do |l|
			# #TODO: change unhexify
			map[l[41...-1]] = [l[0...40]].pack('H*')
		end
		return map
    end


	def addmanifest(map, p1=nil, p2=nil)
		files = map.keys
		# FILE ,NIL
        files = files.sort()
        text = ""
        files.each do |f|
        	text+=[map[f].unpack('H*').first, f].join(' ') + "\n"
        end
        return self.addrevision(text, p1, p2)
	end

end
