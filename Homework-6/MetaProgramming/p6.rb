module Cnt

  def Cnt.included(klass)
    klass.instance_eval do
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

end

class Array
  include Cnt
end

puts Array.cnt

a = Array.new(2)
p a
puts Array.cnt

b = Array.new([1, 2, 3])
p b
puts Array.cnt

c = Array.new(3){|e| e * 2}
p c
puts Array.cnt


d = Array.new
p d
puts Array.cnt
