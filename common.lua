-- Load some shared variables
function common_load()
    smallText = love.graphics.newFont('assets/PlaymegamesReguler-2OOee.ttf', 12)
    normalText = love.graphics.newFont('assets/PlaymegamesReguler-2OOee.ttf', 18)
    bigText = love.graphics.newFont('assets/PlaymegamesReguler-2OOee.ttf', 30)
    hugeText = love.graphics.newFont('assets/PlaymegamesReguler-2OOee.ttf', 50)

    gameWidth = love.graphics.getWidth()
    gameHeight = love.graphics.getHeight()
end

function quitGame()
    love.event.push("quit")
end
function changeMenu(menuName)
    if menuName == "title" then
        title_load()
        menu = "title"
    elseif menuName == "game" then
        game_load()
        menu = "game"
    end
end
-- Check for collisions
function collisonDetected(obj1, obj2)
    if obj1.x < obj2.x + obj2.w and obj1.x + obj1.w > obj2.x and obj1.y < obj2.y + obj2.h and obj1.h + obj1.y > obj2.y then
        return true
    end
    return false
end

-- New Collision Detection for objects with no width/height attributes
function collisonDetectedNoWidthHeight(obj1, obj2)
    if obj1.x < obj2.x + player.w and obj1.x + player.w > obj2.x and obj1.y < obj2.y + player.h and player.h + obj1.y > obj2.y then
        return true
    end
    return false
end

-- Set color on a scale from 0-255 rather than 0-1
function set_color(red, green, blue)
    love.graphics.setColor(red/255, green/255, blue/255)
end