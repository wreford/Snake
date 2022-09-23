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
        h = 20
    }
    instructions = {} -- store movement instructions in a table. Each instruction will only be completed when the final node has executed it
end
function player_draw()
    love.graphics.rectangle("fill", nodes[1].x, nodes[1].y, player.w, player.h)
end
function player_update(dt)
    for i,v in ipairs(nodes) do
        -- movement based on direction
        print(v.direction)
        if v.direction == dir.right then
            v.x = v.x + player.speed * dt
        elseif v.direction == dir.left then
            v.x = v.x - player.speed * dt
        elseif v.direction == dir.down then
            v.y = v.y + player.speed * dt
        elseif v.direction == dir.up then
            v.y = v.y - player.speed * dt
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

    -- Check if player is out of bounds and then reverse their direction of movement
    isOutOfBounds()
end

function isOutOfBounds()
    local node = nodes[1]
    if nodes[1].x <= 0 then
        nodes[1].direction = dir.right
    elseif nodes[1].x >= love.graphics.getWidth() then
        nodes[1].direction = dir.left
    elseif nodes[1].y <= 0 then
        nodes[1].direction = dir.down
    elseif nodes[1].y >= love.graphics.getHeight() then
        nodes[1].direction = dir.up
    end        
end