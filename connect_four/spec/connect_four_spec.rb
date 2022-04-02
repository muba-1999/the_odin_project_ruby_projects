require './lib/connect_four.rb'

describe ConnectFour do
	let(:game) {ConnectFour.new}

	describe "#in_bound" do
		it 'returns true if a move is in bounds' do
			expect(game.in_bound(0, 2)).to eq(true)
		end

		it 'returns false if a move is not in bounds' do
			expect(game.in_bound(0, 12)).to eq(false)
		end
	end

	describe "#turn" do
		it "Returns true if the given column is valid" do
			expect(game.turn(3)).to be_truthy
		end

		it "Returns false if the given column is invalid" do
			expect(game.turn(23)).to be_falsey
		end
	end
end