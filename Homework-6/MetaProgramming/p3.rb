class A
  A.instance_eval do
    def cs253_attr_reader(*args)
      args.each do |arg|
        self.class_eval("def #{arg}; @#{arg}; end")
      end
    end
  end
end

class A
  cs253_attr_reader :a

  def initialize(a)
    @a = a
  end

end

class B
  attr_reader :b

  def initialize(b)
    @b = b
  end

end

a_obj = A.new(3)
p a_obj.a

b_obj = B.new(3)
p b_obj.b

# --------------------------------------------------------------------

class Class
  Class.class_eval do
    def cs253_attr_reader(*args)
      args.each do |arg|
        self.class_eval("def #{arg}; @#{arg}; end")
      end
    end
  end
end

class Class
  cs253_attr_reader :c

  def initialize(c)
    @c = c
  end

end

c_obj = Class.new(3)
p c_obj.c