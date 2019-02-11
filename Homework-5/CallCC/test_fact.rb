require 'minitest/autorun'

require './fact'


class CS253EnumTests < Minitest::Test

  def test_fact
    assert_equal factorial(0), fact_cps(0)
    assert_equal factorial(1), fact_cps(1)
    assert_equal factorial(4), fact_cps(4)
    assert_equal factorial(10), fact_cps(10)
  end

end