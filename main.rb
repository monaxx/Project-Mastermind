require_relative 'mastermind'
# optional arguements: code_length , num_of_colors , num_of_guesses
# new_game = Mastermind.new(code_length: 4, num_of_colors: 6, num_of_guesses: 6) # Example
new_game = Mastermind.new
new_game.player_option
new_game.start_game
