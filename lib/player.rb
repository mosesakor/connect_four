class Player

  attr_accessor :name, :disc

  def initialize(input)
    @name = input.fetch(:name)
    @disc = input.fetch(:disc)
  end
end