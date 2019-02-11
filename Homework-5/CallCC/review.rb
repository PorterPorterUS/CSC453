require 'continuation'

def work
  print "early work\n"
  here = callcc{|here| here}
  print "later work\n"
  return here
end

def rework(n)
  entry = work
  n.times do |i|
    puts i
    # entry.call(entry)
  end
end

rework(2)


# def strange
#   callcc {}
#   print "Back in method\n"
# end
#
# print "Before method\n"
# c = strange()
# print "After method\n"
# c.call if c

# def foo(c)
#   puts "before raise"
#   c.call("occured")
#   puts "after raise"
# end
#
# begin
#   callcc do |c|
#     foo(c)
#   end
#   puts "rescued"
# end
