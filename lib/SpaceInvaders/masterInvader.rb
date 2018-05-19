require_relative './invader.rb'
class MasterInvader < Invader
  @shield = true
  
  def move()
    moveRight
  end

  def deactivateShield
    @shield = false
  end

end
