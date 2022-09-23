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
    }
    instructions = {} -- store movement instructions in a table. Each instruction will only be completed when the final node has executed it
end
function player_draw()
    for i,v in ipairs(nodes) do
        love.graphics.rectangle("fill", v.x, v.y, player.w, player.h)
    end
end
function player_update(dt)
    for i,v in ipairs(nodes) do
        -- movement based on direction
        if v.direction == dir.right then
            v.x = v.x + player.speed * dt
        elseif v.direction == dir.left then
            v.x = v.x - player.speed * dt
        elseif v.direction == dir.down then
            v.y = v.y + player.speed * dt
        elseif v.direction == dir.up then
            v.y = v.y - player.speed * dt
        end

        -- Check if player is out of bounds and then reverse their direction of movement
        if isOutOfBounds(i) and i > 1 then
            fixPadding(i, i-1)
        end
        
        if i > 1 then
            if v.direction ~= nodes[i-1].direction then
                v.direction = nodes[i-1].direction
            end 
        end
    end

    -- change direction based on keypress
    if love.keyboard.isDown("a") then
        nodes[1].direction = dir.left
    elseif love.keyboard.isDown("d") then
        nodes[1].direction = dir.right
    elseif love.keyboard.isDown("s") then
        nodes[1].direction = dir.down
    elseif love.keyboard.isDown("w") then
        nodes[1].direction = dir.up
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
    elseif nodes[index].y <= 0 then
        nodes[index].direction = dir.down
        isOutOfBounds = true
    elseif nodes[index].y >= love.graphics.getHeight() then
        nodes[index].direction = dir.up
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