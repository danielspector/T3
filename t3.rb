class Game

	attr_accessor :board, :human, :computer

	def initialize()
		@human
		@computer
		@board = Array.new(9)
		@winners = [[0,1,2],
					[3,4,5],
					[6,7,8],
					[0,3,6],
					[1,4,7],
					[2,5,8],
					[0,4,8],
					[2,4,6]
					]
	end

	def game_board
		puts ''
		print @board[0..2], "\n"
		print @board[3..5], "\n"
		print @board[6..8], "\n"
		puts ''
	end

	def human_move
		print "player is: #{@human}\n"
		puts 'Where do you want to move?'
		move = gets.chomp.to_i
		while !valid_move(move)
			puts "Error. Either you selected a number not 0 to 8 or that space is already taken"
			puts "Please select a number 0 to 8 that is not taken"
			move = gets.chomp.to_i
		end

		@board[move] = @human
	end

	def valid_move(move)
		return move >=0 && move <=8 && @board[move] == nil
	end

	def check_win
		done = true

		for set in @winners
			# print set, "\n"
			allx = true
			allo = true
			for spot in set
				# print "spot is: #{spot}, corresponding board element is #{@board[spot]}\n" 
				if @board[spot] != "x"
					allx = false
				end

				if @board[spot] != 'o'
					allo = false
				end
			end
			if allx
				return 'x'
			elsif allo
				return 'o'
			end
		end

		for element in @board
			#check whether any is nil
			if element == nil
				done = false
			end
		end
		if done == true
			return 'draw'
		end
	end

	def computer_move
		# check if computer can win
		for set in @winners
			computer_count = 0
			nil_spot = nil
			
			for spot in set			
				if @board[spot] == @computer
					computer_count += 1
				elsif @board[spot] == nil
					nil_spot = spot
				end	
			end
			
			if computer_count == 2 && nil_spot != nil
				@board[nil_spot] = @computer
				return
			end
		end

		# check if human can be blocked
		for set in @winners
			human_count = 0
			nil_spot = nil
			
			for spot in set			
				if @board[spot] == @human
					human_count += 1
				elsif @board[spot] == nil
					nil_spot = spot
				end	
			end
			
			if human_count == 2 && nil_spot != nil
				@board[nil_spot] = @computer
				return
			end
		end

		# otherwise pick a random move
		move = rand(0..8)
		while !valid_move(move)
			move = rand(0..8)
		end
		@board[move] = @computer
	end
end

########

g = Game.new

puts "Do you want to go first (y/n)"
first = gets.chomp
g.game_board

turn = false

if first == 'y'
	g.human = 'x'
	g.computer = 'o'
	g.human_move
	turn = true
else
	g.human = 'o'
	g.computer = 'x'
	g.computer_move
end

g.game_board
game_over = false

while(!game_over)
	if turn == false
		g.human_move
		turn = true
	else
		g.computer_move
		turn = false
	end
	g.game_board
	game_over = g.check_win
end

if game_over == 'draw'
	puts 'Draw!'
else
puts game_over.upcase + ' Wins!'
end