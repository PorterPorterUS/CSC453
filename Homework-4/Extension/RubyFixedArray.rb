class RubyFixedArray
    include Enumerable
    def initialize(cap = nil, val = nil)
        @array = Array.new(cap, val)
		if val.nil?
			puts 'Create a new Ruby implemented array with capacity of ' + cap.to_s + ' and initialize to nil by default'
		else
			puts 'Create a new Ruby implemented array with capacity of ' + cap.to_s + ' and initialize to ' + val.to_s
		end
    end

    def each
        @array.each do |n|
 			yield n
		end
    end

	def sum
		ts = 0
		@array.each do |n|
			ts += n
		end
		ts
	end
	
	def insert(pos = nil, val = nil)
		@array[pos] = val
		if val.nil?
			puts 'Insert nil at ' + pos.to_s + ' position in Ruby implemented array' 
		else
			puts 'Insert ' + val.to_s + ' at ' + pos.to_s + ' position in Ruby implemented array'
		end
	end
	
end