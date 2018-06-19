require 'ruby2d'

# This funciton creates and sets the position of game menu's elements
def setMenu()

  # Define the game's title text
  gameName = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADE.TTF"), size: 75)
  gameName.x = 35
  gameName.y = 120
  gameName.text = "Space Invaders"

  # Define the game's edition text
  gameEdition = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/IndustrialRevolution-Regular.ttf"), size:35)
  gameEdition.x = 330
  gameEdition.y = 180
  gameEdition.text = "Balao Magico Edition"

  # Define Play button text
  playButton = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADECLASSIC.TTF"), size:50)
  playButton.x = 230
  playButton.y = 270
  playButton.text = "Play"

  # Define Exit button text
  exitButton = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADECLASSIC.TTF"), size:50)
  exitButton.x = 233
  exitButton.y = 340
  exitButton.text = "Exit"

  # Define Play button's Sound Effect
  playButtonSound = Music.new(File.join(File.dirname(__FILE__), "../../data/sounds/startSound.mp3"))

  return gameName, gameEdition, playButton, exitButton, playButtonSound

end

# This funciton hides an object by placing it outside the screen 
def hide(object)
  object.x = $windowW
  return object
end

# Hide funtion applied to all elements of Game Menu
def hideMenu(title, edition, play, exit, balloon1, balloon2)

  return hide(title), hide(edition), hide(play), hide(exit), hide(balloon1), hide(balloon2)

end

# Hide funtion applied to all elements of Game Menu
def hideFinishedGame(player, enemies, scoreText, masterEnemy, shots)
  
  player.image = hide(player.image)

  enemies.each do |enemy|
    enemy.image = hide(enemy.image)
    enemies.delete(enemy)
  end

  if masterEnemy != nil
    masterEnemy.image = hide(masterEnemy.image)
  end

  shots.each do |shot|
    hide(shot.shape)
    shots.delete(shot)
  end

  return player, enemies, hide(scoreText), masterEnemy, shots

end

# This function creates all game elements and set their position
def setGameScreen()

  # Create a Player, placing it on the bottom of the screen
  player = Player.new(290, 405, 5, File.join(File.dirname(__FILE__), "../../data/images/balloon.png"))
  enemies = Array.new(24)

  # Create an array of Enemies, distributing them into 3 rows
  for i in 0..23
    if i < 8  # First Row

      enemies[i] = Invader.new((20 + i*46), 20, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon5.png"))

    elsif i >=8 and i < 16  # Second Row
      enemies[i] = Invader.new((20 + (i-8)*46), 75, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon7.png"))

    else  # Third Row
      enemies[i] = Invader.new((20 + (i-16)*46), 130, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon13.png"))
    end

  end

  # Create Score Text
  scoreText = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADECLASSIC.TTF"), size:22)
  scoreText.x = 10
  scoreText.y = 0
  scoreText.text = "Score #{player.score}"

  # Create Game's Music Theme
  gameMusic = Music.new(File.join(File.dirname(__FILE__), "../../data/sounds/gameMusic.mp3"))

  # Repeate music after it ends
  gameMusic.loop = true
  gameMusic.play

  return player, enemies, scoreText, gameMusic

end

def refillEnemies()

  # Create a new array of Enemies, distributing them into 3 rows
 enemies = Array.new(24) 
 for i in 0..23
    if i < 8  # First Row

      enemies[i] = Invader.new((20 + i*46), 20, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon5.png"))

    elsif i >=8 and i < 16  # Second Row
      enemies[i] = Invader.new((20 + (i-8)*46), 75, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon7.png"))

    else  # Third Row
      enemies[i] = Invader.new((20 + (i-16)*46), 130, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon13.png"))
    end

 end

  return enemies

end

# Creates an Image of "balloon.png" with specified width and height 
def createBalloonIcon(width, height)

  balloonIcon = Image.new(path: File.join(File.dirname(__FILE__), "../../data/images/balloon.png"))
  balloonIcon.width = width
  balloonIcon.height = height

  return balloonIcon

end

def showGameOverScreen(score)
  alertScreen = Rectangle.new(color: ['red', 'purple', 'yellow', 'teal'], width: $windowW, height: $windowH - 100, x: 0, y: 50)
  
  gameOverText = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADECLASSIC.TTF"), size:100)
  gameOverText.x = 75
  gameOverText.y = 70
  gameOverText.text = "Game Over"

  scoreText = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/IndustrialRevolution-Regular.ttf"), size:60)
  scoreText.x = 75
  scoreText.y = 240
  scoreText.text = "Your final score is #{score}"

  backButton = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/IndustrialRevolution-Regular.ttf"), size:30)
  backButton.x = 450
  backButton.y = 320
  backButton.text = "Exit"
  
  return alertScreen, gameOverText, scoreText, backButton

end

# Tests if mouse's cursor is over the item
def isMouseOver(item)

  mouseX = get :mouse_x
  mouseY = get :mouse_y
  
  if item != nil 
    return item.contains?(mouseX.to_i, mouseY.to_i)
  end
  
  return false

end

# Finds the Index of the enemies that are closer to left and right boundaries 
def borderEnemies(enemies)
  
  if enemies.length == 1
    return 0, 0
  end

  leftEnemy = 0
  rightEnemy = 0

  enemies.each_with_index do |enemy, index|
    if enemies[leftEnemy].x > enemy.x
      leftEnemy = index
    end
    if enemies[rightEnemy].x < enemy.x
      rightEnemy = index
    end
  end

  return leftEnemy, rightEnemy

end

# Mouse click event
on :mouse_down do |e|

  if isMouseOver(@playButton)
    @gameStatus = "PreparingGame"
  elsif isMouseOver(@exitButton)
    close
  elsif isMouseOver(@returnButton)
    close
  end

end

# Keyboard events, both define player's direction based on the pressed key
on :key_down do |e|
  if e.key.to_sym == :left
    $playerMove = :left
  elsif e.key.to_sym == :right
    $playerMove = :right
  elsif e.key.to_sym == :space
    $playerShoot = true
  else
    $playerMove = :none
    $playerShoot = false
  end

end

on :key_held do |e|

  if e.key.to_sym == :left
    $playerMove = :left
  elsif e.key.to_sym == :right
    $playerMove = :right
  else
    $playerMove = :none
  end

end

