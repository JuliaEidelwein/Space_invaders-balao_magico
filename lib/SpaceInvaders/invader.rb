require_relative './ship.rb'
class Invader < Ship

  @@invaderDirection = "Right"

  def initialize(x, y, speed = 10, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 50, width: 45, x: x, y: y)
  end

  def insideScreen()
    #screenW = get:width
    screenW = 600
    return ((@x + 45) < screenW and @x > 0) ? true : false
  end

  def insideScreen(delta)
    #screenW = get:width
    screenW = 600
    return ((@x + 45 + delta) < screenW and (@x - delta) > 0) ? true : false
  end

  def decideDirection()
    if @@invaderDirection == "Right"
      if !insideScreen(@speed)
        @@invaderDirection = "Left"
      end
    elsif @@invaderDirection == "Left"
      if !insideScreen(@speed)
        @@invaderDirection = "Right"
      end 
    end   
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
    if @@invaderDirection == "Right"
      moveRight(@speed)
    else
      moveLeft(@speed)
    end
  end

  def shoot()
    raise "Shoot must be implemented"
  end

end
