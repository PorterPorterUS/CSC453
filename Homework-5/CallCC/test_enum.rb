require './simple_enum'


# Generator from an Enumerable object
g = SimpleEnum.new(['A', 'B', 'C', 'D'])

puts '------ Test next?() and next() ------'
while g.next?
  puts g.next
end

puts '------ Test each ------'
g.each do |e|
  puts e
end

puts '------ Test with_idx, offset = 0 ------'
aa = g.with_index
while aa.next?
  p aa.next
end

puts '------ Test with_idx, offset = 2 ------'
aa = g.with_index(2)
while aa.next?
  p aa.next
end