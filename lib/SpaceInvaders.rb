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
masterEnemy = nil
scoreText = nil
shots = Array.new()

alertScreen = nil
gameOverText = nil
finalScoreText = nil
@returnButton = nil

gameElements = Array.new()
ships = Array.new()
moveable = Moveable.new() 

@gameStatus = "Menu"
$level = 1
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
  elsif @gameStatus == "PreparingGame"
    playButtonSound.stop
    player, enemies, scoreText, gameMusic = setGameScreen()
    hideMenu(gameName, gameEdition, @playButton, @exitButton, balloonIcon, balloonIcon2)
    gameElements.push(player)
    ships.push(player)
    enemies.each do |enemy|
      gameElements.push(enemy)
      ships.push(enemy)
    end
    @gameStatus = "Playing"
  elsif @gameStatus == "Playing"
    
    if tick % 1000 == 0
      masterEnemy = MasterInvader.new($windowW - 84, 18, 2, File.join(File.dirname(__FILE__), "../data/images/zeppelin4.png"))
      tick = 0
      gameElements.push(masterEnemy)
      ships.push(masterEnemy)
    end
    tick += 1
    
    leftEnemy, rightEnemy = borderEnemies(enemies)
    if enemies[0].invaderDirection == "Right"
      enemies[rightEnemy].decideDirection()
    else
      enemies[leftEnemy].decideDirection()
    end

    gameElements.each do |element|
      moveable.move(element)
    end
    ships.each do |ship|
      shot = moveable.shoot(ship)
      if shot != nil
        shots.push(shot)
        gameElements.push(shot)
      end
    end
    
  
    if masterEnemy != nil
      if !masterEnemy.insideScreen(masterEnemy.speed)
        hide(masterEnemy.image)
        ships.delete(masterEnemy)
        gameElements.delete(masterEnemy)
        masterEnemy = nil
      end
    end
    $playerMove = "None"

    shots.each do |shot|
      ships.each do |ship|
        hit = shot.hitAShip(ship.image, ship.class.name)
        if hit != nil
          case ship.class.name
          when "Player"
            hide(ship.image)
            ships.delete(ship)
            gameElements.delete(ship)
            @gameStatus = "Over"
          when "Invader"
            hide(ship.image)
            ships.delete(ship)
            gameElements.delete(ship)
            enemies.delete(ship)
            player.score = player.score + 10*$level
          when "MasterInvader"
            if masterEnemy.shield == true
              masterEnemy.deactivateShield
            else
              hide(ship.image)
              ships.delete(ship)
              gameElements.delete(ship)
              masterEnemy = nil
              player.score = player.score + 100*$level
            end
          end
        end
      end 
    end
    shots.each do |shot|
      if shot.hitShip or !shot.insideScreen(shot.speed)
        shots.delete(shot)
        hide(shot.shape)
        gameElements.delete(shot)
        shot = nil
      end
    end

    scoreText.text = "Score #{player.score}"
    if enemies.length == 0
      @gameStatus = "Completed"
    else
      enemies[0].timeToApproach = false
    end
  elsif @gameStatus == "Completed"
    enemies = refillEnemies
    enemies.each do |enemy|
      gameElements.push(enemy)
      ships.push(enemy)
    end
    $level = $level + 1
    @gameStatus = "Playing" 
  elsif @gameStatus == "Over"
    gameMusic.stop
    player, enemies, scoreText, masterEnemy, shots = hideFinishedGame(player, enemies, scoreText, masterEnemy, shots)
    alertScreen, gameOverText, finalScoreText, @returnButton = showGameOverScreen(player.score)
  end
end
show
