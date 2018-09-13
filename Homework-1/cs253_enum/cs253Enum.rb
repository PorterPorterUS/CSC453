# This is a template for Enumerable module;

module CS253Enumerable
    def cs253collect (&block)
        res = []
        self.each do |n|
            res << block.call(n)
        end
        res
    end


    def cs253inject (result = nil, &block)
        if result.nil?
            result = self.first
            self.drop(1).each do |n|
                result = block.call(result, n)
            end
        else
            self.each do |n|
                result = block.call(result, n)
            end
        end
        result
    end


    def cs253select (&block)
        self.cs253inject([]){|result, n| result << n if block.call(n); result}
    end


    def cs253max (&block)
        self.cs253inject{|result, n| block.call(result, n) >= 0 ? result : n}
    end


    def cs253max_by (&block)
        self.cs253inject{|result, n| block.call(result) >= block.call(n) ? result : n}
    end
end