require './revlog.rb'
require './changelog.rb'
require './manifest.rb'
require './filelog.rb'
require './repository.rb'

module LHS
	def init()
		@repo = Repository.new(".", 1)
		return @f
		return @repo
	end

	def add(args = nil)
		if args.length
			checkFile(args)
			@repo.add(args)
		end
		return @repo
	end

	def delete(args = nil)
		if args.length
			checkFile(args)
			@repo.delete(args)
		end
		return @repo
	end
	def checkFile(args)
		args.each do |file|
			if not File.file?(file)
				raise IOError, "This file not exits: %s, you should first create this file in this diractory" % file
			end
		end
	end
	def commit()
		@repo.commit()
		return @repo
    end

    def diff(args)
    	r1 = args[0].to_i
    	r2 = args[1].to_i
    	file = args[2].to_s
    	@repo.diff(r1, r2, file)
    	return @repo
    end

    def cat(args)
    	file = args[0].to_s
    	r = args[1].to_i
    	@repo.cat(file, r)
    end

    def heads
		i = @repo.changelog.tip
		changes = @repo.changelog.changeset(i)
		(p1, p2) = @repo.changelog.parents(i)
		puts "%d: %d %d %s" % [i, p1, p2, @repo.changelog.node(i).unpack('H*').first]
		puts "manifest nodeid: %s" % changes[0].unpack('H*').first
		puts "User: %s" % changes[1]
		puts "changed files: "
		changes[3].each do |f|
			puts f
		end
		puts "description: %s"% changes[4]
    end

    def log
    	for i in (0...@repo.changelog.tip + 1)
		    changes = @repo.changelog.changeset(i)
		    (p1, p2) = @repo.changelog.parents(i)
		    puts "%d: %d %d %s" % [i, p1, p2, @repo.changelog.node(i).unpack('H*').first]
		    puts "manifest nodeid: " % changes[0].unpack('H*').first
		    puts "User: %s" % changes[1]
		    puts "changed files: "
		    changes[3].each do |f|
		      puts f
		    end
		    puts "description: %s"% changes[4]
  		end
   	end

   	def diffdir
   		@repo.diffdir(@repo.root)
   		return @repo
   	end

   	def checkout(args)
		rev = @repo.changelog.tip
		if args.length
			rev = args[0].to_i
		end
		@repo.checkout(rev)
	end
end