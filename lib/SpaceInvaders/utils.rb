require 'ruby2d'


require_relative './masterInvader.rb'
require_relative './moveable.rb'
require_relative './bullet.rb'
require_relative './player.rb'


def setMenu()

  gameName = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADE.TTF"), size: 75)
  gameName.x = 35
  gameName.y = 120
  gameName.text = "Space Invaders"

  gameEdition = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/IndustrialRevolution-Regular.ttf"), size:35)
  gameEdition.x = 330
  gameEdition.y = 180
  gameEdition.text = "Balao Magico Edition"

  playButton = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADECLASSIC.TTF"), size:50)
  playButton.x = 230
  playButton.y = 270
  playButton.text = "Play"

  exitButton = Text.new(font: File.join(File.dirname(__FILE__), "../../data/fonts/ARCADECLASSIC.TTF"), size:50)
  exitButton.x = 233
  exitButton.y = 340
  exitButton.text = "Exit"

  playButtonSound = Music.new(File.join(File.dirname(__FILE__), "../../data/sounds/startSound.mp3"))

  return gameName, gameEdition, playButton, exitButton, playButtonSound
end

def hide(object)
  windowW = get :width
  object.x = windowW
  return object
end

def hideMenu(title, edition, play, exit, balloon1, balloon2)
  return hide(title), hide(edition), hide(play), hide(exit), hide(balloon1), hide(balloon2)
end


def setGameScreen()
  player = Player.new(290, 400, 5, File.join(File.dirname(__FILE__), "../../data/images/balloon.png"))
  enemies = Array.new(24)
  for i in 0..23
    if i < 8
      enemies[i] = Invader.new((20 + i*46), 20, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon5.png"))
    elsif i >=8 and i < 16
      enemies[i] = Invader.new((20 + (i-8)*46), 75, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon7.png"))
    else
      enemies[i] = Invader.new((20 + (i-16)*46), 130, 1, File.join(File.dirname(__FILE__), "../../data/images/balloon13.png"))
    end
  end
  gameMusic = Music.new(File.join(File.dirname(__FILE__), "../../data/sounds/gameMusic.mp3"))
  gameMusic.loop = true
  gameMusic.play


  return player, enemies, gameMusic
end

def copyImage(image)
  newImage = Image.new(path: image.path)
  newImage.width = image.width
  newImage.height = image.height
  newImage.x = image.x
  newImage.y = image.y
  return newImage
end

def hideImage(image)
  windowH = get:height
  windowW = get:width
  image.x = windowW.to_s.to_i
  image.y = windowH.to_s.to_i
end

def createBalloonIcon(width, height)
  balloonIcon = Image.new(path: File.join(File.dirname(__FILE__), "../../data/images/balloon.png"))
  balloonIcon.width = width.to_i
  balloonIcon.height = height.to_i

  return balloonIcon
end

def isMouseOver(item)
  mouseX = get :mouse_x
  mouseY = get :mouse_y

  return item.contains?(mouseX.to_i, mouseY.to_i)
end

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

on :mouse_down do |e|
  if isMouseOver(@playButton)
    @gameStatus = "PreparingToGame"
  elsif isMouseOver(@exitButton)
    close
  end
end

on :key_down do |e|
  key = e.key
  if key.to_s == "left"
    $playerMove = "Left"
  elsif key.to_s == "right"
    $playerMove = "Right"
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
  else
    $playerMove = "None"
  end
end

