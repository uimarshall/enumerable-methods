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
    my_each { |elem| return false if yield(elem) == false }
    true
  end
end

# fruits = w%[apple banana strawberry pineapple]

# b = fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }
# p b

friends = %w[Sharon Leo Leila Brian Arun]

# x = friends.my_each { |friend| friend.upcase }
x = friends.my_all? { |friend| friend.length >= 4 }
p x
