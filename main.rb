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
    else
      if arg.is_a?(Class)
        my_each { |elem| return false unless elem.is_a?(arg) }
      elsif arg.is_a?(Regexp)
        my_each { |elem| return false if elem.match?(arg) }
    end
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
    else
      if arg[0].is_a?(Class)
        my_each { |elem| return true if elem.is_a?(arg[0]) }
      elsif arg[0].is_a?(Regexp)
        my_each { |elem| return true if elem.match?(arg[0]) }
      end
    end
    false
  end

  def my_none?(arg = nil)
    if arg.nil?
      my_each { |elem| return false if yield(elem) } if block_given?
      my_each { |elem| return false unless elem.nil? || elem == false }
      true
    else
      if arg.is_a?(Class)
        my_each { |elem| return false if elem.is_a?(arg) }
        true
      elsif arg.is_a?(Regexp)
        my_each { |elem| return false if elem.match?(arg) }
        true
    end
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

# fruits = w%[apple banana strawberry pineapple]

# b = fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }
# p b

# friends = %w[Sharon Leo Leila Brian Arun]
# animals = %w[pig cow dog cat]

# x = friends.my_each { |friend| friend.upcase }
# x = friends.my_none? { |friend| friend.length >= 4 }
# y = animals.my_any?(Regexp)
# c = animals.my_none?(Numeric)
# z = [].my_none?
# p c
# hash = Hash.new
# %w(cat dog wombat).my_each_with_index { |item, index|
#   hash[item] = index }

# puts hash

# ary = [1, 2, 4, 2]
# x=ary.my_count               #=> 4
# y=ary.my_count(1)            #=> 2
# z=ary.my_count{ |x| x%2==0 } #=> 3

# p x
# p y
# p z
# y = (1..4).my_map { |i| i * i }
# my_proc = proc { |i| i * i }
# my_proc = proc { |friend| friend.upcase }
# h = %w[Sharon Leo Leila Brian Arun].my_map(&my_proc)
# p h
# x = friends.my_map(&:upcase)
# my_numbers = [5, 6, 7, 8]
# x = my_numbers.my_inject(1) { |m, number| m * number }
# y = (5..10).my_inject(:*)
# w = (5..10).my_inject(2, :*)
# s=(5..10).my_inject(:+)    
# z = (5..10).my_inject { |product, num| product * num }
# h = multiply_els([2,4,5])
# p y
# p w
# p s
# p h
# p z
# # t = my_numbers.multiply_els
# # p t
# longest = %w[ cat sheep bear marshall ].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# p longest
# a = %w[ant bea cat].my_any? { |word| word.length >= 4 }
# z = [nil, true, nil, false].my_any?
# puts z
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
