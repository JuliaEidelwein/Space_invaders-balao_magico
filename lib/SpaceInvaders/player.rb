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

  # Moves right "distance" pixels
  def moveRight(distance)
    @x = @x + distance
    @image.x = @x
  end

  # Moves left "distance" pixels
  def moveLeft(distance)
    @x = @x - distance
    @image.x = @x
  end

  # Screen boundary test with a given delta
  def insideScreen(delta)
    if $playerMove == :right
      (@x + @image.width + delta) < $windowW
      
    elsif $playerMove == :left
      (@x - delta) > 0
    end
  end

  def move()
    if $playerMove == :right
      if insideScreen(@speed)
        moveRight(@speed)
      end
    elsif $playerMove == :left
      if insideScreen(@speed)
        moveLeft(@speed)
      end
    else
      self
    end
  end

  def shoot
    if $playerShoot
      $playerShoot = false
      Bullet.new((@x + (@image.width)/2), @y - 3, self.class.name.to_sym)
    end
  end

end
