
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    array = to_a
    i = 0
    while i < array.length
      yield(array[i])
      i += 1
    end
    array
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    array = to_a
    i = 0
    while i < array.length
      yield(array[i], i)
      i += 1
    end
    array
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_array = []
    my_each { |elem| new_array.push(elem) if yield(elem) == true }
    new_array
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    my_each { |elem| return false if yield(elem) == false }
    true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    my_each { |elem| return true if yield(elem) == true }
    false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_each { |elem| return false if yield(elem) == true }
    true
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

  def my_inject(num = nil, symbol = nil)
    if block_given?
      acc = num
      my_each { |i| acc = acc.nil? ? i : yield(acc, i) }
      acc
    elsif acc.nil?
      !num.nil? && num.is_a?(Symbol) || num.is_a?(String)
      my_each { |i| acc = acc.nil? ? i : acc.send(num, i) }
    elsif (acc = num)
      !num.symbol? && num.is_a?(Symbol) || num.is_a?(String)
      my_each { |i| acc = acc.nil? ? i : acc.send(symbol, i) }
    end
    acc
  end

  def multiply_els
    my_inject { |x, y| x * y }
  end
end

# fruits = w%[apple banana strawberry pineapple]

# b = fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }
# p b

# friends = %w[Sharon Leo Leila Brian Arun]
# animals = %w[ant bear cat]

# x = friends.my_each { |friend| friend.upcase }
# x = friends.my_none? { |friend| friend.length >= 4 }
# y = animals.my_none? { |word| word.length == 5 }
# z = [nil].my_none?
# p z

# ary = [1, 2, 4, 2]
# x=ary.my_count               #=> 4
# y=ary.my_count(1)            #=> 2
# z=ary.my_count{ |x| x%2==0 } #=> 3

# p x
# p y
# p z
# y = (1..4).my_map { |i| i * i }
# my_proc = proc { |i| i * i }
my_proc = proc { |friend| friend.upcase }
h = %w[Sharon Leo Leila Brian Arun].my_map(&my_proc)
p h
# x = friends.my_map(&:upcase)
# my_numbers = [5, 6, 7, 8]
# x = my_numbers.my_inject(1) { |m, number| m * number }
y = (5..10).my_inject(:*)
# w = (5..10).my_inject(1, :*)
# z = (5..10).multiply_els { |product, num| product * num }
# h = multiply_els([2,4,5])
# t = my_numbers.multiply_els
# longest = %w[ cat sheep bear marshall ].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
puts y
