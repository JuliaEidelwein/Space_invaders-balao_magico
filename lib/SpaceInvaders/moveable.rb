class Moveable

  # Runtime polymorphism using Duck Typing
  def move(moveableObject)
    moveableObject.move
  end

  def shoot(moveableObject)
    moveableObject.shoot
  end

  def colliding(moveableObject)
    self.colliding(moveableObject)
  end

end
