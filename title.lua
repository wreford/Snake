function title_load()
    player_load()
    
    title = {
        txt = "Snake Clone",
        y = 50,
    }
    title.w = hugeText:getWidth(title.txt)
    title.h = hugeText:getHeight(title.txt)
    title.x = gameWidth/2 - title.w /2
    title.endX = title.x + title.w 
    title.endY = title.y + title.h

    nodes[1].x = gameWidth/2
    nodes[1].y = title.y + title.h + 10

    addNode()
    addNode()
    addNode()
    addNode()
    addNode()
    addNode()

    max_time = 0.2
end
function title_draw()
    set_color(1,1,1)
    printCentreTextOnX(title.txt, hugeText, title.y)
    -- createButtonCentreOnX(text, font, btn_y, action)
    -- createButtonCentreOnX("Play", normalText, 200, function() changeMenu("game") end)
    -- createButtonWithFixedWidthCenteredOnX(text, font, btn_y, btn_w, action)
    createButtonWithFixedWidthCenteredOnX("Play", normalText, 200, 200, function() changeMenu("game") end)
    createButtonWithFixedWidthCenteredOnX("Quit Game", normalText, 250, 200, function() quitGame() end)

    player_draw()

    if nodes[1].x > title.endX + 20 and player.direction == dir.right then
        player.direction = dir.up
    elseif nodes[1].x < title.x - 20 and player.direction == dir.left then
        player.direction = dir.down
    end
    if nodes[1].y < title.y - 30 and player.direction == dir.up then
        player.direction = dir.left
    elseif nodes[1].y >= 100 and player.direction == dir.down then
        player.direction = dir.right
    end
end
function title_update(dt)
    player_update(dt)
end
