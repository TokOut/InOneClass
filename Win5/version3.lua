-- Win 5

function setup()
    -- You can change this!!
    playersPlaying = 2
    playersMaximum = 6
    
    
    -- Do not change!!
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    currentTurn = 1
    msg = "Blue's Turn"
    helpAlert = false
    helpAlertY = 0
    helpAlertClearColor = color(35, 145, 250, 255)
    helpAlertUndoColor = helpAlertClearColor
    winner = nil
    log = {}
    msgColor = color(0, 75, 255, 255)
    themeId = 1
    themeIdMaximum = 3
    
    tab = {}
    for x = 1, 25 do
        tab[x] = {}
        for y = 1, 25 do
            tab[x][y] = 0
        end
    end
end

function draw()
    background(0, 0, 0, 255)
    if helpAlert then
        fill(255, 255, 255, 255)
        rect(50, 50, WIDTH-100, HEIGHT-100)
        strokeWidth(25)
        stroke(255, 255, 255, 255)
        line(50, 50, 50, HEIGHT-50)
        line(50, 50, WIDTH-50, 50)
        line(50, HEIGHT-50, WIDTH-50, HEIGHT-50)
        line(WIDTH-50, 50, WIDTH-50, HEIGHT-50)
        strokeWidth(0)
        
        fill(0, 0, 0, 255)
        font("AmericanTypewriter-Bold")
        fontSize(45)
        text("Information", WIDTH/2, HEIGHT-65)
        
        strokeWidth(2)
        fill(255, 255, 255, 255)
        stroke(0, 0, 0, 255)
        rect(75, 75, WIDTH-150, HEIGHT-175)
        
        -- Exit Button
        fill(255, 0, 0, 255)
        strokeWidth(0)
        rect(WIDTH-165, HEIGHT-90, 125, 50)
        strokeWidth(5)
        stroke(255, 0, 0, 255)
        line(WIDTH-162.5, HEIGHT-40, WIDTH-40, HEIGHT-40)
        line(WIDTH-40, HEIGHT-87.5, WIDTH-40, HEIGHT-40)
        fill(0, 0, 0, 255)
        
        -- Entire Rules Guide
        
        clip(75, 75, WIDTH-150, HEIGHT-175)
        fill(225, 175, 25, 255)
        stroke(225, 174, 25, 255)
        strokeWidth(0)
        rect(150, helpAlertY + 550, WIDTH-300, 100)
        strokeWidth(20)
        line(150, helpAlertY + 550, WIDTH-150, helpAlertY + 550)
        line(150, helpAlertY + 550, 150, helpAlertY + 650)
        line(150, helpAlertY + 650, WIDTH-150, helpAlertY + 650)
        line(WIDTH-150, helpAlertY + 550, WIDTH-150, helpAlertY + 650)
        strokeWidth(5)
        stroke(142, 224, 129, 255)
        line(175, helpAlertY + 600, 400, helpAlertY + 600)
        line(WIDTH-175, helpAlertY + 600, WIDTH-400, helpAlertY + 600)
        strokeWidth(0)
        fill(255, 0, 0, 255)
        fontSize(50)
        font("Baskerville-Bold")
        text("Win 5", WIDTH/2, helpAlertY + 600)
        fill(0, 0, 0, 255)
        fontSize(30)
        font("AmericanTypewriter-Bold")
        text("How to Play?", WIDTH/2, helpAlertY + 500)
        fontSize(20)
        font("AmericanTypewriter")
        text("This game can only be played at least by 2 people.\nThey place somewhere a block of their color,\nand then it's the others turn. You must have 5 blocks in order to win. You can place\nhorizontally, vertically or diagonal the 5 blocks. It works in all directions ➕✖️.\nWhen the entire field is placed with blocks,the game will begin from new.", WIDTH/2, helpAlertY + 425)
        font("AmericanTypewriter-Bold")
        fontSize(30)
        text("To-Do List", WIDTH/2, helpAlertY + 340)
        fontSize(20)
        font("AmericanTypewriter")
        text("• AI for Bots playing.\n• Allow Bots for specified colors, (Currently: Red only for 1-player)\n• Fix Bug: Cannot click Help while winner-restart-alert.\n• More colors", WIDTH/2, helpAlertY + 275)
        font("AmericanTypewriter-Bold")
        fontSize(30)
        text("Settings", WIDTH/2, helpAlertY + 200)
        font("ArialRoundedMTBold")
        fontSize(20)
        
        -- Restart Button
        fill(helpAlertClearColor)
        rect(125, helpAlertY + 100, 200, 75)
        fill(255, 255, 255, 255)
        text("Clear Area", 225, helpAlertY + 160)
        fontSize(15)
        text("Activation can't\nbe undone.", 225, helpAlertY + 125)
        
        -- Undo
        fill(helpAlertUndoColor)
        rect(350, helpAlertY + 100, 200, 75)
        fill(255, 255, 255, 255)
        fontSize(20)
        text("Undo", 450, helpAlertY + 160)
        fontSize(15)
        text("The Game's Log\nwill be changed.", 450, helpAlertY + 125)
        
        -- Specify players
        fill(175, 255)
        rect(575, helpAlertY + 100, 200, 75)
        fill(0, 0, 0, 255)
        fontSize(65)
        text(playersPlaying, 675, helpAlertY + 137.5)
        fill(255, 255, 255, 255)
        rect(580, helpAlertY + 105, 65, 65)
        rect(705, helpAlertY + 105, 65, 65)
        fill(0, 0, 0, 255)
        text("➖", 612.5, helpAlertY + 137.5)
        text("➕", 737.5, helpAlertY + 137.5)
        if playersPlaying == 1 then
            fontSize(17.5)
            text("One player against computer.", 675, helpAlertY + 90)
        end
        
        -- Display
        if themeId == 1 then
            fill(0, 0, 0, 255)
        elseif themeId == 2 then
            fill(85, 255)
        elseif themeId == 3 then
            fill(173, 157, 112, 255)
        end
        rect(125, helpAlertY-225, WIDTH-250, 300)
        if themeId == 1 then
            fill(255, 255, 255, 255)
            fontSize(35)
            font("Baskerville-Bold")
            text("Dark Theme 🌚", 125 + (WIDTH-250)/2, helpAlertY + 37.5)
            stroke(100, 25, 25, 255)
            strokeWidth(20)
            line(150, helpAlertY-210, 165, helpAlertY-125)
            line(165, helpAlertY-125, 325, helpAlertY-45)
            line(325, helpAlertY-45, 500, helpAlertY-200)
            line(500, helpAlertY-200, 645, helpAlertY-175)
            stroke(0, 0, 150, 255)
            line(400, helpAlertY-210, 700, helpAlertY-100)
            line(700, helpAlertY-100, 725, helpAlertY-210)
        elseif themeId == 2 then
            fill(255, 255, 255, 255)
            fontSize(35)
            font("Baskerville-Bold")
            text("Battle Theme ♨️", 280, helpAlertY + 45)
            for x = 1,153 do
                strokeWidth(0)
                fill(math.random(50, 250), math.random(10, 100), math.random(10, 100), 255)
                rect(x * 5 + 125, helpAlertY + math.random(-220, 70), 5, 5)
            end
            fill(0, 0, 0, 255)
            text("This Theme is temporary,\nbut there is going to come\nanother for it.", WIDTH/2, helpAlertY - 75)
            sprite("Tyrian Remastered:Boss B", 210, helpAlertY - 150, 150)
        elseif themeId == 3 then
            fill(255, 255, 255, 255)
            fontSize(50)
            font("Copperplate-Light")
            text("🔸 Default 🔸", WIDTH/2, helpAlertY + 35)
            font("Baskerville-Italic")
            fontSize(25)
            fill(0, 0, 0, 255)
            text("The Default Theme is made with basic colors.", WIDTH/2, helpAlertY)
        end
        
        if themeId == 2 or themeId == 3 then -- NEW THEMES
            font("AppleColorEmoji")
            fontSize(60)
            fill(255, 255, 255, 255)
            text("🆕", 125, helpAlertY + 75)
        end
        if themeId == 2 then -- TEMPORARY THEMES
            text("🕐", 185, helpAlertY + 75)
        end
        if themeId == 2 then -- THEME WITH SOUND
            text("🔔", 245, helpAlertY + 75)
        end
        
        -- Themes P. S.
        
        fill(0, 0, 0, 255)
        font("CourierNewPS-BoldMT")
        fontSize(20)
        text("All Themes are free, and can be choosen by tapping\non the Theme Box. Then a new Theme will be displayed.\nThe symbols mean this:", WIDTH/2, helpAlertY - 275)
        font("AmericanTypewriter")
        fill(127, 127, 127, 255)
        text("🆕 - The Theme is released the latest update", WIDTH/2, helpAlertY - 325)
        text("🕐 - The Theme is temporary, or will be changed in future", WIDTH/2, helpAlertY - 375)
        text("🔔 - The Theme has Sound included.", WIDTH/2, helpAlertY - 425)
        
        -- End
        strokeWidth(0)
        clip()
    else
        for x = 1, 18 do
            for y = 1, 13 do
                strokeWidth(2)
                stroke(255, 255, 255, 255)
                if tab[x][y] == 0 then
                    if themeId == 1 then
                        fill(127, 127, 127, 255)
                    elseif themeId == 2 then
                        fill(160, 255)
                    elseif themeId == 3 then
                        fill(255, 255, 255, 255)
                    end
                elseif tab[x][y] == 1 then
                    if themeId == 1 then
                        fill(0, 0, 200, 255)
                    elseif themeId == 2 then
                        fill(100, 125, 225, 255)
                    elseif themeId == 3 then
                        fill(0, 0, 255, 255)
                    end
                elseif tab[x][y] == 2 then
                    if themeId == 1 then
                        fill(150, 0, 0, 255)
                    elseif themeId == 2 then
                        fill(225, 140, 140, 255)
                    elseif themeId == 3 then
                        fill(255, 0, 0, 255)
                    end
                elseif tab[x][y] == 3 then
                    if themeId == 1 then
                        fill(30, 150, 50, 255)
                    elseif themeId == 2 then
                        fill(0, 255, 0, 255)
                    elseif themeId == 3 then
                        fill(0, 255, 0, 255)
                    end
                elseif tab[x][y] == 4 then
                    if themeId == 1 then
                        fill(175, 165, 50, 255)
                    elseif themeId == 2 then
                        fill(210, 210, 15, 255)
                    elseif themeId == 3 then
                        fill(255, 255, 0, 255)
                    end
                elseif tab[x][y] == 5 then
                    if themeId == 1 then
                        fill(85, 40, 75, 255)
                    elseif themeId == 2 then
                        fill(135, 60, 150, 255)
                    elseif themeId == 3 then
                        fill(255, 0, 255)
                    end
                elseif tab[x][y] == 6 then
                    if themeId == 1 then
                        fill(225, 110, 25, 255)
                    elseif themeId == 2 then
                        fill(215, 175, 85, 255)
                    elseif themeId == 3 then
                        fill(255, 150, 0, 255)
                    end
                else
                    fill(0, 0, 0, 255)
                end
                rect(50 * x + 15, 50 * y, 50, 50)
            end
        end
        
        checkWins()
        checkPossiblePlacing()
        
        font("AmericanTypewriter")
        fill(msgColor)
        fontSize(35)
        text(msg, WIDTH/2, HEIGHT-30)
        
        -- Info Button (Do not change)
        
        local pos = vec2(WIDTH-225, HEIGHT-50)
        
        fill(255, 255, 255, 255)
        strokeWidth(0)
        rect(pos.x, pos.y, 200, 45)
        
        fill(127, 127, 127, 255)
        font("AmericanTypewriter-Bold")
        text("Help ❓", pos.x + 100, pos.y + 22.5)
        
        
        if winner then
            fill(color(255, 255))
            text("Touch to restart 🔄", WIDTH/2, HEIGHT/2)
        else
            
        end
    end
