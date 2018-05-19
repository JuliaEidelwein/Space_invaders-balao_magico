require 'ruby2d'

require_relative './ship.rb'

class Player < Ship

  def initialize(x, y, speed = 10, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 70, width: 60, x: x, y: y)
  end


  def moveRight(distance)
    @x = @x + distance
    @image.x = @x
  end

  def moveLeft(distance)
    @x = @x - distance
    @image.x = @x
  end

  def check_colision(direction)
    windowW = 600 #getWindowWidht
    if direction == "Right"
      if @x + 1 >= windowW - @image.width
        return false
      else return true
      end
    elsif direction == "Left"
      if @x -1 <= 0
        return false
      else return true
      end
    end
  end

  def move()
    if $playerMove == "Right"
      if check_colision("Right")
        moveRight @speed
      end
    elsif $playerMove == "Left"
      if check_colision("Left")
        moveLeft @speed
      end
    end
  end

  def shoot()
    raise "Shoot must be implemented"
  end
end
