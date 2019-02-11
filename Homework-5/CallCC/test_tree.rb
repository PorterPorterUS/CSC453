require 'minitest/autorun'

require './tree'


class CS253EnumTests < Minitest::Test

  def test_tree
    root = TreeNode.new(0)
    root.left = TreeNode.new(3)
    root.right = TreeNode.new(4)
    root.right.left = TreeNode.new(4)
    root.left.right = TreeNode.new(5)
    root.left.right.left = TreeNode.new(5)

    assert_equal cntnode(root), cnt_cps(root)
  end

end