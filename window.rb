require 'ruby2d'

def setMenu()
	
	gameName = Text.new(font: "fonts/ARCADE.TTF", size: 75)
	gameName.x = 35
	gameName.y = 120
	gameName.text = "Space Invaders"

	
	gameEdition = Text.new(font: "fonts/IndustrialRevolution-Regular.ttf", size:35)
	gameEdition.x = 330
	gameEdition.y = 180
	gameEdition.text = "Balao Magico Edition"

	playButton = Text.new(font: "fonts/ARCADECLASSIC.TTF", size:50)
	playButton.x = 230
	playButton.y = 270
	playButton.text = "Play"

	playButton = Text.new(font: "fonts/ARCADECLASSIC.TTF", size:50)
	playButton.x = 233
	playButton.y = 340
	playButton.text = "Exit"

	return gameName, gameEdition, playButton
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


set title: "Space Invaders - Balao Magico Edition"
set heigth: 450, width:600
gameName, gameEdition, playButton = setMenu()
balloonIcon = Image.new(path: "images/balloon2.png")
balloonIcon.width = 40
balloonIcon.height = 40
balloonIcon2 = copyImage(balloonIcon)
balloonIcon3 = copyImage(balloonIcon)
balloonIcon4 = copyImage(balloonIcon)

tick = 0
update do
	mouseX = get:mouse_x
	mouseY = get:mouse_y
	if mouseX.to_s.to_i >= 230 and mouseX.to_s.to_i <= 340 and mouseY.to_s.to_i >= 280 and mouseY.to_s.to_i <= 310
		balloonIcon.x = 185
		balloonIcon.y = 275
		balloonIcon2.x = 343
		balloonIcon2.y = 275

		balloonIcon3.x = 600
		balloonIcon3.y = 450
		balloonIcon4.x = 600
		balloonIcon4.y = 450
	elsif mouseX.to_s.to_i >= 233 and mouseX.to_s.to_i <= 338 and mouseY.to_s.to_i >= 350 and mouseY.to_s.to_i <= 380
		balloonIcon3.x = 187
		balloonIcon3.y = 344
		balloonIcon4.x = 340
		balloonIcon4.y = 344		

		balloonIcon.x = 600
		balloonIcon.y = 450
		balloonIcon2.x = 600
		balloonIcon2.y = 450
	else
		balloonIcon.x = 600
		balloonIcon.y = 450
		balloonIcon2.x = 600
		balloonIcon2.y = 450
		balloonIcon3.x = 600
		balloonIcon3.y = 450
		balloonIcon4.x = 600
		balloonIcon4.y = 450
	end
	if tick % 30 == 0
		gameEdition.color = 'random'
		tick = 0
	end
	tick += 1
end

show

