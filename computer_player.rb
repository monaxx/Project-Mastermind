require_relative 'mastermind'
require_relative 'player'

class ComputerPlayer < Player
  def initialize(game, role)
    super(game, role)
    @made_first_guess = false

    @random = Random.new
    @guess = Array.new(@game.code_length) { 1 }
    @possible_number_arr = Array(1..@game.num_of_colors)
    @white_pegged_number_arr = []
  end

  def generate_guess
    new_guess_num = @possible_number_arr.pop
    @guess = @guess.each_with_index.map do |element, index|
      if @game.feedback[index] != Mastermind::BLACK_PEG
        new_guess_num
      else
        element
      end
    end
    @guess
  end
end
