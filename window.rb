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
	playButton.y = 250
	playButton.text = "Play"
	return gameName, gameEdition, playButton
end

#on :mouse_move do |e|
#	if e.x > 230 and e.x < 280 and e.y > 230 and e.y < 240
#		@mouseOverPlay = true
#		puts "FOI"
#	end
#end


set title: "Space Invaders - Balao Magico Edition"
set heigth: 450, width:600
gameName, gameEdition, playButton = setMenu()
balloonIcon = Image.new(path: "images/balloon2.png")
balloonIcon.width = 40
balloonIcon.height = 40

tick = 0
update do
	mouseX = get:mouse_x
	mouseY = get:mouse_y
	if mouseX.to_s.to_i >= 230 and mouseX.to_s.to_i <= 340 and mouseY.to_s.to_i >= 260 and mouseY.to_s.to_i <= 290
		balloonIcon.x = 190
		balloonIcon.y = 255
	else
		balloonIcon.x = 600
		balloonIcon.y = 450
	end
	if tick % 30 == 0
		gameEdition.color = 'random'
		tick = 0
	end
	tick += 1
end

show

