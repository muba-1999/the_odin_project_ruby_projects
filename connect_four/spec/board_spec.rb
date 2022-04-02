require "./lib/board.rb"

describe Board do
	let(:board) {Board.new}
	let(:move) {board.board[1][1] = 'X'}

	it 'it checks if the move made is in the right position and is the right player' do
		expect(move).to eq('X')
	end
	it 'it checks if the move made is in the right position and is a right player' do
		expect(move).not_to eq('O')
	end
end