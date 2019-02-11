require '../enum/cs253Enum.rb'

class Triple
    include CS253Enumerable
    include Enumerable
    def initialize(one=nil, two=nil, three=nil)
        @one = one
        @two = two
        @three = three
    end

    def each
        yield @one
        yield @two
        yield @three
    end
end
