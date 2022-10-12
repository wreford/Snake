function player_load()
    dir = {
        right = "right",
        left = "left",
        down = "down",
        up = "up"
    }
    player = {
        speed = 200,
        w = 20,
        h = 20,
        padding = 5,
        direction = dir.right
    }    
    nodes = {
        {x = 100, y = 100, direction = player.direction}
    }

    timer = 0
    max_time = 0.3
    isKeyPressEnabled = true
end
function player_draw()
    for i,v in ipairs(nodes) do
        if gameover then
            love.graphics.setColor(1,0,0)
        elseif i == 1 then
            set_color(0, 170, 237)
        else
            love.graphics.setColor(1,1,1)
        end
        love.graphics.rectangle("fill", v.x, v.y, player.w, player.h)
    end
end
function player_update(dt)
    timer = timer + dt
    
    for i,v in ipairs(nodes) do
        -- Collision logic (If the head touches another part of body, then it's gameover)
        if i ~= 1 then
            if collisonDetectedNoWidthHeight(nodes[1], v) then
                triggerGameOver()     
            elseif collisonDetectedNoWidthHeight(v, food) then
                randomSpawn()
            end       
        end
        isOutOfBounds(i)
    end

    -- move the back node to the front of the leader to imitate movement
    if timer >= max_time then
        local newX = nodes[1].x
        local newY = nodes[1].y
        if player.direction == dir.right then
            newX = nodes[1].x + (player.w + player.padding)
        elseif player.direction == dir.left then
            newX = nodes[1].x - (player.w + player.padding)
        elseif player.direction == dir.down then
            newY = nodes[1].y + (player.h + player.padding)
        elseif player.direction == dir.up then
            newY = nodes[1].y - (player.h + player.padding)
        end
        moveBackNodeToFront(newX, newY)
        timer = 0
        isKeyPressEnabled = true -- Enable Keypresses since the head has moved
    end
    -- change direction based on keypress
    if isKeyPressEnabled and menu == "game" then
        if love.keyboard.isDown("a") and player.direction ~= dir.right then
            player.direction = dir.left
            isKeyPressEnabled = false
        elseif love.keyboard.isDown("d") and player.direction ~= dir.left then
            player.direction = dir.right
            isKeyPressEnabled = false
        elseif love.keyboard.isDown("s") and player.direction ~= dir.up then
            player.direction = dir.down
            isKeyPressEnabled = false
        elseif love.keyboard.isDown("w") and player.direction ~= dir.down then
            player.direction = dir.up
            isKeyPressEnabled = false
        end
    end
end

function isOutOfBounds(index)
    local isOutOfBounds = false
    local node = nodes[index]
    if nodes[index].x + player.w <= 0 then
        nodes[index].x = love.graphics.getWidth()
        isOutOfBounds = true
    elseif nodes[index].x >= love.graphics.getWidth() then
        nodes[index].x = -player.w
        isOutOfBounds = true
    elseif nodes[index].y + player.h <= 0 then
        nodes[index].y = love.graphics.getWidth()
        isOutOfBounds = true
    elseif nodes[index].y >= love.graphics.getHeight() then
        nodes[index].y = -player.h
        isOutOfBounds = true
    end
    return isOutOfBounds
end

function addNode()
    local num = table.getn(nodes)
    local node = nodes[num] -- Store the current end node
    -- Create the structure for the new node
    local new_node = {
        direction = node.direction
    }
    -- Calculate the appropriate placement based on the direction of travel of the previous end node
    if node.direction == dir.right then
        new_node.x = node.x - (player.w + player.padding)
        new_node.y = node.y
    elseif node.direction == dir.left then
        new_node.x = node.x + (player.w + player.padding)
        new_node.y = node.y
    elseif node.direction == dir.up then
        new_node.x = node.x
        new_node.y = node.y + (player.w + player.padding)
    elseif node.direction == dir.down then
        new_node.x = node.x
        new_node.y = node.y - (player.h + player.padding)
    end
    
    -- calculate which instruction to follow
    -- if num == 1 then
    --     new_node.instruction = 1
    -- elseif num > 1 then
    --     new_node.instruction = node.instruction
    -- end

    table.insert(nodes, new_node) -- Insert the new node into the nodes table
end

function travelInline(nodeI, frontI)
    if nodes[nodeI].direction == nodes[frontI].direction then        
        if nodes[nodeI].direction == dir.right or nodes[nodeI].direction == dir.left then
            nodes[nodeI].y = nodes[frontI].y            
        elseif nodes[nodeI].direction == dir.up or nodes[nodeI].direction == dir.down then
            nodes[nodeI].x = nodes[frontI].x
        end
    end
end

function fixPadding(nodeI, frontI)
    if nodes[nodeI].direction == dir.right then
        nodes[nodeI].x = nodes[frontI].x - (player.w + player.padding)
    elseif nodes[nodeI].direction == dir.left then
        nodes[nodeI].x = nodes[frontI].x + (player.w + player.padding)
    elseif nodes[nodeI].direction == dir.up then
        nodes[nodeI].y = nodes[frontI].y + (player.h + player.padding)
    elseif nodes[nodeI].direction == dir.down then
        nodes[nodeI].y = nodes[frontI].y - (player.h + player.padding)
    end
end

function moveBackNodeToFront(newX, newY)    
    local num = table.getn(nodes)
    nodes[1].direction = player.direction
    if num == 1 then
        nodes[1].x = newX
        nodes[1].y = newY
    else
        local tempNode = nodes[num]
        tempNode.x = newX
        tempNode.y = newY
        table.remove(nodes, num)
        table.insert(nodes, 1, tempNode)
    end
end