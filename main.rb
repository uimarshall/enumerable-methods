module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    array = self if self.class Array 
    array = flatten if self.class Hash
    array = to_a if self.class Range 
    i = 0
    while i < array.length
      yield(array[i])
      i += 1
    end
    array
  end
end
friends = %w[Sharon Leo Leila Brian Arun]

friends.my_each { |friend| friend.upcase }
