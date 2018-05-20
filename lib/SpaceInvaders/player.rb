require 'ruby2d'
require_relative './ship.rb'

class Player < Ship
   
  attr_accessor :score 

  def initialize(x, y, speed = 10, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 70, width: 60, x: x, y: y)
    @score = 0
  end

  def moveRight(distance)
    @x = @x + distance
    @image.x = @x
  end

  def moveLeft(distance)
    @x = @x - distance
    @image.x = @x
  end

  # Screen boundary test with a given delta
  def insideScreen(delta)
    if $playerMove == "Right"
      return (@x + @image.width + delta) < $windowW ? true : false
    elsif $playerMove == "Left"
      return (@x - delta) > 0 ? true : false
    end
  end

  def move()
    if $playerMove == "Right"
      if insideScreen(@speed)
        moveRight @speed
      end
    elsif $playerMove == "Left"
      if insideScreen(@speed)
        moveLeft @speed
      end
    end
  end

  def shoot
    if $playerShoot
      shot = Bullet.new((@x + (@image.width)/2), @y - 3, "Player")
      $playerShoot = false
      return shot
    end
    return nil
  end
end
