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

