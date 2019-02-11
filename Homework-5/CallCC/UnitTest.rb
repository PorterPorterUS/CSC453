require "./SimpleEnum"
require "./infiniteIntegers"
require "./ContinuationPassing"

class UnitTest
	def test_SimpleEnum
		puts "The test for SimpleEnum, create a SimpleEnum object named 'testA'"
		array = [1,2,3,4,5]
		testA = SimpleEnum.new(array)
		puts "The test for testA's next? and next"
		i = 0
		while testA.next?
			puts "the " + i.to_s + "th value of testA is " + testA.next.to_s
			i += 1
		end

		puts "The test for testA's with_index, offset is 2"
		enum = testA.with_index(2)
		i = 0
		puts "The new enumerator object named as 'enum'"
		while enum.next?
			puts "the " + i.to_s + "th value of enum is " + enum.next.to_s
			i += 1
		end

		puts "The test for testA's with_index, offset is 0"
		enum = testA.with_index(0)
		i = 0
		puts "The new enumerator object named as 'enum'"
		while enum.next?
			puts "the " + i.to_s + "th value of enum is " + enum.next.to_s
			i += 1
		end

		puts "The test for enum's with_index, offset is 2"
		enum2 = enum.with_index(2)
		i = 0
		puts "The new enumerator object named as 'enum2'"
		while enum2.next?
			puts "the " + i.to_s + "th value of enum2 is " + enum2.next.to_s
			i += 1
		end

		puts "The test for testA's each"
		testA.each {|i| print i.to_s + " "}
		puts ""
	end

	def test_infiniteIntegers
		puts "The test for Infinite Integers"
		testI = InfiniteIntegers.new()
		puts "Show the first 10 number of this enumerator"
		p testI.infiniteIntegers.take(10).to_a
		puts "Show the first 30 number of this enumerator"
		p testI.infiniteIntegers.take(30).to_a
	end

	def test_continuationPassing
		puts "The test for Continuation Passing"
		testF = ContinuationPassing.new()
		puts "The test for factorial function with n = 10"
		puts "The result by simpe recursive methond is " + testF.factorial(10).to_s
		puts "The result by tail recursive methond (pass a continuation) is " + testF.fac_cps(10).to_s
		puts "The test for factorial function with n = 0"
		puts "The result by simpe recursive methond is " + testF.factorial(0).to_s
		puts "The result by tail recursive methond (pass a continuation) is " + testF.fac_cps(0).to_s
		puts "--------------------------------------------------------------------------------------------"
		puts "The test for count BT nodes function"
		root = TreeNode.new(0)
		root.left = TreeNode.new(3)
		root.right = TreeNode.new(4)
		root.right.left = TreeNode.new(4)
		root.left.right = TreeNode.new(5)
		root.left.right.left = TreeNode.new(5)
		puts "By the simple recursive methond, the number of Tree Node is " + testF.count_BT(root).to_s
		puts "By the tail recursive methond, the number of Tree Node is " + testF.countBT_cps(root).to_s
	end

	def test_StopIteration
		puts "The test for StopIteration of SimpleEnum.next"
		array = ['Apple', 'Banana', 'Cherry']
		testB = SimpleEnum.new(array)
		i = 0
		while testB.next?
			puts "the " + i.to_s + "th value of testB is " + testB.next.to_s
			i += 1
		end
		p testB.next
	end
end

unitTest = UnitTest.new()
unitTest.test_SimpleEnum
puts "-----------------------------------------------------------"
unitTest.test_infiniteIntegers
puts "-----------------------------------------------------------"
unitTest.test_continuationPassing
puts "-----------------------------------------------------------"
unitTest.test_StopIteration