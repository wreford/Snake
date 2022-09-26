require "title"
require "game"
require "gameover"
require "player"
require "food"

-- Lib imports
require "common"
require "libs/printText"
require "libs/customButtons"

menu = "title"
playable = true

function love.load()
    common_load()
    game_load()
    title_load()
end
function love.draw()
    if menu == "title" then
        title_draw()
    elseif menu == "game" then
        game_draw()
    end
end
function love.update(dt)
    if menu == "title" then
        title_update(dt)
    elseif menu == "game" then
        game_update(dt)
    end
end

function love.keypressed(key)
    if key == "v" then
        addNode()
    end
    if key == "escape" then
        quitGame()
    end
    if menu == "title" then
        if key == "v" then
            print("x: "..nodes[1].x)
            print("y: "..nodes[1].y.."\n")
        end
    end
end
