require_relative './ship.rb'
class Enemy < Ship
	
  # Direction of all the enemies
  @@invaderDirection = "Right"

  # Screen boundary test with a given delta
  def insideScreen(delta)

    return ((@x + @image.width + delta) < $windowW and (@x - delta) > 0) ? true : false

  end

  def invaderDirection()
    @@invaderDirection
  end

  # Defines enemies direction based on current direction an screen boundary test 
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

