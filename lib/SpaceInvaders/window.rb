require 'ruby2d'

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

  return gameName, gameEdition, playButton, exitButton
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
  windowH = get:heigt
  windowW = get:width
  image.x = windowW.to_s.to_i
  image.y = windowH.to_s.to_i
end

def createBalloonIcon(width, height)
  balloonIcon = Image.new(path: File.join(File.dirname(__FILE__), "../../data/images/balloon2.png"))
  balloonIcon.width = width.to_i
  balloonIcon.height = height.to_i

  return balloonIcon
end

def isMouseOver(item)
  mouseX = get :mouse_x
  mouseY = get :mouse_y

  return item.contains?(mouseX.to_i, mouseY.to_i)
end

def initializeWindow()
  set title: "Space Invaders - Balao Magico Edition"
  set heigth: 450, width: 600
  _, gameEdition, playButton, exitButton = setMenu()

  balloonIcon = createBalloonIcon(40,40)
  balloonIcon2 = createBalloonIcon(40,40)

  tick = 0
  update do
    if tick % 30 == 0
      gameEdition.color = 'random'
      tick = 0
    end
    tick += 1

    if isMouseOver(playButton)
      balloonIcon.x = 185
      balloonIcon.y = 275
      balloonIcon2.x = 343
      balloonIcon2.y = 275

    elsif isMouseOver(exitButton)
      balloonIcon.x = 187
      balloonIcon.y = 344
      balloonIcon2.x = 340
      balloonIcon2.y = 344
    else
      hideImage(balloonIcon)
      hideImage(balloonIcon2)
    end
  end
  show
end
