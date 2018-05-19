require_relative './ship.rb'
class Enemy < Ship
	
  @@invaderDirection = "Right"
  
  def insideScreen()
    #screenW = get:width
    screenW = 600
    return ((@x + @image.width) < screenW and @x > 0) ? true : false
  end

  def insideScreen(delta)
    #screenW = get:width
    screenW = 600
    return ((@x + @image.width + delta) < screenW and (@x - delta) > 0) ? true : false
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

end

