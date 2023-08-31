class Player
  attr_reader :role
  def initialize(game, role)
    @score = 0
    @game = game
    @role = role
  end
end
