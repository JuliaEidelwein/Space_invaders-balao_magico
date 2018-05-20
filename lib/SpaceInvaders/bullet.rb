class Bullet

  attr_reader :x, :y, :shape, :speed, :hitShip, :shooter

  def initialize (x, y, shooter, speed = 10)
    @x = x
    @y = y
    @shooter = shooter
    @speed = speed
    @shape = Square.new(color: 'red', size: 4, x: x, y: y)
  end
  
  # Checks if the middle point of the bullet hit a ship
  def hitAShip (ship, type)
    if ship.contains?((x + (@shape.size)/2), (y + (@shape.size)/2)) and type != @shooter
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
      if @shooter == "Player"
        @y = @y - @speed
        @shape.y = @y
      #elsif @shooter == "Enemy"
      elsif @shooter == "Invader" or @shooter == "MasterInvader"
        @y = @y + @speed/2
        @shape.y = @y
      end
    end
  end

end
