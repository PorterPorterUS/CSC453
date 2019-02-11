class CntArray < Array

  CntArray.instance_eval do
    @cnt = 0

    def new(*args, &block)
      @cnt += 1
      if args[0].nil?
        if block.nil?
          super()
        else
          super(){|index| block.call(index)}
        end
      else
        if block.nil?
          super(args[0])
        else
          super(args[0]){|index| block.call(index)}
        end
      end
    end

    def cnt
      @cnt
    end
  end

end

puts CntArray.cnt

a = CntArray.new(2)
p a
puts CntArray.cnt

b = CntArray.new([1, 2, 3])
p b
puts CntArray.cnt

c = CntArray.new(3){|e| e * 2}
p c
puts CntArray.cnt

d = CntArray.new
p d
puts CntArray.cnt

