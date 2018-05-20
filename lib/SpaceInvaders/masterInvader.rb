require_relative './enemy.rb'
class MasterInvader < Enemy
  attr_accessor :shield
  
  def initialize(x, y, speed = 2, path)
    @x = x
    @y = y
    @speed = speed
    @image = Image.new(path: path, height: 40, width: 80, x: x, y: y)
    @shield = true
  end

  def move()
    moveLeft(@speed)
  end

  def deactivateShield
    @shield = false
  end

  def shoot
    if shouldShoot(200 + 2*$level)
      shot = Bullet.new((@x + (@image.width)/2), (@y + @image.height), "MasterInvader")
      return shot
    end
    return nil
  end

end
