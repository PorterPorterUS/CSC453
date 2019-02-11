dir = File.dirname(__FILE__)
load dir + "/revlog.rb"
require "digest"
require "base64"

class Filelog < Revlog
	def initialize(repo, path)
		@repo = repo
		s = Digest::SHA1.digest(path)
		s = Base64.encode64(s)[0..-4]
		s = s.gsub("\+", "%")
		s = s.gsub("/", "_")
		super(File.join("index/", s), File.join("data/", s))
	end

	def open(file, mode = "r", &block)
		return @repo.open(file, mode, &block)
	end
end