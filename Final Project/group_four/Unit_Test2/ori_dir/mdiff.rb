dir = File.dirname(__FILE__)
require "diff/lcs"
require 'test/unit/diff.rb'

module Mdiff

  def self.linesplit(a)
    l = Array.new
    last = 0
    n = a.index("\n")
    if n.nil?
      n = -1
    end
    n += 1

    while n > 0
      l.insert(-1, a[last...n])
      last = n
      n = a.index("\n", n)
      if n.nil?
        n = -1
      end
      n += 1
    end

    if last < a.length
      l.insert(-1, a[last..-1])
    end
    l
  end

  def self.textdiff(a, b)
    return diff(self.linesplit(a),self.linesplit(b))
  end

  def self.diff(a, b)
    bin = Array.new
    pp = Array.new([0])
    a.each do |i|
      pp.insert(-1, pp[-1] + i.length)
    end

    d = Test::Unit::Diff::SequenceMatcher.new(a, b)
    d.operations.each do |o, m, n, s, t|
      if o == :equal
        next
      end
      s = b[s...t].join
      bin.insert(-1, [pp[m], pp[n], s.length].pack("l>l>l>") + s)
    end

    bin.join
  end

  def self.patch(a, bin)
    last = pos = 0
    r = Array.new
    c = 0

    while pos < bin.length
      p1, p2, l = bin[pos...pos + 12].unpack("l>l>l>")
      pos += 12
      r.insert(-1, a[last...p1])
      r.insert(-1, bin[pos...pos + l])
      pos += l
      last = p2
      c += 1
    end
    r.insert(-1, a[last..-1])
    r.join
  end
end



# module Mdiff
#
#   def self.linesplit(a)
#     l = []
#     last = 0
#     n = a.index("\n")
#     while n
#       l << a[last..n]
#       last = n + 1
#       n = a.index("\n",n + 1)
#     end
#
#     if last < a.length then l << a[last..-1] end
#     return l
#   end
#
#   def self.textdiff(a, b)
#     return diff(self.linesplit(a),self.linesplit(b))
#   end
#
#   def self.diff(a, b)
#     bin = []
#     p = [0]
#
#     a.each {|i| p << (p[-1]+i.length)}
#     sdiff = Diff::LCS.sdiff(a,b)
#     sdiff.each do |c|
#       if c.action == '=' then next end
#       s = if c.new_element.nil? then "" else c.new_element end
#       if c.action == '+'
#         last_position = c.old_position
#       else
#         last_position = [c.old_position + 1, p.length-1].min
#       end
#
#       bin << [p[c.old_position], p[last_position], s.length].pack('l>l>l>') + s
#     end
#     return bin.join
#   end
#
#   def self.patch(a, bin)
#     last = pos = 0
#     r = []
#     c = 0
#
#     while pos < bin.length
#       p1, p2, l = bin[pos..pos+11].unpack("l>l>l>")
#       pos += 12
#       if last < p1
#         r <<  a[last..p1-1]
#       end
#       r << bin[pos..pos+l-1]
#       pos += l
#       last = p2
#       c += 1
#     end
#
#     r << a[last..-1]
#     return r.join
#   end
# end
#

# require 'test/unit/diff.rb'
#
# def linesplit(a)
#   l = Array.new
#   last = 0
#   n = a.index("\n")
#   if n.nil?
#     n = -1
#   end
#   n += 1
#
#   while n > 0
#     l.insert(-1, a[last...n])
#     last = n
#     n = a.index("\n", n)
#     if n.nil?
#       n = -1
#     end
#     n += 1
#   end
#
#   if last < a.length
#     l.insert(-1, a[last..-1])
#   end
#   l
# end
#
# def textdiff(a, b)
#   diff(linesplit(a), linesplit(b))
# end
#
# def diff(a, b)
#   bin = Array.new
#   pp = Array.new([0])
#   a.each do |i|
#     pp.insert(-1, pp[-1] + i.length)
#   end
#
#   d = Test::Unit::Diff::SequenceMatcher.new(a, b)
#   d.operations.each do |o, m, n, s, t|
#     if o == :equal
#       next
#     end
#     s = b[s...t].join
#     bin.insert(-1, [pp[m], pp[n], s.length].pack("l>l>l>") + s)
#   end
#
#   bin.join
# end
#
# def patch(a, bin)
#   last = pos = 0
#   r = Array.new
#   c = 0
#
#   while pos < bin.length
#     p1, p2, l = bin[pos...pos + 12].unpack("l>l>l>")
#     pos += 12
#     r.insert(-1, a[last...p1])
#     r.insert(-1, bin[pos...pos + l])
#     pos += l
#     last = p2
#     c += 1
#   end
#   r.insert(-1, a[last..-1])
#   r.join
# end
