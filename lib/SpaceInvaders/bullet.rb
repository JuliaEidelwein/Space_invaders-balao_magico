class Bullet < Moveable

  def initialize (x, y)
    @x_position = x
    @y_position = y
    @image = Square.new(color: 'red', size: 4, x: x, y: y)
  end

  attr_reader :y_position

  def move (speed)
    @y_position = @y_position - speed
    @image.y = @y_position
  end

end