require_relative './enemy.rb'
class MasterInvader < Enemy

  attr_accessor :shield
  
  def initialize(x, y, path, speed = 2, shield = true)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 40, width: 80, x: x, y: y)
    @shield = shield
  end

  # Moves left "distance" pixels
  def moveLeft(distance)
    @x = @x - distance
    @image.x = @x
  end
  
  def move()
    moveLeft(@speed)
  end

  def deactivateShield()
    @shield = false
  end

  def shoot
    if shouldShoot(200 + 2*$level)
      Bullet.new((@x + (@image.width)/2), (@y + @image.height), self.class.name.to_sym)
    end
  end

end
