require 'minitest/autorun'
require './cs253Array.rb'
require './triple.rb'

class CS253EnumTests < Minitest::Test
    def test_all?
        int_triple = CS253Array.new([-1, 0, 1])
        str_triple = CS253Array.new(['I', 'you', 'he', 'she'])
        float_triple = CS253Array.new([-1.4, 3.11, 4.6])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253all?{|i| i > 0}, int_triple.all?{|i| i > 0})
        assert_equal(str_triple.cs253all?{|i| i.length > 2}, str_triple.all?{|i| i.length > 2})
        assert_equal(float_triple.cs253all?{|i| i.round(1) == i}, float_triple.all?{|i| i.round(1) == i})
        assert_equal(nil_triple.cs253all?{|i| i < 0}, nil_triple.all?{|i| i < 0})
        assert_equal(cus_triple.cs253all?{|i| i > 0}, cus_triple.all?{|i| i > 0})
    end

    def test_any?
        int_triple = CS253Array.new([-2, 1, 2])
        str_triple = CS253Array.new(['ruby', 'python', 'java'])
        float_triple = CS253Array.new([-2.7, 4.1, 5.2])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253any?{|i| i > 1}, int_triple.any?{|i| i > 0})
        assert_equal(str_triple.cs253any?{|i| i.length > 7}, str_triple.any?{|i| i.length > 7})
        assert_equal(float_triple.cs253any?{|i| (i * 10) % 2 == 0}, float_triple.cs253any?{|i| (i * 10) % 2 == 0})
        assert_equal(nil_triple.cs253any?{|i| i < 0}, nil_triple.any?{|i| i < 0})
        assert_equal(cus_triple.cs253any?{|i| i > 0}, cus_triple.any?{|i| i > 0})
    end

    def test_chunk
        int_triple = CS253Array.new([1, 2, 4, 7, 8])
        str_triple = CS253Array.new(['machine learning', 'deep learning', 'reinforcement learn'])
        float_triple = CS253Array.new([-2.7, 4.1, 5.2, 4.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253chunk{|i| i.even?}.to_a, int_triple.chunk{|i| i.even?}.to_a)
        assert_equal(str_triple.cs253chunk{|i| i.include?('learning')}.to_a, str_triple.chunk{|i| i.include?('learning')}.to_a)
        assert_equal(float_triple.cs253chunk{|i| i > 3 and i < 5}.to_a, float_triple.chunk{|i| i > 3 and i < 5}.to_a)
        assert_equal(nil_triple.cs253chunk{|i| i > 0}.to_a, nil_triple.chunk{|i| i > 0}.to_a)
        assert_equal(cus_triple.cs253chunk{|i| i > 0}.to_a, cus_triple.chunk{|i| i > 0}.to_a)
    end

    def test_chunk_while
        int_triple = CS253Array.new([19, 16, 15, 11, 10, 9, 2, 1])
        str_triple = CS253Array.new(['too', 'many', 'functions', 'to', 'be', 'implemented', 'this', 'time'])
        float_triple = CS253Array.new([-1, -2, -3, 0, 2, 3, -4, -1, 2])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.chunk_while{|i, j| i - 1 == j}.to_a, int_triple.cs253chunk_while{|i, j| i - 1 == j}.to_a)
        assert_equal(str_triple.cs253chunk_while{|i, j| i.include?('t') and j.include?('t')}.to_a, str_triple.chunk_while{|i, j| i.include?('t') and j.include?('t')}.to_a)
        assert_equal(float_triple.cs253chunk_while{|i, j| i + j < 0}.to_a, float_triple.chunk_while{|i, j| i + j < 0}.to_a)
        assert_equal(nil_triple.cs253chunk_while{|i, j| i + j > 0}.to_a, nil_triple.chunk_while{|i, j| i + j > 0}.to_a)
        assert_equal(cus_triple.cs253chunk_while{|i, j| i + j > 0}.to_a, cus_triple.chunk_while{|i, j| i + j > 0}.to_a)
    end

    def test_collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(['string', 'anotherString', 'lastString'])
        float_triple = CS253Array.new([-1.4, 2.3, 4.2])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253collect{|i| i.to_s}.to_a, int_triple.collect{|i| i.to_s}.to_a)
        assert_equal(str_triple.cs253collect{|i| i.length}.to_a, str_triple.collect{|i| i.length}.to_a)
        assert_equal(float_triple.cs253collect{|i| i.round}.to_a, float_triple.collect{|i| i.round}.to_a)
        assert_equal(nil_triple.cs253collect{|i| i < 0}.to_a, nil_triple.cs253collect{|i| i < 0}.to_a)
        assert_equal(cus_triple.cs253collect{|i| i < 0}.to_a, cus_triple.cs253collect{|i| i < 0}.to_a)
    end

    def test_collect_concat
        int_triple = CS253Array.new([1, 3, 5, 7])
        str_triple = CS253Array.new(['less', 'functions', 'next', 'time'])
        float_triple = CS253Array.new([[-10.5, 20.1], [-15.8, 30.4]])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(float_triple.cs253collect_concat{|i| i + [50.5]}, float_triple.collect_concat{|i| i + [50.5]})
        assert_equal(str_triple.cs253collect_concat{|i| [i, ' ']}, str_triple.collect_concat{|i| [i, ' ']})
        assert_equal(int_triple.cs253collect_concat{|i| [i, i ** 2]}, int_triple.collect_concat{|i| [i, i ** 2]})
        assert_equal(nil_triple.cs253collect_concat{|i| [i, 100]}, nil_triple.collect_concat{|i| [i, 100]})
        assert_equal(cus_triple.cs253collect_concat{|i| [i, 100]}, cus_triple.collect_concat{|i| [i, 100]})
    end

    def test_count
        int_triple = CS253Array.new([1, 3, 5, 3])
        str_triple = CS253Array.new(['test', 'this', 'string', 'case'])
        float_triple = CS253Array.new([-10.1, nil, 10.2])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253count(3), int_triple.count(3))
        assert_equal(str_triple.cs253count{|i| i.length > 4}, str_triple.count{|i| i.length > 4})
        assert_equal(float_triple.cs253count(nil), float_triple.count(nil))
        assert_equal(nil_triple.cs253count{|i| i > 0}, nil_triple.count{|i| i > 0})
        assert_equal(cus_triple.cs253count{|i| i > 0}, cus_triple.count{|i| i > 0})
    end

    def test_cycle
        int_triple = CS253Array.new([1, 3, 5, 3])
        str_triple = CS253Array.new(['a', 'b', 'c'])
        float_triple = CS253Array.new([1.2, 1.3, 2.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        cs_res, res = [], []; int_triple.cs253cycle(3){|i| cs_res << i}; int_triple.cycle(3){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; str_triple.cs253cycle(2){|i| cs_res << i.length}; str_triple.cycle(2){|i| res << i.length}; assert_equal(cs_res, res)
        cs_res, res = [], []; float_triple.cs253cycle(4){|i| cs_res << i.round}; float_triple.cycle(4){|i| res << i.round}; assert_equal(cs_res, res)
        cs_res, res = [], []; nil_triple.cs253cycle(2){|i| cs_res << i}; nil_triple.cycle(2){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; cus_triple.cs253cycle(2){|i| cs_res << i}; cus_triple.cycle(2){|i| res << i}; assert_equal(cs_res, res)
    end

    def test_detect
        int_triple = CS253Array.new([1, 3, 5, 3])
        str_triple = CS253Array.new(['detect', 'the', 'hello', 'string'])
        float_triple = CS253Array.new([1.1, 2.2, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253detect{|i| i % 5 == 0}, int_triple.detect{|i| i % 5 == 0})
        assert_equal(str_triple.cs253detect{|i| i == 'hello'}, str_triple.detect{|i| i == 'hello'})
        assert_nil(float_triple.cs253detect(lambda {puts 'No found'}){|i| i > 4})
        assert_nil(nil_triple.cs253detect(lambda {puts 'No found'}){|i| i < 0})
        assert_nil(cus_triple.cs253detect(lambda {puts 'No found'}){|i| i < 0})
    end

    def test_drop
        int_triple = CS253Array.new([1, 3, 5, 3])
        str_triple = CS253Array.new(['drop', 'the', 'first', 'string'])
        float_triple = CS253Array.new([1.1, 2.2, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253drop(0), int_triple.drop(0))
        assert_equal(str_triple.cs253drop(1), str_triple.drop(1))
        assert_equal(float_triple.cs253drop(3), float_triple.drop(3))
        assert_equal(nil_triple.cs253drop(1), nil_triple.drop(1))
        assert_equal(cus_triple.cs253drop(1), cus_triple.drop(1))
    end

    def test_drop_while
        int_triple = CS253Array.new([1, 3, 5, 3])
        str_triple = CS253Array.new(['drop', 'string', 'length', 'larger', 'than', 'four'])
        float_triple = CS253Array.new([1.2, 2.3, 3.4])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253drop_while{|i| i > 3}, int_triple.drop_while{|i| i > 3})
        assert_equal(str_triple.cs253drop_while{|i| i.length > 4}, str_triple.drop_while{|i| i.length > 4})
        assert_equal(float_triple.cs253drop_while{|i| i < 4}, float_triple.drop_while{|i| i < 4})
        assert_equal(nil_triple.cs253drop_while{|i| i == 0}, nil_triple.cs253drop_while{|i| i == 0})
        assert_equal(cus_triple.cs253drop_while{|i| i == 0}, cus_triple.cs253drop_while{|i| i == 0})
    end

    def test_each_cons
        int_triple = CS253Array.new([1, 2, 3, 4, 5])
        str_triple = CS253Array.new(['define', 'a', 'new', 'string'])
        float_triple = CS253Array.new([-1.1, 0.5, 2.2])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        cs_res, res = [], []; int_triple.cs253each_cons(3){|i| cs_res << i}; int_triple.each_cons(3){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; str_triple.cs253each_cons(4){|i| cs_res << i}; str_triple.each_cons(4){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; float_triple.cs253each_cons(1){|i| cs_res << (i << 0)}; float_triple.each_cons(1){|i| res << (i << 0)}; assert_equal(cs_res, res)
        cs_res, res = [], []; nil_triple.cs253each_cons(2){|i| cs_res << i}; nil_triple.each_cons(2){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; cus_triple.cs253each_cons(2){|i| cs_res << i}; cus_triple.each_cons(2){|i| res << i}; assert_equal(cs_res, res)
    end

    def test_each_entry
        int_triple = CS253Array.new([1, 2, 3, 4])
        str_triple = CS253Array.new(['different', 'from', 'each', '?'])
        float_triple = CS253Array.new([-9.9, 9.9, -10.5, 10.5])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        cs_res, res = [], []; int_triple.cs253each_entry{|i| cs_res << i}; int_triple.each_entry{|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; str_triple.cs253each_entry{|i| cs_res << i.length}; str_triple.each_entry{|i| res << i.length}; assert_equal(cs_res, res)
        assert_equal(float_triple.cs253each_entry{|i| i < 1}, float_triple.each_entry{|i| i < 1}.to_a)
        assert_equal(nil_triple.cs253each_entry{|i| i > 0}, nil_triple.each_entry{|i| i > 0}.to_a)
        assert_equal(cus_triple.cs253each_entry{|i| i > 0}, cus_triple.each_entry{|i| i > 0}.to_a)
    end

    def test_each_slice
        int_triple = CS253Array.new([1, 3, 5, 7, 9, 11, 13])
        str_triple = CS253Array.new(['similar', 'to', 'each', 'cons'])
        float_triple = CS253Array.new([-1.11, 0.55, 2.22])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        cs_res, res = [], []; int_triple.cs253each_slice(3){|i| cs_res << i}; int_triple.each_slice(3){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; str_triple.cs253each_slice(2){|i| cs_res << i}; str_triple.each_slice(2){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; float_triple.cs253each_slice(1){|i| cs_res << (i << 0)}; float_triple.each_slice(1){|i| res << (i << 0)}; assert_equal(cs_res, res)
        cs_res, res = [], []; nil_triple.cs253each_slice(2){|i| cs_res << i}; nil_triple.each_slice(2){|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; cus_triple.cs253each_slice(2){|i| cs_res << i}; cus_triple.each_slice(2){|i| res << i}; assert_equal(cs_res, res)
    end

    def test_each_with_index
        int_triple = CS253Array.new([1, 3, 5])
        str_triple = CS253Array.new(['hello', 'ruby', 'Programming'])
        float_triple = CS253Array.new([-2.5, -1.3, 4.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        cs_res, res = [], []; int_triple.cs253each_with_index{|e, i| cs_res << [e, i]}; int_triple.each_with_index{|e, i| res << [e, i]}; assert_equal(cs_res, res)
        cs_res, res = [], []; str_triple.cs253each_with_index{|e, i| cs_res << {i => e}}; str_triple.each_with_index{|e, i| res << {i => e}}; assert_equal(cs_res, res)
        cs_res, res = [], []; float_triple.cs253each_with_index{|e, i| cs_res << (e + i)}; float_triple.each_with_index{|e, i| res << (e + i)}; assert_equal(cs_res, res)
        cs_res, res = [], []; nil_triple.cs253each_with_index{|e, i| cs_res << (e * i)}; nil_triple.each_with_index{|e, i| res << (e * i)}; assert_equal(cs_res, res)
        cs_res, res = [], []; cus_triple.cs253each_with_index{|e, i| cs_res << (e * i)}; cus_triple.each_with_index{|e, i| res << (e * i)}; assert_equal(cs_res, res)
    end

    def test_each_with_object
        int_triple = CS253Array.new([1, 3, 5])
        str_triple = CS253Array.new(['what', 'is', 'this', 'object'])
        float_triple = CS253Array.new([2.0, 3.0, 4.0])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253each_with_object([]){|i, a| a << 3 * i}, int_triple.each_with_object([]){|i, a| a << 3 * i})
        assert_equal(str_triple.cs253each_with_object([]){|i, a| a << i.upcase}, str_triple.each_with_object([]){|i, a| a << i.upcase})
        assert_equal(float_triple.cs253each_with_object([]){|i, a| a << i.round.even?}, float_triple.each_with_object([]){|i, a| a << i.round.even?})
        assert_equal(nil_triple.cs253each_with_object([]){|i, a| a << i}, nil_triple.each_with_object([]){|i, a| a << i})
        assert_equal(cus_triple.cs253each_with_object([]){|i, a| a << i}, cus_triple.each_with_object([]){|i, a| a << i})
    end

    def test_entries
        int_triple = CS253Array.new([2, 4, 5])
        str_triple = CS253Array.new(['what', 'is', 'this', 'object'])
        float_triple = CS253Array.new([2.0, 3.0, 4.0])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253entries, int_triple.entries)
        assert_equal(str_triple.cs253entries, str_triple.entries)
        assert_equal(float_triple.cs253entries, float_triple.entries)
        assert_equal(nil_triple.cs253entries, nil_triple.entries)
        assert_equal(cus_triple.cs253entries, cus_triple.entries)
    end

    def test_find
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        str_triple = CS253Array.new(['it', 'is', 'the', 'same', 'as', 'detect'])
        float_triple = CS253Array.new([2.2, 3.3, 4.4])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253find{|i| i % 2 == 0 and i % 5 == 0}, int_triple.find{|i| i % 2 == 0 and i % 5 == 0})
        assert_equal(str_triple.cs253find{|i| i.length > 2}, str_triple.find{|i| i.length > 2})
        assert_equal(float_triple.cs253find{|i| i > 2}, float_triple.find{|i| i > 2})
        assert_equal(nil_triple.cs253find(lambda {0}){|i| i == 0}, nil_triple.find(lambda {0}){|i| i == 0})
        assert_equal(cus_triple.cs253find(lambda {0}){|i| i == 0}, cus_triple.find(lambda {0}){|i| i == 0})
    end

    def test_find_all
        int_triple = CS253Array.new([1, 2, 3, 4])
        str_triple = CS253Array.new(['it', 'is', 'similar', 'to', 'select'])
        float_triple = CS253Array.new([-2.2, 3.3, -4.4])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253find_all{|i| i.odd?}, int_triple.find_all{|i| i.odd?})
        assert_equal(str_triple.cs253find_all{|i| i.length > 3}, str_triple.find_all{|i| i.length > 3})
        assert_equal(float_triple.cs253find_all{|i| i.abs == i}, float_triple.find_all{|i| i.abs == i})
        assert_equal(nil_triple.cs253find_all{|i| i > 0}, nil_triple.find_all{|i| i > 0})
        assert_equal(cus_triple.cs253find_all{|i| i > 0}, cus_triple.find_all{|i| i > 0})
    end

    def test_find_index
        int_triple = CS253Array.new([1, 2, nil, 4])
        str_triple = CS253Array.new(['find', 'index', 'not', 'the', 'value'])
        float_triple = CS253Array.new([1.5, 3.2, 9.8])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253find_index{|i| i == nil}, int_triple.find_index{|i| i == nil})
        assert_equal(str_triple.cs253find_index{|i| i.length == 3}, str_triple.find_index{|i| i.length == 3})
        assert_equal(float_triple.cs253find_index(3.2), float_triple.find_index(3.2))
        assert_equal(nil_triple.cs253find_index{|i| i == 1}, nil_triple.find_index{|i| i == 1})
        assert_equal(cus_triple.cs253find_index{|i| i == 1}, cus_triple.find_index{|i| i == 1})
    end

    def test_first
        int_triple = CS253Array.new([1, 2, 3, 4])
        str_triple = CS253Array.new(['get', 'the', 'first', 'element'])
        float_triple = CS253Array.new([1.5, 1.6, 1.7])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253first, int_triple.first)
        assert_equal(str_triple.cs253first(0), str_triple.first(0))
        assert_equal(float_triple.cs253first(4), float_triple.first(4))
        assert_equal(nil_triple.cs253first(1), nil_triple.first(1))
        assert_equal(cus_triple.cs253first(1), cus_triple.first(1))
    end

    def test_flat_map
        int_triple = CS253Array.new([1, 2, 3, 4])
        str_triple = CS253Array.new([['get', 'the'], ['first', 'element']])
        float_triple = CS253Array.new([1.5, 1.6, 1.7])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253flat_map{|i| [i, i * 2]}, int_triple.flat_map{|i| [i, i * 2]})
        assert_equal(str_triple.cs253flat_map{|i| i + ['go']}, str_triple.flat_map{|i| i + ['go']})
        assert_equal(float_triple.cs253flat_map{|i| [i ** 2]}, float_triple.flat_map{|i| [i ** 2]})
        assert_equal(nil_triple.cs253flat_map{|i| [i]}, nil_triple.flat_map{|i| [i]})
        assert_equal(cus_triple.cs253flat_map{|i| [i]}, cus_triple.flat_map{|i| [i]})
    end

    def test_grep
        int_triple = CS253Array.new([1, 10, 100, 1000])
        str_triple = CS253Array.new(['a','1','b','2'])
        float_triple = CS253Array.new(['1.1', '2.2', '3.3'])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253grep(1), int_triple.grep(1))
        assert_equal(str_triple.cs253grep(/^\d*$/){|x| x.to_i}, str_triple.grep(/^\d*$/){|x| x.to_i})
        assert_equal(float_triple.cs253grep(/./){|x| x.to_f}, float_triple.grep(/./){|x| x.to_f})
        assert_equal(nil_triple.cs253grep(/P./), nil_triple.grep(/P./))
        assert_equal(cus_triple.cs253grep(1), cus_triple.grep(1))
    end

    def test_grep_v
        int_triple = CS253Array.new([1, 10, 100, 1000])
        str_triple = CS253Array.new(['a','1','b','2'])
        float_triple = CS253Array.new(['1.1', '2.2', '3.3'])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253grep_v(1), int_triple.grep_v(1))
        assert_equal(str_triple.cs253grep_v(/^\d*$/){|x| x.to_i}, str_triple.grep_v(/^\d*$/){|x| x.to_i})
        assert_equal(float_triple.cs253grep_v(/./){|x| x.to_f}, float_triple.grep_v(/./){|x| x.to_f})
        assert_equal(nil_triple.cs253grep_v(/P./), nil_triple.grep_v(/P./))
        assert_equal(cus_triple.cs253grep_v(1), cus_triple.grep_v(1))
    end

    def test_group_by
        int_triple = CS253Array.new([1, 3, 5, 9])
        str_triple = CS253Array.new(['Ripley', 'McClane', 'Ryerson', 'Murphy'])
        float_triple = CS253Array.new([1.2, 1.5, 2.3, 3.1, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253group_by{|i| i % 3}, int_triple.group_by{|i| i % 3})
        assert_equal(str_triple.cs253group_by{|i| i[0]}, str_triple.group_by{|i| i[0]})
        assert_equal(float_triple.cs253group_by{|i| i.round}, float_triple.group_by{|i| i.round})
        assert_equal(nil_triple.cs253group_by{|i| i == 0}, nil_triple.group_by{|i| i == 0})
        assert_equal(cus_triple.cs253group_by{|i| i == 0}, cus_triple.group_by{|i| i == 0})
    end

    def test_include?
        int_triple = CS253Array.new([2, 4, 6, 8])
        str_triple = CS253Array.new(['why', 'so', 'many', 'functions'])
        float_triple = CS253Array.new([1.1, 2.5, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253include?(2), int_triple.include?(2))
        assert_equal(str_triple.cs253include?('man'), str_triple.include?('man'))
        assert_equal(float_triple.cs253include?(0), float_triple.include?(0))
        assert_equal(nil_triple.cs253include?(1), nil_triple.include?(1))
        assert_equal(cus_triple.cs253include?(1), cus_triple.include?(1))
    end

    def test_inject
        int_triple = CS253Array.new([2, 3, 4])
        str_triple = CS253Array.new(['test', 'anotherTest', 'lastTest'])
        float_triple = CS253Array.new([1.2, 1,3, 1.4])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253inject(1){|result, i| result + i}, int_triple.inject(1){|result, i| result + i})
        assert_equal(str_triple.cs253inject{|result, i| result.concat(i)}, str_triple.inject{|result, i| result.concat(i)})
        assert_equal(float_triple.cs253inject{|result, i| result + i.round}, float_triple.inject{|result, i| result + i.round})
        assert_equal(nil_triple.cs253inject(2){|result, i| result * i}, nil_triple.inject(2){|result, i| result * i})
        assert_equal(cus_triple.cs253inject(2){|result, i| result * i}, cus_triple.inject(2){|result, i| result * i})
    end

    def test_map
        int_triple = CS253Array.new([1, 3, 5])
        str_triple = CS253Array.new(['this', 'is', 'the', 'same', 'as', 'collect'])
        float_triple = CS253Array.new([-2.4, -2.3, -4.2])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253collect{|i| i.to_s}.to_a, int_triple.collect{|i| i.to_s}.to_a)
        assert_equal(str_triple.cs253collect{|i| i.length}.to_a, str_triple.collect{|i| i.length}.to_a)
        assert_equal(float_triple.cs253collect{|i| i.round}.to_a, float_triple.collect{|i| i.round}.to_a)
        assert_equal(nil_triple.cs253collect{|i| i < 0}.to_a, nil_triple.cs253collect{|i| i < 0}.to_a)
        assert_equal(cus_triple.cs253collect{|i| i > 0}.to_a, cus_triple.cs253collect{|i| i > 0}.to_a)
    end

    def test_max
        int_triple = CS253Array.new([-1, 0, 1, 1])
        str_triple = CS253Array.new(['better', 'anotherBetter', 'lastBetter', 'reallyBetter?'])
        float_triple = CS253Array.new([2, -3.5, 1.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253max(2){|a, b| a <=> b}, int_triple.max(2){|a, b| a <=> b})
        # assert_equal(str_triple.cs253max(2){|a, b| a.length <=> b.length}, str_triple.max(2){|a, b| a.length <=> b.length})
        assert_equal(float_triple.cs253max(1){|a, b| a ** 2 <=> b ** 2}, float_triple.max(1){|a, b| a ** 2 <=> b ** 2})
        assert_equal(nil_triple.cs253max{|a, b| a.round <=> b.round}, nil_triple.max{|a, b| a.round <=> b.round})
        assert_equal(cus_triple.cs253max{|a, b| a.round <=> b.round}, cus_triple.max{|a, b| a.round <=> b.round})
    end

    def test_max_by
        int_triple = CS253Array.new([10, 30, 20, 30])
        str_triple = CS253Array.new(['best', 'anotherBest', 'lastBest', 'reallyBest?'])
        float_triple = CS253Array.new([-1.4, -1.5, 0, 2.0])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253max_by(2){|i| i}, int_triple.max_by(2){|i| i})
        # assert_equal(str_triple.cs253max_by(2){|i| i.length}, str_triple.max_by(2){|i| i.length})
        assert_equal(float_triple.cs253max_by(1){|i| i.round}, float_triple.max_by(1){|i| i.round})
        assert_equal(nil_triple.cs253max_by{|i| i.abs}, nil_triple.max_by{|i| i.abs})
        assert_equal(cus_triple.cs253max_by{|i| i.abs}, cus_triple.max_by{|i| i.abs})
    end

    def test_member?
        int_triple = CS253Array.new([10, 0, 2, 30])
        str_triple = CS253Array.new(['i', 'am', 'a', 'member?'])
        float_triple = CS253Array.new([-1.4, -1.5, 0.5, 2.0])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253member?(0), int_triple.member?(0))
        assert_equal(str_triple.cs253member?('member?'), str_triple.member?('member?'))
        assert_equal(float_triple.cs253member?(3), float_triple.member?(3))
        assert_equal(nil_triple.cs253member?(1), nil_triple.member?(1))
        assert_equal(cus_triple.cs253member?(1), cus_triple.member?(1))
    end

    def test_min
        int_triple = CS253Array.new([-1, 0, 1, -1])
        str_triple = CS253Array.new(['better', 'anotherBetter', 'lastBetter', 'really'])
        float_triple = CS253Array.new([2, -3.5, 1.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253min(2){|a, b| a <=> b}, int_triple.min(2){|a, b| a <=> b})
        # assert_equal(str_triple.cs253min(2){|a, b| a.length <=> b.length}, str_triple.min(2){|a, b| a.length <=> b.length})
        assert_equal(float_triple.cs253min(1){|a, b| a ** 2 <=> b ** 2}, float_triple.min(1){|a, b| a ** 2 <=> b ** 2})
        assert_equal(nil_triple.cs253min{|a, b| a.round <=> b.round}, nil_triple.min{|a, b| a.round <=> b.round})
        assert_equal(cus_triple.cs253min{|a, b| a.round <=> b.round}, cus_triple.min{|a, b| a.round <=> b.round})
    end

    def test_min_by
        int_triple = CS253Array.new([10, 20, 10, 30])
        str_triple = CS253Array.new(['best', 'anotherBest', 'lastBest', 'real'])
        float_triple = CS253Array.new([-1.4, -1.5, 0, 2.0])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253min_by(2){|i| i}, int_triple.min_by(2){|i| i})
        # assert_equal(str_triple.cs253min_by(2){|i| i.length}, str_triple.min_by(2){|i| i.length})
        assert_equal(float_triple.cs253min_by(1){|i| i.round}, float_triple.min_by(1){|i| i.round})
        assert_equal(nil_triple.cs253min_by{|i| i.abs}, nil_triple.min_by{|i| i.abs})
        assert_equal(cus_triple.cs253min_by{|i| i.abs}, cus_triple.min_by{|i| i.abs})
    end

    def test_minmax
        int_triple = CS253Array.new([10, 20, 30, 40, 50])
        str_triple = CS253Array.new(['first', 'min', 'second', 'max', 'end'])
        float_triple = CS253Array.new([-2.4, -1.5, 1.4, 2.8])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253minmax{|a, b| a <=> b}, int_triple.minmax{|a, b| a <=> b})
        assert_equal(str_triple.cs253minmax{|a, b| a.length <=> b.length}, str_triple.minmax{|a, b| a.length <=> b.length})
        assert_equal(float_triple.cs253minmax{|a, b| a.round <=> b.round}, float_triple.minmax{|a, b| a.round <=> b.round})
        assert_equal(nil_triple.cs253minmax{|a, b| a.abs <=> b.abs}, nil_triple.minmax{|a, b| a.abs <=> b.abs})
        assert_equal(cus_triple.cs253minmax{|a, b| a.abs <=> b.abs}, cus_triple.minmax{|a, b| a.abs <=> b.abs})
    end

    def test_minmax_by
        int_triple = CS253Array.new([-101, -202, -303])
        str_triple = CS253Array.new(['min', 'followed', 'by', 'max'])
        float_triple = CS253Array.new([1.6, 1.5, 2.0, 1.9])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253minmax_by{|i| i}, int_triple.minmax_by{|i| i})
        assert_equal(str_triple.cs253minmax_by{|i| i.length}, str_triple.minmax_by{|i| i.length})
        assert_equal(float_triple.cs253minmax_by{|i| i.round}, float_triple.minmax_by{|i| i.round})
        assert_equal(nil_triple.cs253minmax_by{|i| i.abs}, nil_triple.minmax_by{|i| i.abs})
        assert_equal(cus_triple.cs253minmax_by{|i| i.abs}, cus_triple.minmax_by{|i| i.abs})
    end

    def test_none?
        int_triple = CS253Array.new([1, 2, 3, 4])
        str_triple = CS253Array.new(['ant', 'bear', 'cat', 'dog'])
        float_triple = CS253Array.new([-1.11, 1.11, -2.22, 2.22])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253none?{|i| i > 5}, int_triple.none?{|i| i > 5})
        assert_equal(str_triple.cs253none?{|i| i.length > 3}, str_triple.none?{|i| i.length > 3})
        assert_equal(float_triple.cs253none?{|i| i.abs == i}, float_triple.none?{|i| i.abs == i})
        assert_equal(nil_triple.cs253none?{|i| i == 0}, nil_triple.none?{|i| i == 0})
        assert_equal(cus_triple.cs253none?{|i| i == 0}, cus_triple.none?{|i| i == 0})
    end

    def test_one?
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(['ant', 'bear', 'cat', 'dog'])
        float_triple = CS253Array.new([-1.11, 1.11, -2.22, 2.22])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253none?{|i| i > 5}, int_triple.none?{|i| i > 5})
        assert_equal(str_triple.cs253none?{|i| i.length == 3}, str_triple.none?{|i| i.length == 3})
        assert_equal(float_triple.cs253none?{|i| i.abs != i}, float_triple.none?{|i| i.abs != i})
        assert_equal(nil_triple.cs253none?{|i| i < 0}, nil_triple.none?{|i| i < 0})
        assert_equal(cus_triple.cs253none?{|i| i < 0}, cus_triple.none?{|i| i < 0})
    end

    def test_partition
        int_triple = CS253Array.new([7, 6, 7, 4, 1])
        str_triple = CS253Array.new(['divide', 'into', 'two', 'parts'])
        float_triple = CS253Array.new([1.11, 0.11, 2.22, 0.22])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253partition{|i| i.even?}, int_triple.partition{|i| i.even?})
        assert_equal(str_triple.cs253partition{|i| i.length == 2}, str_triple.partition{|i| i.length == 2})
        assert_equal(float_triple.cs253partition{|i| i.abs == i}, float_triple.partition{|i| i.abs == i})
        assert_equal(nil_triple.cs253none?{|i| i > 0}, nil_triple.none?{|i| i > 0})
        assert_equal(cus_triple.cs253none?{|i| i > 0}, cus_triple.none?{|i| i > 0})
    end

    def test_reduce
        int_triple = CS253Array.new([2, 3, 4])
        str_triple = CS253Array.new(['test', 'anotherTest', 'lastTest'])
        float_triple = CS253Array.new([1.2, 1,3, 1.4])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253inject(1){|result, i| result + i}, int_triple.inject(1){|result, i| result + i})
        assert_equal(str_triple.cs253inject{|result, i| result.concat(i)}, str_triple.inject{|result, i| result.concat(i)})
        assert_equal(float_triple.cs253inject{|result, i| result + i.round}, float_triple.inject{|result, i| result + i.round})
        assert_equal(nil_triple.cs253inject(2){|result, i| result * i}, nil_triple.inject(2){|result, i| result * i})
        assert_equal(cus_triple.cs253inject(2){|result, i| result * i}, cus_triple.inject(2){|result, i| result * i})
    end

    def test_reject
        int_triple = CS253Array.new([2, 1, 4, 3])
        str_triple = CS253Array.new(['reject', 'all', 'elements'])
        float_triple = CS253Array.new([1.2, 1,3, 1.4, 1.5])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253reject{|i| i.odd?}, int_triple.reject{|i| i.odd?})
        assert_equal(str_triple.cs253reject{|i| i.length == 1}, str_triple.reject{|i| i.length == 1})
        assert_equal(float_triple.cs253reject{|i| i > 1}, float_triple.reject{|i| i > 1})
        assert_equal(nil_triple.cs253reject{|i| i == 0}, nil_triple.reject{|i| i == 0})
        assert_equal(cus_triple.cs253reject{|i| i == 0}, cus_triple.reject{|i| i == 0})
    end

    def test_reverse_each
        int_triple = CS253Array.new([2, 4, 6, 8])
        str_triple = CS253Array.new(['not', 'many', 'functions', 'left'])
        float_triple = CS253Array.new([1.1, 2.5, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        cs_res, res = [], []; int_triple.cs253reverse_each{|i| cs_res << i}; int_triple.reverse_each{|i| res << i}; assert_equal(cs_res, res)
        cs_res, res = [], []; str_triple.cs253reverse_each{|i| cs_res << i.length}; str_triple.reverse_each{|i| res << i.length}; assert_equal(cs_res, res)
        cs_res, res = [], []; float_triple.cs253reverse_each{|i| cs_res << -i}; float_triple.reverse_each{|i| res << -i}; assert_equal(cs_res, res)
        cs_res, res = [], []; nil_triple.cs253reverse_each{|i| cs_res << i.abs}; nil_triple.reverse_each{|i| res << i.abs}; assert_equal(cs_res, res)
        cs_res, res = [], []; cus_triple.cs253reverse_each{|i| cs_res << i.abs}; cus_triple.reverse_each{|i| res << i.abs}; assert_equal(cs_res, res)
    end

    def test_select
        int_triple = CS253Array.new([1, 3, 4, 5])
        str_triple = CS253Array.new(['good', 'anotherGood', 'lastGood'])
        float_triple = CS253Array.new([-100, -200, 10, 200])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253select{|i| i.odd?}, int_triple.select{|i| i.odd?})
        assert_equal(str_triple.cs253select{|i| i.length > 6}, str_triple.select{|i| i.length > 6})
        assert_equal(float_triple.cs253select{|i| i == i.abs}, float_triple.select{|i| i == i.abs})
        assert_equal(nil_triple.cs253select{|i| i == -i}, nil_triple.select{|i| i == -i})
        assert_equal(cus_triple.cs253select{|i| i == -i}, cus_triple.select{|i| i == -i})
    end

    def test_slice_after
        int_triple = CS253Array.new([2, 3, 1, 4, 5])
        str_triple = CS253Array.new(["foo\n", "bar\\\n", "baz\n", "\n", "qux\n"])
        float_triple = CS253Array.new([1.1, 2.2, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253slice_after{|e| e % 2 == 0}, int_triple.slice_after{|e| e % 2 == 0}.to_a)
        assert_equal(str_triple.cs253slice_after(/(?<!\\)\n\z/), str_triple.slice_after(/(?<!\\)\n\z/).to_a)
        assert_equal(float_triple.cs253slice_after(2.2), float_triple.slice_after(2.2).to_a)
        assert_equal(nil_triple.cs253slice_after(0), nil_triple.slice_after(0).to_a)
        assert_equal(cus_triple.cs253select{|i| i == -i}, cus_triple.select{|i| i == -i})
    end

    def test_slice_before
        int_triple = CS253Array.new([2, 3, 1, 4, 5])
        str_triple = CS253Array.new(["foo", "bar", "baz", "acd", "qux", "bue"])
        float_triple = CS253Array.new([1.1, 2.2, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253slice_before{|e| e % 2 == 0}, int_triple.slice_before{|e| e % 2 == 0}.to_a)
        assert_equal(str_triple.cs253slice_before(/b\w*/).to_a, str_triple.slice_before(/b\w*/).to_a)
        assert_equal(float_triple.cs253slice_before(2.2), float_triple.slice_before(2.2).to_a)
        assert_equal(nil_triple.cs253slice_before(0), nil_triple.slice_before(0).to_a)
        assert_equal(cus_triple.cs253slice_before(0), cus_triple.slice_before(0).to_a)
    end

    def test_slice_when
        int_triple = CS253Array.new([1, 2, 3, 5, 6, 8, 9])
        str_triple = CS253Array.new(["oh", "you", "are", "eating"])
        float_triple = CS253Array.new([1.1, 2.2, 3.3, 4.4, 5.5])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.slice_when{|i, j| i + 1 != j}.to_a, int_triple.slice_when{|i, j| i + 1 != j}.to_a)
        assert_equal(str_triple.cs253slice_when{|i, j| i.length + 1 == j.length}, str_triple.slice_when {|i, j| i.length + 1 == j.length}.to_a)
        assert_equal(float_triple.cs253slice_when{|i, j| i < j}, float_triple.slice_when{|i, j| i < j}.to_a)
        assert_equal(nil_triple.cs253slice_when{|i, j| i == j}, nil_triple.slice_when{|i, j| i == j}.to_a)
        assert_equal(cus_triple.cs253slice_when{|i, j| i == j}, cus_triple.slice_when{|i, j| i == j}.to_a)
    end

    def test_sort
        int_triple = CS253Array.new([3, 1, 6, 5])
        str_triple = CS253Array.new(['gooooood', 'gooood', 'good'])
        float_triple = CS253Array.new([-200.1, -100.1, -10.1, 0.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253sort{|a, b| b <=> a}, int_triple.sort{|a, b| b <=> a})
        assert_equal(str_triple.cs253sort{|a, b| b.length <=> a.length}, str_triple.sort{|a, b| b.length <=> a.length})
        assert_equal(float_triple.cs253sort{|a, b| b <=> a}, float_triple.sort{|a, b| b <=> a})
        assert_equal(nil_triple.cs253sort{|a, b| b.abs <=> a.abs}, nil_triple.sort{|a, b| b.abs <=> a.abs})
        assert_equal(cus_triple.cs253sort{|a, b| b.abs <=> a.abs}, cus_triple.sort{|a, b| b.abs <=> a.abs})
    end

    def test_sort_by
        int_triple = CS253Array.new([3, 1, 6, 5])
        str_triple = CS253Array.new(['gooooood', 'gooood', 'good'])
        float_triple = CS253Array.new([-200.1, -100.1, -10.1, 0.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253sort_by{|i | i}, int_triple.sort_by{|i| i})
        assert_equal(str_triple.cs253sort_by{|i| i.length}, str_triple.sort_by{|i| i.length})
        assert_equal(float_triple.cs253sort_by{|i| i.abs}, float_triple.sort_by{|i| i.abs})
        assert_equal(nil_triple.cs253sort_by{|i| i}, nil_triple.sort_by{|i| i})
        assert_equal(cus_triple.cs253sort_by{|i| i}, cus_triple.sort_by{|i| i})
    end

    def test_sum
        int_triple = CS253Array.new([1, 2, 3, 4, 5, 6])
        str_triple = CS253Array.new(['sum', 'all', 'together'])
        float_triple = CS253Array.new([-2.1, -1.1, -0.1, 0.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253sum(1){|i| i}, int_triple.sum(1){|i| i})
        assert_equal(str_triple.cs253sum{|i| i.length}, str_triple.sum{|i| i.length})
        assert_equal(float_triple.cs253sum(0){|i| i.abs}, float_triple.sum(0){|i| i.abs})
        assert_equal(nil_triple.cs253sum(2){|i| i}, nil_triple.sum(2){|i| i})
        assert_equal(cus_triple.cs253sum(2){|i| i}, cus_triple.sum(2){|i| i})
    end

    def test_take
        int_triple = CS253Array.new([3, 5, 1, 9, 0, 2])
        str_triple = CS253Array.new(['take', 'more', 'than', 'all'])
        float_triple = CS253Array.new([-1.1, -2.2, -0.0, 3.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253take(3), int_triple.take(3))
        assert_equal(str_triple.cs253take(5), str_triple.take(5))
        assert_equal(float_triple.cs253take(0), float_triple.take(0))
        assert_equal(nil_triple.cs253take(2), nil_triple.take(2))
        assert_equal(cus_triple.cs253take(2), cus_triple.take(2))
    end

    def test_take_while
        int_triple = CS253Array.new([4, 6, 2, 10, 1, 3])
        str_triple = CS253Array.new(['take', 'more', 'than', 'one'])
        float_triple = CS253Array.new([-11.1, -22.2, -10.0, 32.3])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253take_while{|i| i < 5}, int_triple.take_while{|i| i < 5})
        assert_equal(str_triple.cs253take_while{|i| i.length > 5}, str_triple.take_while{|i| i.length > 5})
        assert_equal(float_triple.cs253take_while{|i| i.abs > 15}, float_triple.take_while{|i| i.abs > 15})
        assert_equal(nil_triple.cs253take_while{|i| i == 0}, nil_triple.take_while{|i| i == 0})
        assert_equal(cus_triple.cs253take_while{|i| i == 0}, cus_triple.take_while{|i| i == 0})
    end

    def test_to_a
        int_triple = CS253Array.new([1, 2, 3, 5])
        str_triple = CS253Array.new(['an', 'array', 'to', 'array'])
        float_triple = CS253Array.new([-1.5, -2.6, -3.4, 2.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253to_a, int_triple.to_a)
        assert_equal(str_triple.cs253to_a, str_triple.to_a)
        assert_equal(float_triple.cs253to_a, float_triple.to_a)
        assert_equal(nil_triple.cs253to_a, nil_triple.to_a)
        assert_equal(cus_triple.cs253to_a, cus_triple.to_a)
    end

    def test_to_h
        int_triple = CS253Array.new([[1, 2], [3, 4]])
        str_triple = CS253Array.new([['to', 1], ['hash', 2], ['table',3]])
        float_triple = CS253Array.new([[0, -1.1], [0, -2.0], [0, -1.5]])
        nil_triple = CS253Array.new([])

        assert_equal(int_triple.cs253to_h, int_triple.to_h)
        assert_equal(str_triple.cs253to_h, str_triple.to_h)
        assert_equal(float_triple.cs253to_h, float_triple.to_h)
        assert_equal(nil_triple.cs253to_h, nil_triple.to_h)
    end

    def test_uniq
        int_triple = CS253Array.new([1, 2, 3, 5, 5, 3, 2, 1])
        str_triple = CS253Array.new(['array', 'array', 'to', 'array'])
        float_triple = CS253Array.new([-1.5, -3.6, -2.4, 1.1])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253uniq{|i| i}, int_triple.uniq{|i| i})
        assert_equal(str_triple.cs253uniq{|i| i.length}, str_triple.uniq{|i| i.length})
        assert_equal(float_triple.cs253uniq{|i| i}, float_triple.uniq{|i| i})
        assert_equal(nil_triple.cs253uniq{|i| i}, nil_triple.uniq{|i| i})
        assert_equal(cus_triple.cs253uniq{|i| i}, cus_triple.uniq{|i| i})
    end

    def test_zip
        int_triple = CS253Array.new([1, 2, 3, 4])
        str_triple = CS253Array.new(['zip', 'two', 'arrays'])
        float_triple = CS253Array.new([1.3, 1.4, 1.5, 1.6])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253zip(str_triple, float_triple), int_triple.zip(str_triple, float_triple))
        assert_equal(float_triple.cs253zip(nil_triple, str_triple), float_triple.zip(nil_triple, str_triple))
        cs_res, res = [], []; int_triple.cs253zip(float_triple){|x, y| cs_res << x + y}; int_triple.zip(float_triple){|x, y| res << x + y}; assert_equal(cs_res, res)
        assert_equal(nil_triple.cs253zip(str_triple, int_triple), nil_triple.zip(str_triple, int_triple))
        assert_equal(cus_triple.cs253zip(str_triple, cus_triple), cus_triple.zip(str_triple, cus_triple))
    end

    def test_length
        int_triple = CS253Array.new([33, 11, 66, 55])
        str_triple = CS253Array.new(['hellllllllo', 'helllllo', 'hello'])
        float_triple = CS253Array.new([-0.1, -1.1, -10.1, 0.11])
        nil_triple = CS253Array.new([])
        cus_triple = Triple.new(1, 2, 3)

        assert_equal(int_triple.cs253length, int_triple.length)
        assert_equal(str_triple.cs253length, str_triple.length)
        assert_equal(float_triple.cs253length, float_triple.length)
        assert_equal(nil_triple.cs253length, nil_triple.length)
        assert_equal(cus_triple.cs253length, 3)
    end
end



