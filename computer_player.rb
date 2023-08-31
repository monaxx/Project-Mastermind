require_relative 'player'

class ComputerPlayer < Player
  def initialize(game, role)
    super(game, role)
  end

  def generate_guess
    random = Random.new

    guess = Array.new(@game.code_length) { random.rand(1..@game.num_of_colors) }
    guess_str = guess.join(' ')
    p guess_str
  end
end
