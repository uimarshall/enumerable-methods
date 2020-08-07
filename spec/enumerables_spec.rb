require_relative "../lib/enumerables"

describe Enumerable do
    let(:my_array){[*1..4]}
    describe "#my_each" do
        it "should return the array that is passed" do
            expect(my_array.my_each{|x| x}).to eql([1, 2, 3, 4])
        end

        it "my_each custom method should match the in-built each method" do
            expect(my_array.my_each{|x| x}).to be((my_array.each{|x| x}))
        end

        it "should return Enumerable if no block is passed" do
            expect((1..5).my_each).to be_a Enumerable
        end
    end
end