#Ruby requires

#Other files


require_relative './SpaceInvaders/utils.rb'
require_relative './SpaceInvaders/masterInvader.rb'
require_relative './SpaceInvaders/invader.rb'
require_relative './SpaceInvaders/moveable.rb'
require_relative './SpaceInvaders/bullet.rb'
require_relative './SpaceInvaders/player.rb'



set title: "Space Invaders - Balao Magico Edition"
$windowH = 450
$windowW = 600
set heigth: $windowH, width: $windowW

gameName, gameEdition, @playButton, @exitButton, playButtonSound = setMenu()

balloonIcon = createBalloonIcon(40,40)
balloonIcon2 = createBalloonIcon(40,40)

gameMusic = nil
player = nil
enemies = nil
shots = Array.new()

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
      balloonIcon2.x = 345
      balloonIcon2.y = 275
      if !wasMouseOver
        playButtonSound.play
      end
    elsif isMouseOver(@exitButton)
      balloonIcon.x = 187
      balloonIcon.y = 344
      balloonIcon2.x = 344
      balloonIcon2.y = 344
    else
      hide(balloonIcon)
      hide(balloonIcon2)
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
    shot = player.shoot
    if shot != nil
      shots.push(shot)
    end
    $playerMove = "None"
    leftEnemy, rightEnemy = borderEnemies(enemies)
    if enemies[0].invaderDirection == "Right"
      enemies[rightEnemy].decideDirection()
    else
      enemies[leftEnemy].decideDirection()
    end
    shots.each do |shot|      
      enemies.each do |enemy|
        hit = shot.hitAShip(enemy.image)
        if hit != nil
          enemies.delete(enemy)
          hide(enemy.image)
          enemy = nil
        end
      end
    end
    enemies.each do |enemy|
      enemy.move
    end
    shots.each do |shot|
      shot.move()
      if shot.hitShip or !shot.insideScreen(shot.speed)
        shots.delete(shot)
        hide(shot.shape)
        shot = nil
      end
    end
    if enemies.length == 0
      @gameStatus = "Completed"
    else
      enemies[0].timeToApproach = false
    end
  end
end
show
