require './board.rb'

class ConnectFour

	def initialize
		@board = Board.new
	end

	def which_turn
		player = ['X', 'O']
		return player[@board.turns % 2]
	end

	# def valid(user_input)
	# 	range = Array.new(COL_SIZE) { |i| i }

	# 	return true if range.include?(user_input)
	# 	return false
	# end

	def turn(column)
		row = ROW_SIZE - 1

		while row > -1
			if @board.board[row][column] == " "
				@board.board[row][column] = which_turn
				@board.turns += 1
				@board.last_move = [row, column]
				@board.print_board
				return true
			end
			row -= 1
		end
		return false
	end

	def check_winner
		last_row = @board.last_move[0]
		last_col = @board.last_move[1]
		last_letter = @board.board[last_row][last_col]

		direction = [
			[[-1, 0], 0, true],
			[[1, 0], 0, true],
			[[0, -1], 0, true],
			[[0, 1], 0, true],
			[[-1, -1], 0, true],
			[[1, 1], 0, true],
			[[-1, 1], 0, true],
			[[1, -1], 0, true]
		]

		for i in 0...4
			direction.each do |dir|
				row = last_row + (dir[0][0] * (i + 1))
				col = last_col + (dir[0][1] * (i + 1))

				if dir[2] && in_bound(row, col) && @board.board[row][col] == last_letter
					dir[1] += 1
				else
					dir[2] = false
				end
			end
		end

		(0...7).step(2) do |idx|
			if direction[idx][1] + direction[idx + 1][1] >= 3
				p "#{last_letter} wins!!!"
				return last_letter
			end
		end

		return false
	end

	def in_bound(row, col)
		return row >= 0 && row < ROW_SIZE && col >= 0 && col < COL_SIZE
	end
end

game = ConnectFour.new
board = Board.new


def play(game, board)
	game_over = false
	board.print_board

	until game_over

		valid_move = false
		 until valid_move
		 	p "#{game.which_turn} please pick a column (0-6)"
			user = gets.chomp
		 	begin
		 		valid_move = game.turn(Integer(user))
		 	rescue
		 		p "enter a valid number (0-6)"
		 	end
		 end

		 game_over = game.check_winner

		 board.board.each do |che|
		 	unless che.include?(" ")
		 		puts 'its a a TIE!!'
		 		return  
		 	end
		 end
	end
end

# play(game, board)