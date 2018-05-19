require_relative './enemy.rb'
class Invader < Enemy

  @@invaderDirection = "Right"
  @@timeToApproach = false
  

  def initialize(x, y, speed = 10, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 50, width: 45, x: x, y: y)
  end

  def timeToApproach= (value)
    @@timeToApproach = value
  end

  def moveDown()
    @y = @y + 10
    @image.y = @y
    #@@timeToApproach = false
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

  def shoot()
    raise "Shoot must be implemented"
  end

end
