require_relative './enemy.rb'
class MasterInvader < Enemy
  @shield = true
  
  def move()
    moveRight
  end

  def deactivateShield
    @shield = false
  end

end
