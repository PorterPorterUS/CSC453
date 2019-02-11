require 'minitest/autorun'
require './mdiff.rb'

class MdiffTest < Minitest::Test
  def test_mdiff
    assert_equal ["hello\n", "\n", "world\n", "!"], Mdiff.linesplit("hello\n\nworld\n!")
  end

  def test_textdiff
    seq1 = ["a", "b", "c", "e", "h", "j", "l", "m", "n", "p"]
    seq2 = ["b", "c", "d", "e", "f", "j", "k", "l", "m", "r", "s", "t"]
    bin = Mdiff.diff(seq1, seq2)
    assert_equal seq2.join, Mdiff.patch(seq1.join,bin)
    assert_equal '', Mdiff.textdiff("n=n+1\nn=n-1\n","n=n+1\nn=n-1\n")
  end
end