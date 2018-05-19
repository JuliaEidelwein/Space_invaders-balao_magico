require 'ruby2d'

# Emulated Abstract Class 
class Ship
  
  attr_accessor :x, :y, :speed, :image  

  def initialize(_env)
    raise "Initialization must be implemented by subclass"
  end
  
  def moveRight(distance)
    raise "MoveRight must be implemented by subclass"
  end

  def moveLeft(distance)
    raise "MoveLeft must be implemented by subclass"
  end

  def move()
    raise "Move must be implemented by subclass"
  end

  def shoot()
    raise "Shoot must be implemented by subclass"
  end

end
