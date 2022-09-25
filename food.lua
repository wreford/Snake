function food_load()
    food = {
        x = 0,
        y = 50,
        w = player.w,
        h = player.h,
    }
    spawn_area = {
        minX = player.w,
        minY = player.h,
        maxX = love.graphics.getWidth() - (player.w * 2),
        maxY = love.graphics.getHeight() - (player.h * 2),
    }
    randomSpawn()
    overlappingWithSnakeBody = false
end
function food_draw()
    set_color(255,233,0)
    love.graphics.rectangle("fill", food.x, food.y, food.w, food.h)
    set_color(1,1,1)
end
function food_update(dt)
    if collisonDetectedNoWidthHeight(nodes[1], food) then
        incrementScore()
        randomSpawn()
    end
end
function randomSpawn()
    math.randomseed( os.time() )
    food.x = math.random(spawn_area.minX, spawn_area.maxX)
    food.y = math.random(spawn_area.minY, spawn_area.maxY)
end