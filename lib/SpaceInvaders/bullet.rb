class Bullet

  attr_reader :x, :y, :shape, :speed, :hitShip

  def initialize (x, y, speed = 10)
    @x = x
    @y = y
    @speed = speed
    @shape = Square.new(color: 'red', size: 4, x: x, y: y)
  end
  
  # Checks if the middle point of the bullet hit a ship
  def hitAShip (ship)
    if ship.contains?((x + (@shape.size)/2), (y + (@shape.size)/2))
      @hitShip = true
      return ship
    end
    return nil
  end

  def insideScreen(delta)

    return ((@y + delta) < $windowH and (@y - delta) > 0) ? true : false

  end

  def move ()
    if !@hitShip and insideScreen(@speed)
      @y = @y - @speed
      @shape.y = @y
    end
  end

end
