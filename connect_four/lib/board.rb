COL_SIZE = 7
ROW_SIZE = 6


class Board
	attr_accessor :board, :turns, :last_move

	def initialize
		@turns = 0
		@last_move = [-1, -1]
		@board = Array.new(ROW_SIZE) {Array.new(COL_SIZE) {" "} }
	end

	def board_
		return @board
	end

	def print_board
		puts
		for i in 0...COL_SIZE
			print "  (#{i})"
		end
		puts

		for r in 0...ROW_SIZE
			puts
			print " |"
			for c in 0...COL_SIZE
				print "  #{@board[r][c]} |"
			end
			puts
		end
		print "-----------------------------------"
		puts
	end
end

