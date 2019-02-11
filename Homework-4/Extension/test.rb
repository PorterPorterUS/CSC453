require './CFixedArray'
require './RubyFixedArray'

puts "\n"
puts '----------------------------------------------------------------------------------------------------------------'

puts 'Test case 1: create two arrays with only one argument.'
ca1  = Hello::CFixedArray.new(5)
ra1 = RubyFixedArray.new(5)
puts 'Test case 1 over.'

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 2: create two arrays with two integer arguments.'
ca2  = Hello::CFixedArray.new(4, 3)
ra2 = RubyFixedArray.new(4, 3)
puts 'Test case 2 over.'

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 3: create two arrays with two float arguments.'
ca3  = Hello::CFixedArray.new(4, 1.5)
ra3 = RubyFixedArray.new(4, 1.5)
puts 'Test case 3 over.'

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 4: create two arrays with two string arguments.'
ca4  = Hello::CFixedArray.new(4, 'hello')
ra4 = RubyFixedArray.new(4, 'hello')
puts 'Test case 4 over.'

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 5: insert 5 and the first place and "good" at the last place to float arrays created in Test case 3.'
ca3.insert(0, 5)
ca3.insert(3, "good")
ra3.insert(0, 5)
ra3.insert(3, "good")
puts 'Test case 5 over.'

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 6: use each to print arrays modified in Test case 5.'
puts 'C implmented array:'
ca3.each do |ele|
	puts ele
end
puts "\n"
puts 'Ruby implementd array:'
ra3.each do |ele|
	puts ele
end

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 7: get sum of arrays created in Test case 2.'
puts 'C implemented array:'
puts ca2.sum
puts "\n"
puts 'Ruby implemented array:'
puts ra2.sum

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 8: create two arrays of length 1000000 with initial value of 253.'
ca8 = Hello::CFixedArray.new(1000000, 253)
ra8 = RubyFixedArray.new(1000000, 253)

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 9: get sum and running time of two arrays created in Test case 8.'
st_ca8 = Time.now
ca8_sum = ca8.sum
et_ca8 = Time.now

st_ra8 = Time.now
ra8_sum = ra8.sum
et_ra8 = Time.now

puts 'Sum of C implemented array: ' + ca8_sum.to_s
puts 'Sum of Ruby implemented array: ' + ra8_sum.to_s
puts "\n"
puts 'Runnimg time of C implemented array: ' + (et_ca8 - st_ca8).to_s
puts 'Runnimg time of Ruby implemented array: ' + (et_ra8 - st_ra8).to_s

puts '----------------------------------------------------------------------------------------------------------------'
puts "\n"

puts 'Test case 10: Compare running time of sum of different size arrays.'
ca10_1 = Hello::CFixedArray.new(1000, 253)
ra10_1 = RubyFixedArray.new(1000, 253)
puts "\n"

st_ca10_1 = Time.now
ca10_1.sum
et_ca10_1 = Time.now

st_ra10_1 = Time.now
ra10_1.sum
et_ra10_1 = Time.now

puts 'Runnimg time of C implemented array: ' + (et_ca10_1 - st_ca10_1).to_s
puts 'Runnimg time of Ruby implemented array: ' + (et_ra10_1 - st_ra10_1).to_s
puts "\n"

ca10_2 = Hello::CFixedArray.new(10000, 253)
ra10_2 = RubyFixedArray.new(10000, 253)
puts "\n"

st_ca10_2 = Time.now
ca10_2.sum
et_ca10_2 = Time.now

st_ra10_2 = Time.now
ra10_2.sum
et_ra10_2 = Time.now

puts 'Runnimg time of C implemented array: ' + (et_ca10_2 - st_ca10_2).to_s
puts 'Runnimg time of Ruby implemented array: ' + (et_ra10_2 - st_ra10_2).to_s
puts "\n"

ca10_3 = Hello::CFixedArray.new(100000, 253)
ra10_3 = RubyFixedArray.new(100000, 253)
puts "\n"

st_ca10_3 = Time.now
ca10_3.sum
et_ca10_3 = Time.now

st_ra10_3 = Time.now
ra10_3.sum
et_ra10_3 = Time.now

puts 'Runnimg time of C implemented array: ' + (et_ca10_3 - st_ca10_3).to_s
puts 'Runnimg time of Ruby implemented array: ' + (et_ra10_3 - st_ra10_3).to_s
puts "\n"



