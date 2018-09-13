require 'minitest/autorun'
require './cs253Array.rb'
require './cs253Hash.rb'


class CS253EnumTests < Minitest::Test
    def test_collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
        float_triple = CS253Array.new([-1.6, 1.3, 2.6])

        assert_equal int_triple.cs253collect{|i| i.to_s}.to_a,["1", "2", "3"]
        assert_equal str_triple.cs253collect{|i| i.length}.to_a,[6, 13, 10]
        assert_equal float_triple.cs253collect{|i| i.round}.to_a, [-2, 1, 3]
    end

    def test_inject
        int_triple = CS253Array.new([2, 3, 4])
        str_triple = CS253Array.new(['test', 'anotherTest', 'lastTest'])
        hash_triple = CS253Hash.new.merge!({'first_name' => 'Alan', 'middle_name' => 'Mathison', 'last_name' => 'Turing'})

        assert_equal int_triple.cs253inject{|result, i| result + i}, 9
        assert_equal str_triple.cs253inject{|result, i| result.concat(i)}, 'testanotherTestlastTest'
        assert_equal hash_triple.cs253inject({}){|result, i| result[i.first] = i.last.upcase; result},
                     {'first_name' => 'ALAN', 'middle_name' => 'MATHISON', 'last_name' => 'TURING'}
    end

    def test_select
        int_triple = CS253Array.new([1, 3, 4])
        str_triple = CS253Array.new(['good', 'anotherGood', 'lastGood'])
        hash_triple = CS253Hash.new.merge!({:Joe => 'male', :Jim => 'male', :Patty => 'female'})


        assert_equal int_triple.cs253select{|i| i.odd?}, [1, 3]
        assert_equal str_triple.cs253select{|i| i.length > 6}, ['anotherGood', 'lastGood']
        assert_equal hash_triple.cs253select{|_, i| i == 'male'}, [[:Joe, 'male'], [:Jim, 'male']]
    end

    def test_max
        int_triple = CS253Array.new([-1, 0, 1])
        str_triple = CS253Array.new(['better', 'anotherBetter', 'lastBetter'])
        float_triple = CS253Array.new([2, -3.5, 1.1])

        assert_equal int_triple.cs253max{|a, b| a <=> b}, 1
        assert_equal str_triple.cs253max{|a, b| a.length <=> b.length}, 'anotherBetter'
        assert_equal float_triple.cs253max{|a, b| a ** 2 <=> b ** 2}, -3.5
    end

    def test_max_by
        int_triple = CS253Array.new([10, 20, 30])
        str_triple = CS253Array.new(['best', 'anotherBest', 'lastBest'])
        hash_triple = CS253Hash.new.merge!({:front => 'a', :middle => 'k', :end => 'z'})

        assert_equal int_triple.cs253max_by{|i| i}, 30
        assert_equal str_triple.cs253max_by{|i| i.length}, 'anotherBest'
        assert_equal hash_triple.cs253max_by{|i| i.last}, [:end, 'z']
    end
end



