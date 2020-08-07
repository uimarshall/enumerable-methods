require_relative '../lib/enumerables'

describe Enumerable do
  let(:my_array) { [*1..10] }
  let(:my_block) { proc { |x| x * 2 } }
  let(:words) { %w[dog door rod blade] }
  let(:range) { Range.new(5, 50) }
  let(:hash) { { a: 1, b: 2, c: 3, d: 4, e: 5 } }

  describe '#my_each' do
    it 'should return the array when a block is passed' do
      expect(my_array.my_each(&my_block)).to eql(my_array.each(&my_block))
    end

    it 'my_each custom method should match the in-built each method' do
      expect(my_array.my_each(&my_block)).to be(my_array.each(&my_block))
    end

    it 'should return Enumerable if no block is passed' do
      expect(range.my_each).to be_a Enumerable
    end
    it 'should return Enumerable if no block is passed' do
      expect(hash.my_each { |x, y| puts "#{x} is #{y}" }).to eql(hash.each { |x, y| puts "#{x} is #{y}" })
    end
  end

  describe '#my_each_with_index' do
    it 'should return an enumerator when no block is given' do
      expect(my_array.my_each_with_index).to be_a Enumerable
    end
    it 'should return the array when a block is passed' do
      expect(my_array.my_each_with_index(&my_block)).to eql(my_array.each(&my_block))
    end

    it 'my_each_with_index custom method should match the in-built each_with_index method' do
      expect(my_array.my_each_with_index(&my_block)).to be(my_array.each(&my_block))
    end
  end
  describe '#my_select' do
    it 'should return an enumerator when no block is given' do
      expect(my_array.my_select).to be_a Enumerable
    end
    it 'when a block is given it should return elements satisfy the condition in the block' do
      expect(my_array.my_select(&:even?)).to be == my_array.select(&:even?)
    end
  end
  describe '#my_all' do
    it 'when block is given' do
      expect(my_array.my_all? { |x| x > 10 }).to eql(my_array.all? { |x| x > 10 })
    end
    it 'when all elements in the array passes the given condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be == true
    end
    it 'when all elements of the array is odd' do
      expect(my_array.my_all?(&:odd?)).to be == false
    end
    it 'when all elements in the array are integers' do
      expect(my_array.my_all?(&:integer?)).to be == true
    end
    it 'when argument is a regular expression' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'Check if all data-type in array are string' do
      expect(my_array.my_all? { |x| x == x.to_s }).to eq(false)
    end
  end

  describe '#my_any?' do
    it 'Return true if any of the item in the array satisfies given condition' do
      expect(my_array.my_any?(&:odd?)).to eq(true)
    end
    it 'Should not return false if any of the item in the array satisfies given condition' do
      expect(my_array.my_any? { |x| x.odd? or x.even? }).not_to eq(false)
    end
  end

  describe '#my_none?' do
    it 'Return true if all items are not integer' do
      expect(my_array.my_none? { |x| x.class != Integer }).to eq(true)
    end

    it 'Checking if none of given parameters is integers' do
      expect(%w[44 55].my_none?(Integer)).to eq(true)
    end
  end

  describe '#my_count?' do
    it 'Count the items of the given array' do
      expect(my_array.my_count(&my_block)).to eq(10)
    end

    it 'Count elements in array' do
      expect([1, 7].my_count(&my_block)).to eq(2)
    end

    it 'Count a value in array with given block' do
      expect([16, 2].my_count(&:even?)).to eq(2)
    end

    it 'Count elements of array on given condition' do
      expect([20, 4, 3, 7].my_count { |x| x >= 7 }).to eq(2)
    end
  end

  describe '#my_map' do
    it 'returns the enumerator when no block is passed' do
      expect(my_array.my_map).to be_a Enumerable
    end
    it 'returns the same as the built in method when a block is passed' do
      expect(my_array.my_map { |x| x * 2 }).to eql(my_array.map { |x| x * 2 })
    end
    it 'returns the same as the built in method when a proc is passed as an argument' do
      expect(my_array.my_map(&my_block)).to eql(my_array.map(&my_block))
    end
  end
  describe '#my_inject' do
    it 'my_inject returns the same as inbuilt method when no value is passed as starting value' do
      expect(range.my_inject { |prod, n| prod * n }).to eql(range.inject { |prod, n| prod * n })
    end
    it 'my_inject returns the same as inbuilt method inject method an operator is passed as and argument  ' do
      expect(range.my_inject(:+)).to eql(range.inject(:+))
    end
    it 'my_inject returns the same as inbuilt method when number and an operator is passed as arguments' do
      expect(range.my_inject(1, :*)).to eql(range.inject(1, :*))
    end
    it 'my_inject returns the same as inbuilt method when number is passed as argument and block is given ' do
      expect(range.my_inject(1) { |prod, n| prod * n }).to eql(range.inject(1) { |prod, n| prod * n })
    end
  end
end
