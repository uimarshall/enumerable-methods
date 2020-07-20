# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    array = to_a
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

    if block_given?
      my_each { |elem| return false unless yield(elem) }
    elsif arg.nil?
      my_each { |elem| return false if elem.nil? || elem == false }
    elsif arg.is_a? Class
      my_each { |elem| return false unless elem.class.ancestors.include? arg }
    elsif arg.class == Regexp
      my_each { |elem| return false unless elem.match?(arg) }
    elsif arg
      my_each { |elem| return false unless elem == arg }
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

# w = [1, true, 99].my_all?
# puts w
# animals = ["dog", "door", "rod", "blade"]
# x = animals.my_all?("dogs")
# puts x
useless_array = [2, 4, 2, 2, 4, 4, 2, 7, 1, 4, 4, 3, 5, 4, 1, 2, 7, 7, 4, 8, 4, 2, 1, 6, 2, 6, 6, 7, 8, 7, 6, 6, 1, 4, 7, 7, 2, 3, 6, 2, 7, 0, 7, 5, 0, 4, 6, 5, 4, 5, 4, 0, 0, 2, 7, 8, 3, 4, 0, 0, 2, 4, 3, 6, 5, 8, 4, 8, 4, 4, 3, 5, 5, 5, 4, 6, 6, 7, 1, 4, 7, 3, 4, 8, 8, 6, 7, 4, 8, 8, 5, 2, 0, 4, 2, 1, 6, 2, 7, 2]
y = useless_array.my_all?(3)
puts y
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
