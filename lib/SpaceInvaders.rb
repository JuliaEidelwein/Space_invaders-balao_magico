#Ruby requires

#Other files


require_relative './SpaceInvaders/utils.rb'
require_relative './SpaceInvaders/masterInvader.rb'
require_relative './SpaceInvaders/moveable.rb'
require_relative './SpaceInvaders/bullet.rb'
require_relative './SpaceInvaders/player.rb'



set title: "Space Invaders - Balao Magico Edition"
set heigth: 450, width: 600

gameName, gameEdition, @playButton, @exitButton, playButtonSound = setMenu()

balloonIcon = createBalloonIcon(40,40)
balloonIcon2 = createBalloonIcon(40,40)

gameMusic = nil
player = nil
enemies = nil

@gameStatus = "Menu"
tick = 0
wasMouseOver = false
update do
  if @gameStatus == "Menu"
    if tick % 30 == 0
      gameEdition.color = 'random'
      tick = 0
    end
    tick += 1

    if isMouseOver(@playButton)
      balloonIcon.x = 185
      balloonIcon.y = 275
      balloonIcon2.x = 343
      balloonIcon2.y = 275
      if !wasMouseOver
        playButtonSound.play
      end
    elsif isMouseOver(@exitButton)
      balloonIcon.x = 187
      balloonIcon.y = 344
      balloonIcon2.x = 340
      balloonIcon2.y = 344
    else
      hideImage(balloonIcon)
      hideImage(balloonIcon2)
      playButtonSound.stop
    end
    wasMouseOver = isMouseOver(@playButton)
  elsif @gameStatus == "PreparingToGame"
    playButtonSound.stop
    player, enemies, gameMusic = setGameScreen()
    hideMenu(gameName, gameEdition, @playButton, @exitButton, balloonIcon, balloonIcon2)
    @gameStatus = "Playing"
  elsif @gameStatus == "Playing"
    player.move
    $playerMove = "None"
    leftEnemy, rightEnemy = borderEnemies(enemies)
    enemies[leftEnemy].decideDirection()
    enemies[rightEnemy].decideDirection()
    enemies.each do |enemy|
      enemy.move
    end
    enemies[0].timeToApproach = false
  end
end
show
