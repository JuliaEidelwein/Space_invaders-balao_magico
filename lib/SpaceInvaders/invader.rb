require_relative './enemy.rb'
class Invader < Enemy

  @@invaderDirection = "Right"
  @@timeToApproach = false # Stores information about whether Invaders should approach the screen bottom or not
  

  def initialize(x, y, speed = 10, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 50, width: 45, x: x, y: y)
  end

  # Setter for timeToApproach 
  def timeToApproach= (value)
    @@timeToApproach = value
  end

  def moveDown()
    @y = @y + 10 + $level
    @image.y = @y
  end

  def decideDirection()
    if @@invaderDirection == "Right"
      if !insideScreen(@speed)
        @@invaderDirection = "Left"
        @@timeToApproach = true
      end
    elsif @@invaderDirection == "Left"
      if !insideScreen(@speed)
        @@invaderDirection = "Right"
        @@timeToApproach = true
      end 
    end
  end

  def move()
    if @@invaderDirection == "Right"
      if @@timeToApproach
        moveDown
      end
      moveRight(@speed)
    else
      if @@timeToApproach
        moveDown
      end
      moveLeft(@speed)
    end
  end

end
