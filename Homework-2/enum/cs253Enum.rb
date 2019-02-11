## ruby Enumerable template
## feel free to change the input arguments format
## as long as it works :)
## have fun! 


module CS253Enumerable
  def cs253all?(&block)
    res = true
    if block.nil?
      self.each do |n|
        res = (res and ((n.nil? or n == false)? false : true))
      end
    else
      self.each do |n|
        res = (res and ((block.call(n).nil? or block.call(n) == false)? false : true))
      end
    end
    res
  end

  def cs253any?(&block)
    res = false
    if block.nil?
      self.each do |n|
        res = (res or (n.nil? or n == false)? false : true)
      end
    else
      self.each do |n|
        res = (res or (block.call(n).nil? or block.call(n) == false)? false : true)
      end
    end
    res
  end

  def cs253chunk (&block)
    res = []
    self.each do |n|
      if res.last.nil?
        res << [block.call(n), [n]]
      else
        if res.last.first == block.call(n)
          res.last.last << n
        else
          res << [block.call(n), [n]]
        end
      end
    end
    res
  end

  def cs253chunk_while (&block)
    res = []
    if self.cs253length == 0 # if self.first.nil?
      res
    else
      res << [self.first]
      self.drop(1).each do |n|
        if block.call(res.last.last, n)
          res.last << n
        else
          res << [n]
        end
      end
      res
    end
  end

  def cs253collect (&block)
    res = []
    self.each do |n|
      res << block.call(n)
    end
    res
  end

  def cs253collect_concat (&block)
    tmp = []
    self.each do |n|
      tmp << block.call(n)
    end
    res = []
    tmp.each do |n|
      if n.respond_to? :each
        n.each do |i|
          res << i
        end
      else
        res << n
      end
    end
    res
  end

  def cs253count (item=(no_arg = true; nil), &block)
    res = 0
    if no_arg
      if block.nil?
        self.each do |_|
          res = res + 1
        end
      else
        self.each do |n|
          res = block.call(n) ? res + 1 : res
        end
      end
    else
      self.each do |n|
        res = (n == item) ? res + 1 : res
      end
    end
    res
  end

  def cs253cycle (n=nil, &block)
    if n < 0 or self.cs253length == 0
      nil
    else
      (1..n).each do |_|
        self.each do |e|
          block.call(e)
        end
      end
      nil
    end
  end

  def cs253detect(ifnone = nil, &block)
    res = nil
    self.each do |n|
      if block.call(n)
        res = n
        break
      end
    end
    if not res.nil?
      res
    else
      if ifnone.nil?
        nil
      else
        ifnone.call
      end
    end
  end

  def cs253drop(n)
    if n < 0
      raise ArgumentError
    end

    res = []
    idx = 0
    self.each do |e|
      if idx < n
        idx = idx + 1
      else
        res << e
      end
    end
    res
  end

  def cs253drop_while(&block)
    res = []
    stop_drop = false
    self.each do |n|
      if (not block.call(n)) or stop_drop
        res << n
      end
      if (not stop_drop) and res.length > 0
        stop_drop = true
      end
    end
    res
  end

  def cs253each_cons(n, &block)
    if n <= 0
      raise ArgumentError
    end

    arr = self.clone.cs253to_a
    idx = 0
    arr.each do |_|
      st = idx
      en = st + n - 1
      if en < arr.length
        block.call(arr[st..en])
      end
      idx = idx + 1
    end
    nil
  end

  def cs253each_entry(&block)
    self.each do |*n|
      m = n.to_a
      if m.length == 0
        block.call(nil)
      elsif m.length == 1
        block.call(n[0])
      else
        block.call(n)
      end
    end

    res = []
    self.each do |*n|
      m = n.to_a
      if m.length == 0
        res << nil
      elsif m.length == 1
        res << n[0]
      else
        res << n
      end
    end
    res
  end

  def cs253each_slice(n, &block)
    if n <= 0
      raise ArgumentError
    end

    if self.cs253length == 0
      nil
    else
      slice = []
      self.each do |e|
        if slice.length < n
          slice << e
        else
          block.call(slice)
          slice = []
          slice << e
        end
      end
      block.call(slice)
      nil
    end
  end

  def cs253each_with_index(&block)
    res = []
    idx = 0
    self.each do |n|
      block.call(n, idx)
      idx = idx + 1
      res << n
    end
    res
  end

  def cs253each_with_object(obj, &block)
    self.each do |n|
      block.call(n, obj)
    end
    obj
  end

  def cs253entries
    res = []
    self.each do |n|
      res << n
    end
    res
  end

  def cs253find(ifnone=nil, &block)
    found = false
    res = nil
    self.each do |n|
      if block.call(n)
        res = n
        found = true
        break
      end
    end
    if found
      res
    else
      if ifnone.nil?
        nil
      else
        ifnone.call
      end
    end
  end

  def cs253find_all(&block)
    res = []
    self.each do |n|
      if block.call(n)
        res << n
      end
    end
    res
  end

  def cs253find_index(value=(no_arg = true; nil), &block)
    arr = self.clone.cs253to_a
    res = nil
    found = false
    if no_arg
      arr.each do |n|
        if (not found) and block.call(n)
          res = arr.index(n)
          found = true
        end
      end
    else
      arr.each do |n|
        if (not found) and n == value
          res = arr.index(n)
          found = true
        end
      end
    end
    res
  end

  def cs253first(n=(no_arg=true;1))
    if no_arg
      if self.cs253length == 0
        nil
      else
        self.first
      end
    else
      if n < 0
        raise ArgumentError
      end

      res = []
      cnt = 1
      self.each do |e|
        if cnt > n
          break
        end
        res << e
        cnt = cnt + 1
      end
      res
    end
  end

  def cs253flat_map (&block)
    tmp = []
    self.each do |n|
      tmp << block.call(n)
    end
    res = []
    tmp.each do |n|
      if n.respond_to? :each
        n.each do |i|
          res << i
        end
      else
        res << n
      end
    end
    res
  end

  def cs253grep(pattern, &block)
    res = []
    self.each do |n|
      if pattern.is_a? Enumerable
        if pattern.class == Range
          if pattern.include?(n)
            res << n
          end
        elsif pattern.class == Array
          if pattern === n
            res << n
          end
        end
      else
        if not pattern.class == Regexp
          if pattern === n
            res << n
          end
        else
          if not pattern.match(n).nil?
            res << n
          end
        end
      end
    end
    if block.nil?
      res
    else
      final = []
      res.each do |n|
        final << block.call(n)
      end
      final
    end
  end

  def cs253grep_v(pattern, &block)
    res = []
    self.each do |n|
      if pattern.is_a? Enumerable
        if pattern.class == Range
          if not pattern.include?(n)
            res << n
          end
        elsif pattern.class == Array
          if not pattern === n
            res << n
          end
        end
      else
        if not pattern.class == Regexp
          if not pattern === n
            res << n
          end
        else
          if pattern.match(n).nil?
            res << n
          end
        end
      end
    end
    if block.nil?
      res
    else
      final = []
      res.each do |n|
        final << block.call(n)
      end
      final
    end
  end

  def cs253group_by(&block)
    res = Hash.new
    self.each do |n|
      if res.key?(block.call(n))
        res[block.call(n)] << n
      else
        res[block.call(n)] = [n]
      end
    end
    res
  end

  def cs253include?(obj)
    res = false
    self.each do |n|
      if n == obj
        res = true
        break
      end
    end
    res
  end

  def cs253inject(*argv, &block)
    if self.class == Array
      tmp = self.clone
    else
      tmp = self.cs253to_a
    end

    if argv.size == 2
      res = argv[0]
      opt = argv[1]
      tmp.each do |n|
        res = res.send(opt, n)
      end
    elsif argv.size == 1
      if block.nil?
        res = tmp.first
        opt = argv[0]
        tmp.drop(1).each do |n|
          res = res.send(opt, n)
        end
      else
        res = argv[0]
        tmp.each do |n|
          res = block.call(res, n)
        end
      end
    else
      res = tmp.first
      tmp.drop(1).each do |n|
        res = block.call(res, n)
      end
    end
    res
  end

  def cs253map(&block)
    res = []
    self.each do |n|
      res << block.call(n)
    end
    res
  end

  def cs253max(n=nil, &block)
    tmp = self.clone
    m = n
    if n.nil?
     m = 1
    end

    if block.nil?
      desc_sorted = tmp.cs253sort{|a, b| b <=> a}
    else
      desc_sorted = tmp.cs253sort{|a, b| block.call(b, a)}
    end
    res = []
    m = self.cs253length < m ? self.cs253length : m
    (0..m - 1).each do |i|
      res << desc_sorted[i]
    end

    if res.empty?
      if n.nil?
        nil
      else
        res
      end
    else
      if n.nil?
        res.first
      else
        res
      end
    end

    # if n.nil?
    #   if block.nil?
    #     tmp.cs253inject{|acc, e| acc >= e ? acc : e}
    #   else
    #     tmp.cs253inject{|acc, e| block.call(acc, e) >= 0 ? acc : e}
    #   end
    # else
    #   if block.nil?
    #     desc_sorted = tmp.cs253sort{|a, b| b <=> a}
    #   else
    #     desc_sorted = tmp.cs253sort{|a, b| -block.call(a, b)}
    #   end
    #   res = []
    #   n = self.cs253length < n ? self.cs253length : n
    #   (0..n - 1).each do |i|
    #     res << desc_sorted[i]
    #   end
    #   res
    # end
  end

  def cs253max_by(n=nil, &block)
    tmp = self.clone
    m = n
    if n.nil?
      m = 1
    end

    desc_sorted = tmp.cs253sort{|a, b| block.call(b) <=> block.call(a)}
    res = []
    m = self.cs253length < m ? self.cs253length : m
    (0..m - 1).each do |i|
      res << desc_sorted[i]
    end

    if res.empty?
      if n.nil?
        nil
      else
        res
      end
    else
      if n.nil?
        res.first
      else
        res
      end
    end

    # if n.nil?
    #   tmp.cs253inject{|acc, e| block.call(acc) >= block.call(e) ? acc : e}
    # else
    #   desc_sorted = tmp.cs253sort{|a, b| -block.call(a) <=> -block.call(b)}
    #   res = []
    #   n = self.cs253length < n ? self.cs253length : n
    #   (0..n - 1).each do |i|
    #     res << desc_sorted[i]
    #   end
    #   res
    # end
  end

  def cs253member?(obj)
    res = false
    self.each do |n|
      if n == obj
        res = true
        break
      end
    end
    res
  end

  def cs253min(n=nil, &block)
    tmp = self.clone
    m = n
    if n.nil?
     m = 1
    end

    if block.nil?
      asc_sorted = tmp.cs253sort{|a, b| a <=> b}
    else
      asc_sorted = tmp.cs253sort{|a, b| block.call(a, b)}
    end
    res = []
    m = self.cs253length < m ? self.cs253length : m
    (0..m - 1).each do |i|
      res << asc_sorted[i]
    end

    if res.empty?
      if n.nil?
        nil
      else
        res
      end
    else
      if n.nil?
        res.first
      else
        res
      end
    end

    # if n.nil?
    #   if block.nil?
    #     tmp.cs253inject{|acc, e| acc <= e ? acc : e}
    #   else
    #     tmp.cs253inject{|acc, e| block.call(acc, e) <= 0 ? acc : e}
    #   end
    # else
    #   if block.nil?
    #     asc_sorted = tmp.cs253sort{|a, b| a <=> b}
    #   else
    #     asc_sorted = tmp.cs253sort{|a, b| block.call(a, b)}
    #   end
    #   res = []
    #   n = self.cs253length < n ? self.cs253length : n
    #   (0..n - 1).each do |i|
    #     res << asc_sorted[i]
    #   end
    #   res
    # end
  end

  def cs253min_by(n=nil, &block)
    tmp = self.clone
    m = n
    if n.nil?
      m = 1
    end

    asc_sorted = tmp.cs253sort{|a, b| block.call(a) <=> block.call(b)}
    res = []
    m = self.cs253length < m ? self.cs253length : m
    (0..m - 1).each do |i|
      res << asc_sorted[i]
    end

    if res.empty?
      if n.nil?
        nil
      else
        res
      end
    else
      if n.nil?
        res.first
      else
        res
      end
    end

    # if n.nil?
    #   tmp.cs253inject{|acc, e| block.call(acc) <= block.call(e) ? acc : e}
    # else
    #   asc_sorted = tmp.cs253sort{|a, b| block.call(a) <=> block.call(b)}
    #   res = []
    #   n = self.cs253length < n ? self.cs253length : n
    #   (0..n - 1).each do |i|
    #     res << asc_sorted[i]
    #   end
    #   res
    # end
  end

  def cs253minmax(&block)
    res = []
    if block.nil?
      # res << cs253inject{|acc, e| acc <= e ? acc : e}
      # res << cs253inject{|acc, e| acc >= e ? acc : e}
      res << self.cs253min
      res << self.cs253max
    else
      res << cs253inject{|acc, e| block.call(acc, e) <= 0 ? acc : e}
      res << cs253inject{|acc, e| block.call(acc, e) >= 0 ? acc : e}
    end
    res
  end

  def cs253minmax_by(&block)
    res = []
    res << cs253inject{|acc, e| block.call(acc) <= block.call(e) ? acc : e}
    res << cs253inject{|acc, e| block.call(acc) >= block.call(e) ? acc : e}
    res
  end

  def cs253none?(&block)
    res = true
    self.each do |n|
      if block.nil? ? n : block.call(n)
        res = false
        break
      end
    end
    res
  end

  def cs253one?(&block)
    cnt = 0
    self.each do |n|
      if block.nil? ? n : block.call(n)
        cnt = cnt + 1
      end
    end
    if cnt == 1
      true
    else
      false
    end
  end

  def cs253partition(&block)
    true_arr = []
    false_arr = []
    self.each do |n|
      if block.call(n)
        true_arr << n
      else
        false_arr << n
      end
    end
    [true_arr, false_arr]
  end

  def cs253reduce(*argv, &block)
    if self.class == Array
      tmp = self.clone
    else
      tmp = self.cs253to_a
    end

    if argv.size == 2
      res = argv[0]
      opt = argv[1]
      tmp.each do |n|
        res = res.send(opt, n)
      end
    elsif argv.size == 1
      if block.nil?
        res = tmp.first
        opt = argv[0]
        tmp.drop(1).each do |n|
          res = res.send(opt, n)
        end
      else
        res = argv[0]
        tmp.each do |n|
          res = block.call(res, n)
        end
      end
    else
      res = tmp.first
      tmp.drop(1).each do |n|
        res = block.call(res, n)
      end
    end
    res
  end

  def cs253reject(&block)
    res = []
    self.each do |n|
      if not block.call(n)
        res << n
      end
    end
    res
  end

  def cs253reverse_each(&block)
    tmp = []
    self.each do |n|
      tmp.insert(0, n)
    end
    tmp.each do |n|
      block.call(n)
    end
    self
  end

  def cs253select(&block)
    self.cs253inject([]){|result, n| result << n if block.call(n); result}
  end

  def cs253slice_after(pattern=nil, &block)
    res = []
    if pattern.nil?
      self.each do |n|
        if res.last.nil?
          res << [n]
        else
          if not block.call(res.last.last)
            res.last << n
          else
            res << [n]
          end
        end
      end
    else
      self.each do |n|
        if res.last.nil?
          res << [n]
        else
          if pattern.class == Regexp
            if res.last.last.match(pattern).nil?
              res.last << n
            else
              res << [n]
            end
          else
            if res.last.last != pattern
              res.last << n
            else
              res << [n]
            end
          end
        end
      end
    end
    res
  end

  def cs253slice_before(pattern=nil, &block)
    res = []
    if pattern.nil?
      self.each do |n|
        if res.last.nil?
          res << [n]
        else
          if not block.call(n)
            res.last << n
          else
            res << [n]
          end
        end
      end
    else
      self.each do |n|
        if res.last.nil?
          res << [n]
        else
          if pattern.class == Regexp
            if n.match(pattern).nil?
              res.last << n
            else
              res << [n]
            end
          else
            if n != pattern
              res.last << n
            else
              res << [n]
            end
          end

        end
      end
    end
    res
  end

  def cs253slice_when(&block)
    res = []
    if self.cs253length == 0
      res
    else
      cur = self.first
      res << [cur]
      self.drop(1).each do |n|
        if block.call(cur, n)
          res << [n]
          cur = n
        else
          res.last << n
          cur = n
        end
      end
      res
    end
  end

  def cs253sort(&block)
    arr = self.clone.to_a
    tot = arr.length
    (0...(tot - 1)).each do |i|
      (0...(tot - i - 1)).each do |j|
        if block.nil?
          arr[j], arr[j + 1] = arr[j + 1], arr[j] if (arr[j] <=> arr[j + 1]) == 1
        else
          arr[j], arr[j + 1] = arr[j + 1], arr[j] if block.call(arr[j], arr[j + 1]) > 0
        end
      end
    end
    arr
  end

  def cs253sort_by(&block)
    arr = self.clone.to_a
    tot = arr.length
    (0...(tot - 1)).each do |i|
      (0...(tot - i - 1)).each do |j|
        arr[j], arr[j + 1] = arr[j + 1], arr[j] if (block.call(arr[j]) <=> block.call(arr[j + 1])) == 1
      end
    end
    arr
  end

  def cs253sum(init=0, &block)
    if self.cs253length == 0
      init
    else
      res = 0
      self.each do |n|
        res = res + (block.nil? ? n : block.call(n))
      end
      res + init
    end
  end

  def cs253take(n)
    if n < 0
      raise ArgumentError
    end

    len = self.cs253length
    n = len < n ? len : n
    cnt = 1
    res = []
    self.each do |i|
      if cnt <= n
        res << i
        cnt = cnt + 1
      else
        break
      end
    end
    res
  end

  def cs253take_while(&block)
    res = []
    self.each do |n|
      if block.call(n)
        res << n
      else
        break
      end
    end
    res
  end

  def cs253to_a
    res = []
    self.cs253each_entry do |n|
      res << n
    end
    res
  end

  def cs253to_h
    if self.cs253length != 0 and self.first.class != Array
      raise TypeError
    end

    res = Hash.new
    self.each do |k, v|
      res[k] = v
    end
    res
  end

  def cs253uniq(&block)
    record = []
    res = []
    self.each do |n|
      tmp = block.nil? ? n : block.call(n)
      if not record.include?(tmp)
        record << tmp
        res << n
      end
    end
    res
  end

  def cs253zip(*argv, &block)
    if not self.class == Array
      self_arr = self.cs253to_a
    else
      self_arr = self
    end

    argv_arr = []
    argv.each do |arr|
      if not arr.class == Array
        argv_arr << arr.cs253to_a
      else
        argv_arr << arr
      end
    end

    padding = []
    argv_arr.each do |arr|
      padding << (arr.length < self_arr.length ? (self_arr.length - arr.length) : 0)
    end

    argv_arr.each_with_index do |arr, i|
      (0..padding[i] - 1).each do |_|
        arr << nil
      end
    end

    res = []
    self_arr.each_with_index do |e, i|
      tmp = []
      tmp << e
      argv_arr.each do |arr|
        tmp << arr[i]
      end
      res << tmp
    end

    if block.nil?
      res
    else
      res.each do |n|
        block.call(n)
      end
      nil
    end
  end

  def cs253length
    res = 0
    self.each do |_|
      res = res + 1
    end
    res
  end
end
