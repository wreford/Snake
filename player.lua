function player_load()
    dir = {
        right = "right",
        left = "left",
        down = "down",
        up = "up"
    }
    nodes = {
        {x = 100, y = 100, direction = dir.right}
    }
    player = {
        speed = 200,
        w = 20,
        h = 20,
        padding = 5,
        direction = dir.right
    }
    timer = 0;
end
function player_draw()
    for i,v in ipairs(nodes) do
        love.graphics.rectangle("fill", v.x, v.y, player.w, player.h)
    end
end
function player_update(dt)
    timer = timer + dt
    for i,v in ipairs(nodes) do
        -- Check if player is out of bounds and then reverse their direction of movement
        if isOutOfBounds(i) and i > 1 then
            -- fixPadding(i, i-1)
            print("out of bounds")
        end
    end

    -- move the back node to the front of the leader to imitate movement
    if timer >= 0.3 then
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
    end
    -- change direction based on keypress
    if love.keyboard.isDown("a") and player.direction ~= dir.right then
        player.direction = dir.left
    elseif love.keyboard.isDown("d") and player.direction ~= dir.left then
        player.direction = dir.right
    elseif love.keyboard.isDown("s") and player.direction ~= dir.up then
        player.direction = dir.down
    elseif love.keyboard.isDown("w") and player.direction ~= dir.down then
        player.direction = dir.up
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
    local node = nodes[num]
    local new_node = {
        direction = node.direction
    }
    -- Calculate the appropriate placement based on the direction of travel of the node in front
    if player.direction == dir.right then
        new_node.x = node.x - (player.w + player.padding)
        new_node.y = node.y
    elseif player.direction == dir.left then
        new_node.x = node.x + (player.w + player.padding)
        new_node.y = node.y
    elseif player.direction == dir.up then
        new_node.x = node.x
        new_node.y = node.y + (player.w + player.padding)
    elseif player.direction == dir.down then
        new_node.x = node.x
        new_node.y = node.y - (player.h + player.padding)
    end
    
    -- calculate which instruction to follow
    if num == 1 then
        new_node.instruction = 1
    elseif num > 1 then
        new_node.instruction = node.instruction
    end

    table.insert(nodes, new_node)

    print("new node inserted")
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