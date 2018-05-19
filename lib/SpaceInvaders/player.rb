require_relative './ship.rb'
class Player < Ship
  def initialize(x, y, speed = 10, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 75, width: 70, x: x, y: y)
  end
  
  def moveRight(distance)
    @x = @x + distance
    @image.x = @x
  end

  def moveLeft(distance)
    @x = @x - distance
    @image.x = @x
  end

  def move()
    if $playerMove == "Right"
      moveRight @speed
    elsif $playerMove == "Left"
      moveLeft @speed
    end
  end

  def shoot()
    raise "Shoot must be implemented"
  end
end
