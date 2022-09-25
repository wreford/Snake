function title_load()
    
end
function title_draw()
    printCentreTextOnX("Snake Clone", hugeText, 20)
    -- createButtonCentreOnX(text, font, btn_y, action)
    -- createButtonCentreOnX("Play", normalText, 200, function() changeMenu("game") end)
    -- createButtonWithFixedWidthCenteredOnX(text, font, btn_y, btn_w, action)
    createButtonWithFixedWidthCenteredOnX("Play", normalText, 200, 200, function() changeMenu("game") end)
    createButtonWithFixedWidthCenteredOnX("Quit Game", normalText, 250, 200, function() quitGame() end)


end
function title_update(dt)

end
