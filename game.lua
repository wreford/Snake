function game_load()
    player_load()
    food_load()
    pause = false
    gameover = false
    score = 0
end
function game_draw()
    set_color(255,255,255)
    love.graphics.print("Score: "..score, normalText, 10, 10)
    player_draw()
    food_draw()

    if gameover then
        gameover_draw()
    end
end
function game_update(dt)
    if pause == false then
        player_update(dt)
        food_update(dt)
    end
    if gameover then
        gameover_update(dt)
    end
end

function triggerGameOver()
    pause = true
    gameover = true
end

function incrementScore()
    score = score + 1
    addNode()
end
