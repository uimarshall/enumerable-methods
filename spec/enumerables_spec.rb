require_relative '../lib/enumerables'

describe Enumerable do
  let(:my_array) { [*1..10] }
  let(:my_hash) { { 'name' => 'maryjane', 'school' => 'microverse' } }
  let (:my_proc) {Proc.new {|x| x**2 }}
  

  describe '#my_each' do
    it 'should return the array when a block is passed' do
      expect(my_array.my_each { |x| x }).to eql(my_array.each { |x| x })
    end

    it 'my_each custom method should match the in-built each method' do
      expect(my_array.my_each { |x| x }).to be((my_array.each { |x| x }))
    end

    it 'should return Enumerable if no block is passed' do
      expect((1..5).my_each).to be_a Enumerable
    end
    it 'should return Enumerable if no block is passed' do
      expect(my_hash.my_each { |key, _value| key }).to eql(my_hash.each { |key, _value| key })
    end
  end

  describe '#my_each_with_index' do
    it 'should return an enumerator when no block is given' do
      expect(my_array.my_each_with_index).to be_a Enumerable
    end
    it 'should return the array when a block is passed' do
      expect(my_array.my_each_with_index { |x| x }).to eql(my_array.each { |x| x })
    end

    it 'my_each_with_index custom method should match the in-built each_with_index method' do
      expect(my_array.my_each_with_index { |x| x }).to be((my_array.each { |x| x }))
    end
  end
  describe '#my_select' do
    it 'should return an enumerator when no block is given' do
      expect(my_array.my_select).to be_a Enumerable
    end
    it 'when a block is given it should return elements satisfy the condition in the block' do
      expect(my_array.my_select { |num| num.even? }).to be == (my_array.select { |num| num.even? })
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
      expect(my_array.my_all? { |num| num.odd? }).to be == false
    end
    it 'when all elements in the array are integers' do
      expect(my_array.my_all? { |num| num.integer? }).to be == true
    end
    it 'when argument is a regular expression' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'Check if all data-type in array are string' do
      expect(my_array.my_all? { |x| x == x.to_s }).to eq(false)
    end

    it 'Check if all data-type in array satisfies my_all condition' do
      expect([true, nil, 5].my_all? { |x| x }).not_to eq(true)
    end
  end

  describe '#my_any?' do
    it 'Return true if any of the item in the array satisfies given condition' do
      expect(my_array.my_any? { |x| x.odd? }).to eq(true)
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
      expect(my_array.my_count { |x| x }).to eq(10)
    end

    it 'Count elements in array' do
      expect([1, 7].my_count { |x| x }).to eq(2)
    end

    it 'Count a value in array with given block' do
      expect([16, 2].my_count { |x| x.even? }).to eq(2)
    end

    it 'Count elements of array on given condition' do
      expect([20, 4, 3, 7].my_count { |x| x >= 7 }).to eq(2)
    end
  end
  
  describe "#my_map" do
    it "returns the enumerator when no block is passed" do
      expect(my_array.my_map).to be_a Enumerable
    end
    it "returns the same as the built in method when a block is passed" do
      expect(my_array.my_map{ |x| x * 2 }).to eql(my_array.map{ |x| x * 2 })
    end
    it "returns the same as the built in method when a proc is passed as an argument" do
      expect(my_array.my_map(&my_proc)).to eql(my_array.map(&my_proc))
    end
  end
end
