[1,2].class
[1,2].class.class
[1,2].class.class.class
[1,2].class.class.superclass

Module.class
Object.superclass

Class.methods - Module.methods
Class.instance_methods - Module.instance_methods

BasicObject.instance_methods.size
Object.instance_methods.size
Class.instance_methods.size

#----------------------------------------------------------------

class Object
  def metaclass
    class << self
      self
    end
  end
end

class Parent;
end

class Child < Parent;
end

Child.new.metaclass.superclass
Parent.new.metaclass.superclass
Child.metaclass.superclass
Parent.metaclass.superclass

Class.instance_eval do
  def hi
  end
end

p Class.methods - Module.methods

p Array.methods.include?(:instance_eval)
p Class.methods.include?(:instance_eval)
p Module.methods.include?(:instance_eval)
p BasicObject.methods.include?(:instance_eval)

p Array.methods.include?(:class_eval)
p Class.methods.include?(:class_eval)
p Module.methods.include?(:class_eval)
p BasicObject.methods.include?(:class_eval)