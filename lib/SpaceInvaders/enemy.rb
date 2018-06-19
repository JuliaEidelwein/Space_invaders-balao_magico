require_relative './ship.rb'
class Enemy < Ship
  
  # Direction of all enemies
  @@invaderDirection = :right

  
  def initialize(x, y, speed = 10, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 50, width: 45, x: x, y: y)
  end
  
  # Screen boundary test with a given delta
  def insideScreen(delta)
    ((@x + @image.width + delta) < $windowW and (@x - delta) > 0)
  end

  # Defines enemies direction based on current direction an screen boundary test 
  def decideDirection()
    if @@invaderDirection == :right
      if !insideScreen(@speed)
        @@invaderDirection = :left
      end

    elsif @@invaderDirection == :left
      if !insideScreen(@speed)
        @@invaderDirection = :right
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
    if @@invaderDirection == :right
      moveRight(@speed)
    else
      moveLeft(@speed)
    end
  end

  def shouldShoot(probability)
    srand
    r = rand(10000)
    return r < probability
  end

  def shoot()
    if shouldShoot(10 + 2*$level)
      Bullet.new((@x + (@image.width)/2), (@y + @image.height), self.class.name.to_sym)
    end
  end

end

