### P1. Ruby Object Model

[1,2].class # Array

[1,2].class.class # Class

[1,2].class.class.class # Class

[1,2].class.class.superclass # Module

Module.class # Class

Object.superclass # BasicObject

Class.methods - Module.methods # []

Class.instance_methods - Module.instance_methods # [:new, :allocate, :superclass]

BasicObject.instance_methods.size # 8

Object.instance_methods.size # 58

Class.instance_methods.size # 111

#

instance_eval() is defined in:

class_eval() is defined in:

# 

Child.new.metaclass.superclass # Child

Parent.new.metaclass.superclass # Parent

Child.metaclass.superclass # #\<Class:Parent\>

Parent.metaclass.superclass # #\<Class:Object\>

#

Class.instance_eval do \
&nbsp;&nbsp;&nbsp;&nbsp; def hi \
&nbsp;&nbsp;&nbsp;&nbsp; end \
end

### P2. Class Object Extension
class CntArray < Array \
&nbsp;&nbsp;&nbsp;&nbsp; @@cnt = 0 \
&nbsp;&nbsp;&nbsp;&nbsp; def initialize() \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@cnt += 1 \
&nbsp;&nbsp;&nbsp;&nbsp; end

&nbsp;&nbsp;&nbsp;&nbsp; def self.cnt \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@cnt \
&nbsp;&nbsp;&nbsp;&nbsp; end \
end

### P3. Meta-programming
```
class Class
    Class.class_eval do
        def cs253_attr_reader(*args)
            args.each do |arg|
                self.class_eval("def #{arg}; @#{arg}; end")
            end
        end
    end
end

class A
    cs253_attr_reader :a
end
```

Can this method be called by Class?

### P4. Forwardable

### P5. Advanced Meta-programming
