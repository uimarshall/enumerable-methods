# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    array = [Hash, Range].member?(self.class) ? to_a.flatten : self
    i = 0
    while i < array.length
      yield(array[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    array = [Hash, Range].member?(self.class) ? to_a.flatten : self
    i = 0
    while i < array.length
      yield(array[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    my_each { |elem| new_array.push(elem) if yield(elem) == true }
    new_array
  end

  def my_all?(arg = nil)
    if arg.nil?
      my_each { |elem| return false unless yield(elem) } if block_given?
      my_each { |elem| return false if elem.nil? || elem == false }

    elsif arg.is_a?(Class)
      my_each { |elem| return false unless elem.is_a?(arg) }
    elsif arg.is_a?(Regexp)
      my_each { |elem| return false if elem.match?(arg) }
    end
    true
  end

  def my_any?(*arg)
    if arg.empty?
      if block_given?
        my_each { |elem| return true if yield(elem) }
      else
        my_each { |elem| return true unless elem.nil? || elem == false }
      end

    elsif arg[0].is_a?(Class)
      my_each { |elem| return true if elem.is_a?(arg[0]) }
    elsif arg[0].is_a?(Regexp)
      my_each { |elem| return true if elem.match?(arg[0]) }
    end

    false
  end

  def my_none?(arg = nil)
    if arg.nil?
      my_each { |elem| return false if yield(elem) } if block_given?
      my_each { |elem| return false unless elem.nil? || elem == false }
      true

    elsif arg.is_a?(Class)
      my_each { |elem| return false if elem.is_a?(arg) }
      true
    elsif arg.is_a?(Regexp)
      my_each { |elem| return false if elem.match?(arg) }
      true
    end
  end

  def my_count(num = nil)
    counter = 0
    if num
      my_each { |elem| counter += 1 if elem == num }

    elsif block_given?
      my_each { |elem| counter += 1 if yield(elem) }

    else
      counter = size
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    new_array = []
    if proc
      my_each { |i| new_array.push(proc.call(i)) }
    else
      my_each { |i| new_array.push(yield(i)) }
    end
    new_array
  end

  def my_inject(value = nil, sym = nil)
    array = is_a?(Array) ? self : to_a
    symbol = value if value.is_a?(Symbol) || value.is_a?(String)
    acc = value if value.is_a? Integer

    if value.is_a?(Integer)
      symbol = sym if sym.is_a?(Symbol) || sym.is_a?(String)
    end

    if symbol
      array.my_each { |i| acc = acc ? acc.send(symbol, i) : i }
    elsif block_given?
      array.my_each { |i| acc = acc ? yield(acc, i) : i }
    end
    acc
  end
end

def multiply_els(array)
  array.my_inject(:*)
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
