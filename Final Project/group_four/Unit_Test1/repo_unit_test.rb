require 'minitest/autorun'
require './repository.rb'
require 'fileutils'
require './lhs.rb'
include LHS

class RepoUnitTest < Minitest::Test
	def test_all
		FileUtils.rm_rf ".hg/"
		#test for initilaize function of repository
		LHS.init()
		# test for add function for repository
		LHS.add(['./T1.txt'])
		# test for commit function for repository
		LHS.commit()
		File.open(".T1.txt", "w").write("World")
		# test for add function for repository
		LHS.add(['./T1.txt'])
		# test for commit function for repository
		LHS.commit()
		# test for cat function for repository
		assert_equal LHS.cat(["./T1.txt", 0]).to_s, "hello"
		# test for diff function for repository
		LHS.diff([0, 1, "./T1.txt"])
		# test for delete function for repository
		LHS.delete(['./T1.txt'])
		# test for commit function for repository
		LHS.commit()
		# test for heads function for repository
		LHS.heads()		
		# test for log function for repository
		LHS.log()
		# test for diffdir function for repository
		LHS.diffdir()
		LHS.checkout([1])
	end
end