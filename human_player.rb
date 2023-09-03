require_relative 'player'
class HumanPlayer < Player
  def initialize(game, role)
    super
  end

  def enter_guess(guess_num)
    guess = ''
    loop do
      guess = Kernel.gets.chomp
      if @game.valid_guess?(guess)
        break
      else
        puts 'Invalid input. Guess again.'
        print "GUESS ##{guess_num}: "
      end
    end
    guess.split(' ').map(&:to_i)
  end
end
