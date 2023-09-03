require_relative 'human_player'
require_relative 'computer_player'

class Mastermind
  BLACK_PEG = 'B'
  WHITE_PEG = 'W'
  NO_PEG = '_'
  ROLE = [:GUESSER, :CREATOR]
  
  attr_reader :code_length, :num_of_colors, :feedback

  def initialize(code_length: 4, num_of_colors: 6, num_of_guesses: 6)
    random = Random.new

    @code_length = code_length
    @feedback = Array.new(code_length) { NO_PEG }
    @num_of_colors = num_of_colors
    @num_of_guesses = num_of_guesses
    @secret_code = Array.new(code_length) { random.rand(1..num_of_colors) }
  end

  def player_option
    loop do
      puts "[0] #{ROLE[0]}\n[1] #{ROLE[1]}"
      print 'Choice: '
      option = Kernel.gets.chomp
      case option
      when '0'
        @human_player = HumanPlayer.new(self, ROLE[0])
        @computer_player = ComputerPlayer.new(self, ROLE[1])
        break
      when '1'
        @human_player = HumanPlayer.new(self, ROLE[1])
        @computer_player = ComputerPlayer.new(self, ROLE[0])
        break
      else
        puts '0 and 1 only'
      end
    end
  end

  def start_game
    if @human_player.role == :GUESSER
      human_play_as_guesser
    else
      human_play_as_creator
    end
  end

  def human_play_as_guesser
    puts "code: #{@secret_code} | colors: 1-#{@num_of_colors} | code length: #{@code_length} | max guesses: #{@num_of_guesses}"
    @num_of_guesses.times do |i|
      print "GUESS# #{i + 1}/#{@num_of_guesses}: "
      player_guess = @human_player.enter_guess(i + 1)
      show_guess_feedback(player_guess)
      if correct_guess?
        puts 'Correct!'
        break
      elsif i == (@num_of_guesses - 1)
        puts "You lose. Correct answer is #{@secret_code}"
      end
    end
  end

  def human_play_as_creator
    puts "code: #{@secret_code} | colors: 1-#{@num_of_colors} | code length: #{@code_length} | max guesses: #{@num_of_guesses}"
    @num_of_guesses.times do |i|
      print "GUESS# #{i + 1}/#{@num_of_guesses}: "
      computer_guess = @computer_player.generate_guess
      show_guess_feedback(computer_guess)
      if correct_guess?
        puts 'Correct!'
        break
      elsif i == (@num_of_guesses - 1)
        puts "You lose. Correct answer is #{@secret_code}"
      end
    end
  end

  def valid_guess?(guess)
    guess.match?(/^[1-9][0-#{@num_of_colors}]*( [1-9][0-#{@num_of_colors}]*){#{@code_length - 1}}$/)
  end

  private

  def correct_guess?
    @feedback.all? { |element| element == BLACK_PEG }
  end

  def show_guess_feedback(player_guess)
    p player_guess
    player_guess_num_black_pegs = []
    player_guess_num_white_pegs = []
    @feedback = @feedback.each_with_index.map do |_, index|
      if @secret_code[index] == player_guess[index]
        player_guess_num_black_pegs << player_guess[index]
        BLACK_PEG
      else
        NO_PEG
      end
    end
    @feedback = @feedback.each_with_index.map do |feedback, index|
      if @secret_code[index] != player_guess[index] && @secret_code.include?(player_guess[index])
        if (player_guess_num_black_pegs.count(player_guess[index]) + player_guess_num_white_pegs.count(player_guess[index])) < @secret_code.count(player_guess[index])
          player_guess_num_white_pegs << player_guess[index]
          WHITE_PEG
        else
          NO_PEG
        end
      else
        feedback
      end
    end

    puts "Feedback: #{@feedback}"
  end
end
