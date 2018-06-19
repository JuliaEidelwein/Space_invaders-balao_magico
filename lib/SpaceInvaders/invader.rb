require_relative './enemy.rb'
class Invader < Enemy

  @@timeToApproach = false # Stores information about whether Invaders should approach the screen bottom or not

  def initialize(x, y, speed = 10, path)
    super(x,y,speed,path)
  end
  
  # Setter for timeToApproach 
  def timeToApproach=(boolean)
    boolean
  end
  
  def moveDown()
    @y = @y + 10 + $level
    @image.y = @y
  end

  def invaderDirection()
    @@invaderDirection
  end

  def move()
    if @@invaderDirection == :right
      if @@timeToApproach
        moveDown().moveRight(@speed)
      else
        moveRight(@speed)
      end
    elsif @@timeToApproach
      moveDown().moveLeft(@speed)
    else
      moveLeft(@speed)
    end
  end
end
