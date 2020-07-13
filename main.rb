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


  def my_count(n = nil)
    counter = 0
    if n
      self.my_each{|elem| counter += 1 if elem == n }
    
    elsif block_given?
      self.my_each{|elem| counter += 1 if yield(elem)}
        
    else
      counter = self.size 
    end
    counter
  end
end

# fruits = w%[apple banana strawberry pineapple]

# b = fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }
# p b

friends = %w[Sharon Leo Leila Brian Arun]
animals = %w[ant bear cat]

# x = friends.my_each { |friend| friend.upcase }
# x = friends.my_none? { |friend| friend.length >= 4 }
# y = animals.my_none? { |word| word.length == 5 }
# z = [nil].my_none?
# p z

ary = [1, 2, 4, 2]
x=ary.my_count               #=> 4
y=ary.my_count(1)            #=> 2
z=ary.my_count{ |x| x%2==0 } #=> 3

p x
p y
p z

