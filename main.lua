require "title"
require "game"
require "player"

menu = "game"
playable = true

function love.load()

end
function love.draw()
    if menu == "title" then

    elseif menu == "game" then

    end
end
function love.update(dt)
    if menu == "title" then

    elseif menu == "game" then

    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end