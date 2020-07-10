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
end
# friends = %w[Sharon Leo Leila Brian Arun]

# x = friends.my_each { |friend| friend.upcase }
# p x
