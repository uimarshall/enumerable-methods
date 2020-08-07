require_relative "../lib/enumerables"

describe Enumerable do
    let(:my_array){[*1..100]}
    let(:my_hash){{"name" =>"maryjane", "school"=> "microverse"}}
    
    
    describe "#my_each" do
        it "should return the array when a block is passed" do
            expect(my_array.my_each{|x| x}).to eql(my_array.each{|x| x})
        end

        it "my_each custom method should match the in-built each method" do
            expect(my_array.my_each{|x| x}).to be((my_array.each{|x| x}))
        end

        it "should return Enumerable if no block is passed" do
            expect((1..5).my_each).to be_a Enumerable
        end
        it "should return Enumerable if no block is passed" do
            expect(my_hash.my_each{|key, value| key }).to eql(my_hash.each{|key, value| key })
        end
    end
    
    describe "#my_each_with_index" do
        it "should return an enumerator when no block is given" do
            expect(my_array.my_each_with_index).to be_a Enumerable
        end
        it "should return the array when a block is passed" do
            expect(my_array.my_each_with_index{|x| x}).to eql(my_array.each_with_index{|x| x})
        end

        it "my_each_with_index custom method should match the in-built each_with_index method" do
            expect(my_array.my_each_with_index{|x| x}).to be((my_array.each_with_index{|x| x}))
        end
        
    end
    describe "#my_select" do
        it "should return an enumerator when no block is given" do
            expect(my_array.my_select).to be_a Enumerable
        end
        it "when a block is given it should return elements satisfy the condition in the block" do
            expect(my_array.my_select{|num|  num.even? }).to be == (my_array.select{|num|  num.even? })
        end
    end 
    describe "#my_all" do
        it "when block is given" do
            expect(my_array.my_all?{|x| x > 10}).to eql(my_array.all?{|x| x > 10})
        end
        it "when all elements in the array passes the given condition" do
            expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be == (true)
        end
        it "when all elements of the array is odd" do
            expect(my_array.all?{|num| num.odd? } ).to be == (false)
        end
        it "when all elements in the array are integers" do
            expect(my_array.all?{|num| num.integer? } ).to be == (true)
        end
        it "when argument is a regular expression" do
            expect(%w[ant bear cat].all?(/t/)).to eql(false)
        end
        
    end
end
