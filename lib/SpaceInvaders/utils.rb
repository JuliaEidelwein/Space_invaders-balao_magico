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

  # Create Game's Music Theme
  gameMusic = Music.new(File.join(File.dirname(__FILE__), "../../data/sounds/gameMusic.mp3"))

  # Repeate music after it ends
  gameMusic.loop = true
  gameMusic.play

  return player, enemies, gameMusic

end

# Creates an Image of "balloon.png" with specified width and height 
def createBalloonIcon(width, height)

  balloonIcon = Image.new(path: File.join(File.dirname(__FILE__), "../../data/images/balloon.png"))
  balloonIcon.width = width
  balloonIcon.height = height

  return balloonIcon

end

# Tests if mouse's cursor is over the item
def isMouseOver(item)

  mouseX = get :mouse_x
  mouseY = get :mouse_y

  return item.contains?(mouseX.to_i, mouseY.to_i)

end

# Finds the Index of the enemies that are closer to left and right boundaries 
def borderEnemies(enemies)

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
    @gameStatus = "PreparingToGame"
  elsif isMouseOver(@exitButton)
    close
  end

end

# Keyboard events, both define player's direction based on the pressed key
on :key_down do |e|

  key = e.key
  if key.to_s == "left"
    $playerMove = "Left"
  elsif key.to_s == "right"
    $playerMove = "Right"
  elsif e.key == "space"
    $playerMove = "space"
  else
    $playerMove = "None"
  end

end

on :key_held do |e|

  key = e.key
  if key.to_s == "left"
    $playerMove = "Left"
  elsif key.to_s == "right"
    $playerMove = "Right"
  elsif e.key == "space"
    $playerMove = "space"
  else
    $playerMove = "None"
  end

end