end

function touched(t)
    if t.state == BEGAN then
        if winner then
            if t.x>65 and t.y>50 and t.x<WIDTH-65 and t.y<HEIGHT-75 then
                for x = 1, 25 do
                    for y = 1, 25 do
                        tab[x][y] = 0
                    end
                end
                
                currentTurn = 1
                msg = "Blue's Turn"
                helpAlert = false
                winner = nil
                log = {}
                msgColor = color(0, 75, 255, 255)
                if themeId == 2 then
                    sound("A Hero's Quest:Broke")
                end
            end
        else
            if helpAlert then
                if t.x>WIDTH-165 and t.x<WIDTH-40 and t.y>HEIGHT-90 and t.y<HEIGHT then
                    print("Help Alert.. Closing...")
                    helpAlert = false
                end
            else
                for x = 1, 18 do
                    for y = 1, 13 do
                        if x * 50 + 15 < t.x and x * 50 + 65 > t.x then
                            if y * 50 < t.y and y * 50 + 50 > t.y then
                                if tab[x][y] == 0 then
                                    print("x, y = " .. x .. ", " .. y .. "\nCurrent Turn = " .. currentTurn)
                                    tab[x][y] = currentTurn
                                    table.insert(log, vec2(x, y))
                                    
                                    -- 🔈🔔📣📢 --
                                    
                                    if themeId == 2 then
                                        sound("A Hero's Quest:Arrow Shoot 1")
                                    end
                                    
                                    -- 🔴🔵 --
                                    if currentTurn == 1 then
                                        if playersPlaying == 1 then
                                            playBot(2)
                                        else
                                            currentTurn = 2
                                            msg = "Red's Turn"
                                            msgColor = color(255, 0, 0, 255)
                                        end
                                    elseif currentTurn == 2 then
                                        if playersPlaying == 2 then
                                            currentTurn = 1
                                            msg = "Blue's Turn"
                                            msgColor = color(0, 75, 255, 255)
                                        elseif playersPlaying > 2 then
                                            currentTurn = 3
                                            msg = "Green's Turn"
                                            msgColor = color(60, 150, 60, 255)
                                        end
                                    elseif currentTurn == 3 then
                                        if playersPlaying == 3 then
                                            currentTurn = 1
                                            msg = "Blue's Turn"
                                            msgColor = color(0, 75, 255, 255)
                                        elseif playersPlaying > 3 then
                                            currentTurn = 4
                                            msg = "Yellow's Turn"
                                            msgColor = color(175, 175, 0, 255)
                                        end
                                    elseif currentTurn == 4 then
                                        if playersPlaying == 4 then
                                            currentTurn = 1
                                            msg = "Blue's Turn"
                                            msgColor = color(0, 75, 255, 255)
                                        elseif playersPlaying > 4 then
                                            currentTurn = 5
                                            msg = "Purple's Turn"
                                            msgColor = color(175, 35, 200, 255)
                                        end
                                    elseif currentTurn == 5 then
                                        if playersPlaying == 5 then
                                            currentTurn = 1
                                            msg = "Blue's Turn"
                                            msgColor = color(0, 75, 255, 255)
                                        elseif playersPlaying > 5 then
                                            currentTurn = 6
                                            msg = "Orange's Turn"
                                            msgColor = color(255, 150, 0, 255)
                                        end
                                    elseif currentTurn == 6 then
                                        if playersPlaying == 6 then
                                            currentTurn = 1
                                            msg = "Blue's Turn"
                                            msgColor = color(0, 75, 255, 255)
                                        elseif playersPlaying > 6 then
                                            currentTurn = 7 -- impossible
                                            msg = "Restart please. More then 5 players playing. Not supported!"
                                            msgColor = color(255, 255, 255, 255)
                                            winner = 0
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                
                if t.x>WIDTH-225 and t.x<WIDTH-25 and t.y>HEIGHT-50 and t.y<HEIGHT-5 then
                    print("Help Alert.. Opening...")
                    helpAlert = true
                end
            end
        end
    end
    
    if helpAlert then
        if t.x > 75 and t.y > 75 and t.x < WIDTH-75 and t.y < HEIGHT-75 then
            if helpAlertY < 0 then
                helpAlertY = 0
            else
                helpAlertY = helpAlertY + t.deltaY
            end
            
            if t.x > 125 and t.x < 325 and t.y > helpAlertY + 100 and t.y < helpAlertY + 175 then
                for x = 1, 25 do
                    for y = 1, 25 do
                        tab[x][y] = 0
                        helpAlertClearColor = color(0, 255, 255, 255)
                        currentTurn = 1
                        msg = "Blue's Turn"
                        msgColor = color(0, 75, 255, 255)
                    end
                end
            end
            
            if t.x > 350 and t.x < 550 and t.y > helpAlertY + 100 and t.y < helpAlertY + 175 and #log > 0 and
                t.state == BEGAN then
                
                print(log[#log].x, log[#log].y, "The Log was undone")
                
                for x = 1, 25 do
                    for y = 1, 25 do
                        local xLog = log[#log].x
                        local yLog = log[#log].y
                        tab[xLog][yLog] = 0
                    end
                end
                
                
                table.remove(log, #log)
                
                helpAlertUndoColor = color(0, 255, 255, 255)
                
                currentTurn = currentTurn - 1
                if currentTurn == 0 then currentTurn = playersPlaying end
                
                msg = "Position undone!"
                msgColor = color(255, 255, 255, 255)
            end
            
            -- Change "playersPlaying"
            
            if t.x > 580 and t.x < 645 and t.y > helpAlertY + 105 and t.y < helpAlertY + 170 and
                playersPlaying >= 2 and t.state == BEGAN then
                playersPlaying = playersPlaying - 1
                for x = 1, 25 do
                    for y = 1, 25 do
                        tab[x][y] = 0
                    end
                end
                
                currentTurn = 1
                msg = "Blue's Turn"
                msgColor = color(0, 75, 255, 255)
            end
            
            if t.x > 705 and t.x < 770 and t.y > helpAlertY + 105 and t.y < helpAlertY + 170 and
                playersPlaying <= playersMaximum - 1 and t.state == BEGAN then
                playersPlaying = playersPlaying + 1
                for x = 1, 25 do
                    for y = 1, 25 do
                        tab[x][y] = 0
                    end
                end
                
                currentTurn = 1
                msg = "Blue's Turn"
                msgColor = color(0, 75, 255, 255)
            end
            
            -- Change Theme -- rect(125, helpAlertY-225, WIDTH-250, 300)
            
            if t.x > 125 and t.x < WIDTH-125 and t.y > helpAlertY-225 and t.y < helpAlertY+75 and t.state == ENDED then
                themeId = themeId + 1
                if themeId > themeIdMaximum then
                    themeId = 1
                end
                print("Theme.. Changing to " .. themeId .. "...")
                
                -- 🔈🔉🔊 --
                startMusic()
            end
        end
    end
    
    if t.state == ENDED and (helpAlertClearColor.r == 0 or helpAlertUndoColor.r == 0) then
        helpAlertClearColor = color(35, 145, 250, 255)
        helpAlertUndoColor = helpAlertClearColor
        helpAlert = false
    end
end

function checkWins()
    for x = 1, 18 do
        for y = 1, 13 do
            --[[
            local winMsg = "Noone Wins!"
            local win = 0
            if tab[x][y]==win and tab[x+1][y]==win and tab[x+2][y]==win and tab[x+3][y]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y]==win and tab[x+1][y+1]==win and tab[x+2][y+2]==win and tab[x+3][y+3]==win and tab[x+4][y+4]==win then
                msg = winMsg
                winner = win
            elseif tab[x][y]==win and tab[x][y+1]==win and tab[x][y+2]==win and tab[x][y+3]==win and tab[x][y+4]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y+4]==win and tab[x+1][y+3]==win and tab[x+2][y+2]==win and tab[x+3][y+1]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
            end
            ]]
            
            local winMsg = "⚜ Blue Wins! ⚜"
            local win = 1
            if tab[x][y]==win and tab[x+1][y]==win and tab[x+2][y]==win and tab[x+3][y]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y]==win and tab[x+1][y+1]==win and tab[x+2][y+2]==win and tab[x+3][y+3]==win and tab[x+4][y+4]==win then
                msg = winMsg
                winner = win
            elseif tab[x][y]==win and tab[x][y+1]==win and tab[x][y+2]==win and tab[x][y+3]==win and tab[x][y+4]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y+4]==win and tab[x+1][y+3]==win and tab[x+2][y+2]==win and tab[x+3][y+1]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
            end
            
            --
            local winMsg = "⚜ Red Wins! ⚜"
            local win = 2
            if tab[x][y]==win and tab[x+1][y]==win and tab[x+2][y]==win and tab[x+3][y]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y]==win and tab[x+1][y+1]==win and tab[x+2][y+2]==win and tab[x+3][y+3]==win and tab[x+4][y+4]==win then
                msg = winMsg
                winner = win
            elseif tab[x][y]==win and tab[x][y+1]==win and tab[x][y+2]==win and tab[x][y+3]==win and tab[x][y+4]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y+4]==win and tab[x+1][y+3]==win and tab[x+2][y+2]==win and tab[x+3][y+1]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
            end
            
            --
            local winMsg = "⚜ Green Wins! ⚜"
            local win = 3
            if tab[x][y]==win and tab[x+1][y]==win and tab[x+2][y]==win and tab[x+3][y]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y]==win and tab[x+1][y+1]==win and tab[x+2][y+2]==win and tab[x+3][y+3]==win and tab[x+4][y+4]==win then
                msg = winMsg
                winner = win
            elseif tab[x][y]==win and tab[x][y+1]==win and tab[x][y+2]==win and tab[x][y+3]==win and tab[x][y+4]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y+4]==win and tab[x+1][y+3]==win and tab[x+2][y+2]==win and tab[x+3][y+1]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
            end
            
            --
            local winMsg = "⚜ Yellow Wins! ⚜"
            local win = 4
            if tab[x][y]==win and tab[x+1][y]==win and tab[x+2][y]==win and tab[x+3][y]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y]==win and tab[x+1][y+1]==win and tab[x+2][y+2]==win and tab[x+3][y+3]==win and tab[x+4][y+4]==win then
                msg = winMsg
                winner = win
            elseif tab[x][y]==win and tab[x][y+1]==win and tab[x][y+2]==win and tab[x][y+3]==win and tab[x][y+4]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y+4]==win and tab[x+1][y+3]==win and tab[x+2][y+2]==win and tab[x+3][y+1]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
            end
            
            --
            local winMsg = "⚜ Purple Wins! ⚜"
            local win = 5
            if tab[x][y]==win and tab[x+1][y]==win and tab[x+2][y]==win and tab[x+3][y]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y]==win and tab[x+1][y+1]==win and tab[x+2][y+2]==win and tab[x+3][y+3]==win and tab[x+4][y+4]==win then
                msg = winMsg
                winner = win
            elseif tab[x][y]==win and tab[x][y+1]==win and tab[x][y+2]==win and tab[x][y+3]==win and tab[x][y+4]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y+4]==win and tab[x+1][y+3]==win and tab[x+2][y+2]==win and tab[x+3][y+1]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
            end
        
            local winMsg = "Orange"
            local win = 6
            if tab[x][y]==win and tab[x+1][y]==win and tab[x+2][y]==win and tab[x+3][y]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y]==win and tab[x+1][y+1]==win and tab[x+2][y+2]==win and tab[x+3][y+3]==win and tab[x+4][y+4]==win then
                msg = winMsg
                winner = win
            elseif tab[x][y]==win and tab[x][y+1]==win and tab[x][y+2]==win and tab[x][y+3]==win and tab[x][y+4]==win then
                msg = winMsg
                winner = win
    elseif tab[x][y+4]==win and tab[x+1][y+3]==win and tab[x+2][y+2]==win and tab[x+3][y+1]==win and tab[x+4][y]==win then
                msg = winMsg
                winner = win
                
                
                -- End
                if winner then
                    msgColor = color(155, 120, 25, 255)
                end
            end
        end
    end
end

function checkPossiblePlacing()
    local possible = false
    for x = 1, 18 do
        for y = 1, 13 do
            if tab[x][y] == 0 then
                possible = true
            end
        end
    end
    
    if possible then else
        winner = 0
    end
end

function playBot(colour)
    currentTurn = 1
    msg = "Blue's Turn 💙"
    for x = 1, 18 do
        for y = 1, 13 do
            -- First get center field (y7, x9-10)
            if #log == 1 then
                if tab[9][7] == 0 then
                    tab[9][7] = colour
                elseif tab[10][7] == 0 then
                    tab[10][7] = colour
                else
                    local n = math.random(0, 1)
                    tab[9+n][7] = colour
                end
            end
        end
    end
end

function startMusic()
    if themeId == 2 then
        music("A Hero's Quest:Battle", true, 1.0)
    else
        music.stop()
    end
end
