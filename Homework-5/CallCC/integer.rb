integer = Enumerator.new do |y|
  a = 0
  loop do
    y << a
    a = a + 1
  end
end

(0..50000).step(1) do |i|
  p integer.next
end