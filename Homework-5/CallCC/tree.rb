require './tree_node'

require 'continuation'

def cntnode(node = nil)
  if node == nil
    0
  else
    1 + cntnode(node.left) + cntnode(node.right)
  end
end

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