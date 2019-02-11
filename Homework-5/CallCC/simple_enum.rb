require 'continuation'

class SimpleEnum
  include Enumerable

  def initialize(enum = nil, &block)
    if enum
      @block = proc{|g| enum.each {|x| g.yield x}}
    else
      @block = block
    end

    @index = 0
    @queue = []
    @cont_next = @cont_yield = @cont_endp = nil

    @cont_next = callcc{|c| c}
    if @cont_next
      @block.call(self)
      @cont_endp.call(nil) if @cont_endp
    end
    self
  end

  def yield(value)
    @cont_yield = callcc{|c| c}
    if @cont_yield
      @queue << value
      @cont_next.call(nil)
    end
    self
  end

  def end?()
    @cont_endp = callcc{|c| c}
    if @cont_endp
      @cont_yield.nil? && @queue.empty?
    else
      @queue.empty?
    end
  end

  def next()
    if end?
      raise EOFError, 'no more elements available'
    end

    @cont_next = callcc{|c| c}
    if @cont_next
      @cont_yield.call(nil) if @cont_yield
    end

    @index += 1
    @queue.shift
  end

  def next?()
    !end?
  end

  def rewind()
    initialize(nil, &@block) if @index.nonzero?

    self
  end

  def each(&block)
	  tmp_idx = @index

    rewind

    until end?
      yield self.next
    end

	  while self.next? && @index != tmp_idx
		  self.next
	  end

    self
  end

  def with_index(offset = 0)
	  tmp_idx = @index
    pairs = []
    cnt = 0
    self.each do |e|
      if cnt >= offset
        pairs << [cnt, e]
      end
      cnt += 1
    end
    rewind

    SimpleEnum.new(pairs)
  end

end
