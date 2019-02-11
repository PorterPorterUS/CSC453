require './simple_enum'

require 'continuation'

require './tree_node'

# Generator from an Enumerable object
# g = SimpleEnum.new(['A', 'B', 'C', 'D'])

# while g.next?
#   puts g.next
# end
#
# # Generator from a block
# g = SimpleEnum.new { |g|
#   for i in 'A'..'C'
#     g.yield i
#   end
#
#   g.yield 'Z'
# }
#
# The same result as above
# while g.next?
#   puts g.next
# end

# g.each do |e|
#   puts e
# end


# aa = g.with_index
# p aa.next
# p aa.next
# p g.next

# while aa.next?
#   p aa.next
# end


# fib = Enumerator.new do |y|
#   a = 0
#   loop do
#     y << a
#     a = a + 1
#   end
# end
#
# (0..50000).step(1) do |i|
#   p fib.next
# end


def factorial(n)
  return 1 if n == 0
  n * factorial(n - 1)
end

# def fac_cps(n, c = callcc{|c| c}, acc = 1)
#   return acc if n == 0
#   cont = callcc{|c| c}
#   # #if cont
#   #   fac_cps(n - 1, nil, n * acc)
#   # #end
# end

# def fac_cps(n)
#   return 1 if n == 0
#   cont = callcc{|c|
#     acc = n
#     cnt = 1
#     while true
#       c.call(acc * cnt) if cnt == acc
#       p [cnt, acc]
#       cnt += 1
#     end
#     acc
#   }
# end

# def fac_cps(n, c = callcc{|k| [ n, 1, k ]})
#   (n, f, k) = c
#   if n == 0
#     f
#   else
#     k.call(n-1, n*f, k)
#   end
# end

# def fac_cps(n)
#   (n, f, k) = callcc { |k| [ n, 1, k ] }
#   if n == 0
#     f
#   else
#     k.call(n-1, n*f, k)
#   end
# end

# def fac_cps(n, c = lambda{|v| v})
#   return c.call(1) if n == 0
#   fac_cps(n - 1, lambda{|v| c.call(n * v)})
# end
#

def fac_cps(n, c = callcc{|k| [n, 1, k]})
  (n, f, k) = c
  if n == 0
    f
  else
    k.call(n - 1, n * f, k)
  end
end

# puts factorial(4)

# puts fac_cps(4, callcc{|v| v}, 1)

# puts fac_cps(4)


root = TreeNode.new(0)
root.left = TreeNode.new(1)
root.right = TreeNode.new(2)
root.right.left = TreeNode.new(3)
root.left.right = TreeNode.new(4)
root.left.right.left = TreeNode.new(5)

def cntnode(node = nil)
  if node == nil
    0
  else
    1 + cntnode(node.left) + cntnode(node.right)
  end
end

# def cnt_cps(node, c = callcc{|k| [node, 0, k]})
#   (node, f, k) = c
#   if node == nil
#     f
#   else
#     k.call(node.left, 1 + f, k)
#   end
# end

# def cnt_cps(node = nil, c = callcc{|k| [node, 0, k]})
#   (node, f, k) = c
#   if node == nil
#     puts 'n'
#     f
#   else
#     k.call(node.left, 1 + f, k)
#   end
# end

def cnt_cps(node = nil,c = callcc{|c| c})
  if c.is_a?(Integer)
    return c
  end
  if node == nil
    c.call(0)
  else
    if left_cont = callcc{|c| c}
      cnt_cps(node.left, left_cont)
    end
    if right_cont = callcc{|c| c}
      cnt_cps(node.right, right_cont)
    end
    acc = right_cont + left_cont + 1
    c.call(acc)
  end
end


# def cnt_cps(node, acc = 1)
#   if node == nil
#     0
#   else
#     stack = [node]
#     while stack.length > 0
#       cur = stack.pop
#       if cur.left
#         stack << cur.left
#         acc += 1
#       end
#       if cur.right
#         stack << cur.right
#         acc += 1
#       end
#     end
#     acc
#   end
# end




puts cntnode(root)

puts cnt_cps(root)