
-- Win 5

function setup()
    -- You can change this!!
    playersPlaying = 2
    colorNames = {"Blue", "Red", "Green", "Yellow", "Purple", "Orange"}
    colorFillMsg  = {color(75, 0, 255, 255), color(255, 0, 0, 255), color(0, 150, 0, 255),
    color(255, 255, 0, 255), color(125, 50, 100, 255), color(150, 100, 25, 255)}
    playersMaximum = #colorNames
    
    duelTime = 100
    duelType = 0
    --[[
    0 - Disabled.
    1 - Entire time.
    2 - Regenerated time for every round.
    ]]
    
    -- Do not change!!
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    currentTurn = 1
    helpAlert = false
    helpAlertY = 0
    helpAlertClearColor = color(35, 145, 250, 255)
    helpAlertUndoColor = helpAlertClearColor
    winner = nil
    log = {}
    themeId = 1
    themeIdMaximum = 4
    
    -- Board
    tab = {}
    for x = 1, 25 do
        tab[x] = {}
        for y = 1, 25 do
            tab[x][y] = 0
        end
    end
    
    -- Duel Timer for every Player
    timer = {}
    for p = 1, playersMaximum do
        timer[p] = duelTime
    end
    
    -- Eliminations
    eliminated = {}
    for p = 1, playersMaximum do
        eliminated[p] = false
    end
end

function draw()
    background(0, 0, 0, 255)
    if helpAlert then
        fill(255, 255, 255, 255)
        rect(50, 50, WIDTH-100, HEIGHT-100)
        strokeWidth(25)
        stroke(255, 255, 255, 255)
        local s = {50, WIDTH-50, HEIGHT-50}
        line(s[1], s[1], s[1], s[3])
        line(s[1], s[1], s[2], s[1])
        line(s[1], s[3], s[2], s[3])
        line(s[2], s[1], s[2], s[3])
        s = nil
        strokeWidth(0)
        
        fill(0, 0, 0, 255)
        font("AmericanTypewriter-Bold")
        fontSize(45)
        text("Settings", WIDTH/2, HEIGHT-65)
        
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
        text("To - Do", WIDTH/2, helpAlertY + 340)
        fontSize(20)
        font("AmericanTypewriter")
        text("• Only fix this Known Bug for v5: Seconds are 60! Not 100!\n• Continue Bots.\n• Fix non working Bots.", WIDTH/2, helpAlertY + 275)
        font("AmericanTypewriter-Bold")
        fontSize(30)
        text("Settings (since v2)", WIDTH/2, helpAlertY + 200)
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
        elseif themeId == 4 then
            fill(162, 209, 207, 255)
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
        elseif themeId == 4 then
            fill(35, 125, 40, 255)
            fontSize(35)
            font("Baskerville")
            text("Official Winter Theme (AKA Fairy)", WIDTH/2, helpAlertY + 10)
            sprite("Small World:Tree 3", 210, helpAlertY-190)
        end
        font("AppleColorEmoji")
        fontSize(60)
        fill(255, 255, 255, 255)
        if themeId == 4 then -- NEW THEMES
            text("🆕", 125, helpAlertY + 75)
        else
            text("⏹", 125, helpAlertY + 75)
        end
        if themeId == 2 or themeId == 4 then -- TEMPORARY THEMES
            text("🕘", 185, helpAlertY + 75)
        else
            text("⭕️", 185, helpAlertY + 75)
        end
        if themeId == 2 or themeId == 4 then -- THEME WITH SOUND
            text("🔔", 245, helpAlertY + 75)
        else
            text("🔕", 245, helpAlertY + 75)
        end
        
        -- Themes P. S.
        
        fill(0, 0, 0, 255)
        font("CourierNewPS-BoldMT")
        fontSize(20)
        text("All Themes are free and first avaibel since v3,\nand can be choosen by tapping on the Theme Box. Then\na new Theme will be displayed. The symbols mean this:", WIDTH/2, helpAlertY - 275)
        font("AmericanTypewriter")
        fill(127, 127, 127, 255)
        text("🆕 - The Theme is released the latest update", WIDTH/2, helpAlertY - 365)
        text("🕐 - The Theme is temporary, or will be changed in future", WIDTH/2, helpAlertY - 395)
        text("🔔 - The Theme has Sound included.", WIDTH/2, helpAlertY - 425)
        text("⏹ - The Theme is not new.", WIDTH/2, helpAlertY - 455)
        text("⭕️ - The Theme is permament", WIDTH/2, helpAlertY - 485)
        text("🔕 - The Theme has no sounds.", WIDTH/2, helpAlertY - 515)
        
        -- Duel Modus >>
        
        fill(0, 0, 0, 255)
        strokeWidth(2)
        stroke(31, 47, 109, 255)
        rect(0, helpAlertY-900, WIDTH, 300)
        fill(255, 255, 255, 255)
        fontSize(50)
        font("Georgia-Bold")
        text("Duel Mode", WIDTH/2, helpAlertY - 650)
        
        local n = 0
        for x = 1, 33 do
            for y = 1, 3 do
                n = n + 1
                if n == 1 and (x < 11 or x > 23) then
                    strokeWidth(0)
                    rect(x * 25 + 75, helpAlertY - 715 + 25 * y, 25, 25)
                end if n == 2 then
                    n = 0
                end
            end
        end
        
        font("AmericanTypewriter-Bold")
        fontSize(20)
        text("Since v4.", WIDTH/2, helpAlertY - 690)
        text("Type", 115, helpAlertY - 850)
        text("Time", 115, helpAlertY - 760)
        strokeWidth(5)
        stroke(255, 255, 255, 255)
        line(300, helpAlertY - 760, 900, helpAlertY - 760)
        fill(0, 0, 0, 0)
        rect(290, helpAlertY - 785, 620, 50)
        strokeWidth(0)
        fill(255, 255, 255, 255)
        
        -- Timer
        local time = math.floor(duelTime / 6)
        ellipse(300 + duelTime, helpAlertY - 760, 25)
        text(time,  215, helpAlertY - 760)
        -- Type
        fill(0, 0, 0, 0)
        strokeWidth(5)
        rect(790, helpAlertY - 870, 120, 50)
        fill(255, 255, 255, 255)
        fontSize(35)
        text("Switch", 850, helpAlertY - 845)
        fontSize(25)
        
        if duelType == 0 then -- Disabled.
            fill(127, 127, 127, 255)
            text("Disabled", 500, helpAlertY - 850)
        elseif duelType == 1 then -- Entire Time
            fontSize(20)
            text("Entire", 235, helpAlertY - 850)
            fontSize(15)
            text("The Time (in minutes) is the entire play time.", WIDTH/2, helpAlertY - 850)
        elseif duelType == 2 then -- Time for one round.
            fontSize(20)
            text("New time", 235, helpAlertY - 850)
            fontSize(15)
            text("The Time (in seconds) is the time for each round.", WIDTH/2, helpAlertY - 850)
        end
        
        -- <<<  End ]]
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
                    elseif themeId == 4 then
                        fill(157, 200, 200, 255)
                    end
                elseif tab[x][y] == 1 then
                    if themeId == 1 then
                        fill(0, 0, 200, 255)
                    elseif themeId == 2 then
                        fill(100, 125, 225, 255)
                    elseif themeId == 3 then
                        fill(0, 0, 255, 255)
                    elseif themeId == 4 then
                        fill(20, 65, 220, 255)
                    end
                elseif tab[x][y] == 2 then
                    if themeId == 1 then
                        fill(150, 0, 0, 255)
                    elseif themeId == 2 then
                        fill(225, 140, 140, 255)
                    elseif themeId == 3 then
                        fill(255, 0, 0, 255)
                    elseif themeId == 4 then
                        fill(215, 25, 100, 255)
                    end
                elseif tab[x][y] == 3 then
                    if themeId == 1 then
                        fill(30, 150, 50, 255)
                    elseif themeId == 2 then
                        fill(0, 255, 0, 255)
                    elseif themeId == 3 then
                        fill(0, 255, 0, 255)
                    elseif themeId == 4 then
                        fill(100, 215, 115, 255)
                    end
                elseif tab[x][y] == 4 then
                    if themeId == 1 then
                        fill(175, 165, 50, 255)
                    elseif themeId == 2 then
                        fill(210, 210, 15, 255)
                    elseif themeId == 3 then
                        fill(255, 255, 0, 255)
                    elseif themeId == 4 then
                        fill(200, 215, 75, 255)
                    end
                elseif tab[x][y] == 5 then
                    if themeId == 1 then
                        fill(85, 40, 75, 255)
                    elseif themeId == 2 then
                        fill(135, 60, 150, 255)
                    elseif themeId == 3 then
                        fill(255, 0, 255)
                    elseif themeId == 4 then
                        fill(200, 125, 205, 255)
                    end
                elseif tab[x][y] == 6 then
                    if themeId == 1 then
                        fill(225, 110, 25, 255)
                    elseif themeId == 2 then
                        fill(215, 175, 85, 255)
                    elseif themeId == 3 then
                        fill(255, 150, 0, 255)
                    elseif themeId == 4 then
                        fill(200, 150, 100, 255)
                    end
                else
                    fill(0, 0, 0, 255)
                end
                rect(50 * x + 15, 50 * y, 50, 50)
            end
        end
        
        checkWins()
        checkPossiblePlacing()
        checkEliminations()
        
        font("AmericanTypewriter")
        fontSize(35)
        if winner then
            if winner == 0 then
                fill(255, 255, 255, 255)
                text("Error: No Message", WIDTH/2, HEIGHT-30)
            else
                fill(175, 125, 50, 255)
                text(colorNames[winner] .. " won!", WIDTH/2, HEIGHT-30)
            end
        else
            fill(colorFillMsg[currentTurn])
            if playersPlaying == 1 then
                text("Your Turn.", WIDTH/2, HEIGHT-30)
            else
                text(colorNames[currentTurn] .. "'s Turn.", WIDTH/2, HEIGHT-30)
            end
        end
        
        -- Info Button (Do not change)
        
        local pos = vec2(WIDTH-225, HEIGHT-50)
        
        fill(255, 255, 255, 255)
        strokeWidth(0)
        rect(pos.x, pos.y, 200, 45)
        
        fill(255, 255, 255, 255)
        font("AmericanTypewriter-Bold")
        text("⚙", pos.x + 100, pos.y + 22.5)
        
        -- Time
        
        if duelType == 0 then else
            fill(colorFillMsg[currentTurn])
            if duelType == 1 and not winner then
                min = math.floor(timer[currentTurn] / 6)
                seconds = ((timer[currentTurn] / 6) - math.floor(timer[currentTurn] / 6))
                -- Eliminate time
                timer[currentTurn] = timer[currentTurn] - 0.0015
                -- To string
                local s = "" .. seconds
                local m = "" .. min
                local txt = m .. " : " .. string.sub(s, 3, 4)
                text(txt, 100, HEIGHT - 25)
                if timer[currentTurn] < 0 then
                    eliminated[currentTurn] = true
                    if playersPlaying >= currentTurn then
                        currentTurn = 1
                    else
                        currentTurn = currentTurn + 1
                    end
                    seconds = nil
                    min = nil
                end
            elseif duelType == 2 and not winner then
                if seconds == nil then seconds = math.floor(duelTime / 6) end
                if mili_seconds == nil then mili_seconds = 35 end
                mili_seconds = mili_seconds - 1
                if mili_seconds <= 0 then mili_seconds = nil seconds = seconds - 1 end
                local txt = seconds
                text(txt, 75, HEIGHT-25)
                if seconds <= 0 then
                    eliminated[currentTurn] = true
                    if playersPlaying >= currentTurn then
                        currentTurn = 1
                    else
                        currentTurn = currentTurn + 1
                    end
                    seconds = nil
                    mili_seconds = nil
                end
            end
        end
        
        if winner then
            fill(color(255, 255))
            if themeId == 3 then fill(150, 255) end
            text("Touch to restart 🔄", WIDTH/2, HEIGHT/2)
        end
    end
end

function touched(t)
    if t.state == BEGAN then
        if winner and not helpAlert then
            if t.x>65 and t.y>50 and t.x<WIDTH-65 and t.y<HEIGHT-75 then
                for x = 1, 25 do
                    for y = 1, 25 do
                        tab[x][y] = 0
                    end
                end
                
                currentTurn = 1
                helpAlert = false
                winner = nil
                log = {}
                if themeId == 2 or themeId == 4 then
                    sound("A Hero's Quest:Broke")
                end
                -- Duel Timer for every Player
                for p = 1, playersMaximum do
                    timer[p] = duelTime
                    eliminated[p] = false
                end
                --
            elseif t.x>WIDTH-225 and t.x<WIDTH-25 and t.y>HEIGHT-50 and t.y<HEIGHT-5 then
                print("Help Alert.. Opening...")
                helpAlert = true
            end
        else
            if helpAlert then
                if t.x>WIDTH-165 and t.x<WIDTH-40 and t.y>HEIGHT-90 and t.y<HEIGHT then
                    print("Help Alert.. Closing...")
                    helpAlert = false
                end
            else
                -- Help Alert
                if t.x>WIDTH-225 and t.x<WIDTH-25 and t.y>HEIGHT-50 and t.y<HEIGHT-5 then
                    print("Help Alert.. Opening...")
                    helpAlert = true
                end
                
                -- Board
                for x = 1, 18 do
                    for y = 1, 13 do
                        if x * 50 + 15 < t.x and x * 50 + 65 > t.x then
                            if y * 50 < t.y and y * 50 + 50 > t.y then
                                if tab[x][y] == 0 then
                                    print("x, y = " .. x .. ", " .. y .. "\nCurrent Turn = " .. currentTurn)
                                    tab[x][y] = currentTurn
                                    table.insert(log, vec2(x, y))
                                    if duelType == 2 then
                                        timer[currentTurn] = duelTime
                                        seconds = nil
                                        mili_seconds = nil
                                    end
                                    
                                    -- 🔈🔔📣📢 --
                                    
                                    if themeId == 2 then
                                        sound("A Hero's Quest:Arrow Shoot 1")
                                    elseif themeId == 4 then
                                        sound("A Hero's Quest:Arrow Shoot 2")
                                    end
                                    
                                    local turnMade = false
                                    if currentTurn == 1 then
                                        if playersPlaying == 1 then
                                            playBot(2)
                                            turnMade = true
                                        else
                                            currentTurn = 2
                                            turnMade = true
                                        end
                                    end
                                    
                                    for p = 2, playersMaximum-1 do
                                        if currentTurn == p and turnMade == false then
                                            if playersPlaying == p then
                                                currentTurn = 1
                                                turnMade = true
                                            elseif playersPlaying > p then
                                                currentTurn = currentTurn + 1
                                                turnMade = true
                                            end
                                        end
                                    end
                                    if currentTurn == playersMaximum and turnMade == false then
                                        if playersPlaying == playersMaximum then
                                            currentTurn = 1
                                            turnMade = true
                                        elseif playersPlaying > playersMaximum then
                                            currentTurn = currentTurn + 1 -- impossible
                                            winner = 0
                                            turnMade = true
                                        end
                                    end
                                    --
                                end
                            end
                        end
                    end
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
                if themeId == 2 then
                    sound("A Hero's Quest:Swing 1")
                elseif themeId == 4 then
                    sound("Game Sounds One:Bell 2")
                end
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
                if themeId == 2 then
                    sound("A Hero's Quest:Swing 1")
                elseif themeId == 4 then
                    sound("Game Sounds One:Bell 2")
                end
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
            
            -- Duel Timer
            if t.x > 290 and t.x < 910 and t.y > helpAlertY - 785 and t.y < helpAlertY - 735 then
                duelTime = duelTime + t.deltaX
                if duelTime < 1 then
                    duelTime = 1
                elseif duelTime > 600 then
                    duelTime = 600
                end
                -- Duel Timer for every Player (reset)
                timer = {}
                for p = 1, playersMaximum do
                    timer[p] = duelTime
                end
            end
            
            -- Duel Type
            if t.x > 790 and t.x < 910 and t.y > helpAlertY - 870 and t.y < helpAlertY - 830 and t.state == ENDED then
                duelType = duelType + 1
                if duelType == 3 then
                    duelType = 0
                end
                
                timer = {}
                for p = 1, playersMaximum do
                    timer[p] = duelTime
                end
            end
        end
    end
    
    if t.state == ENDED and (helpAlertClearColor.r == 0 or helpAlertUndoColor.r == 0) then
        helpAlertClearColor = color(35, 145, 250, 255)
        helpAlertUndoColor = helpAlertClearColor
    end
end

function checkWins()
    for x = 1, 18 do
        for y = 1, 13 do
            for p = 1, playersMaximum do
                local win = p
                if tab[x][y]==p and tab[x+1][y]==p and tab[x+2][y]==p and tab[x+3][y]==p and tab[x+4][y]==p then
                    winner = p
                elseif tab[x][y]==p and tab[x+1][y+1]==p and tab[x+2][y+2]==p and tab[x+3][y+3]==p and tab[x+4][y+4]==win then
                    winner = p
                elseif tab[x][y]==p and tab[x][y+1]==p and tab[x][y+2]==p and tab[x][y+3]==p and tab[x][y+4]==p then
                    winner = p
                elseif tab[x][y+4]==p and tab[x+1][y+3]==p and tab[x+2][y+2]==p and tab[x+3][y+1]==p and tab[x+4][y]==p then
                    winner = p
                end
            end
            
            -- End
            if winner then
                if winner == not 0 then
                    if themeId == 2 then
                        sound("A Hero's Quest:Level Up")
                    elseif themeId == 4 then
                        sound("A Hero's Quest:Move 1")
                    end
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

function checkEliminations()
    if eliminated[currentTurn] == true then
        if playersPlaying == currentTurn then
            currentTurn = 1
        else
            currentTurn = currentTurn + 1
        end
    end
    
    local n = 0
    local dead = {}
    for p = 1, playersPlaying do
        if eliminated[p] == true then
            n = n + 1
            table.insert(dead, p)
        end
    end
    if n == playersPlaying - 1 then -- Only one player alive
        -- Check who:
        if eliminated[currentTurn] == false then
            winner = currentTurn -- If current player is winner then let him win
        else
            winner = 0 -- An error appeared.
        end
    end
end

function playBot(colour)
    currentTurn = 1
    local blockPlaced = false
    for x = 1, 18 do
        for y = 1, 13 do
            for p = 1, playersMaximum do
                -- Important secure// 3+ blocks in row
                if tab[x+1][y] == p and tab[x+2][y] == p and tab[x+3][y] == p and not blockPlaced then
                    if tab[x][y] == 0 then
                        tab[x][y] = colour
                        blockPlaced = true
                    elseif tab[x+4][y] == 0 then
                        tab[x+4][y] = colour
                        blockPlaced = true
                    end
                elseif tab[x][y+1] == p and tab[x][y+2] == p and tab[x][y+3] == p and not blockPlaced then
                    if tab[x][y] == 0 then
                        tab[x][y] = colour
                        blockPlaced = true
                    elseif tab[x][y+4] == 0 then
                        tab[x][y+4] = colour
                        blockPlaced = true
                    end
                elseif tab[x+1][y+1] == p and tab[x+2][y+2] == p and tab[x+3][y+3] == p and not blockPlaced then
                    if tab[x][y] == 0 then
                        tab[x][y] = colour
                        blockPlaced = true
                    elseif tab[x+4][y+4] == 0 then
                        tab[x+4][y+4] = colour
                        blockPlaced = true
                    end
                --Secure// 2+ blocks in row.
                elseif tab[x+1][y] == p and tab[x+2][y] == p and tab[x][y] == 0 and tab[x+3][y] == 0 and not blockPlaced then
                    if tab[x][y] == 0 then
                        tab[x][y] = colour
                        blockPlaced = true
                    elseif tab[x+3][y] == 0 then
                        tab[x+3][y] = colour
                        blockPlaced = true
                    end
                elseif tab[x+1][y+1] == p and tab[x+2][y+2] == p and tab[x][y] == 0 and tab[x+3][y+3] == 0 and not blockPlaced then
                    if tab[x][y] == 0 then
                        tab[x][y] = colour
                        blockPlaced = true
                    elseif tab[x+3][y+3] == 0 then
                        tab[x+3][y+3] = colour
                        blockPlaced = true
                    end
                elseif tab[x][y+1] == p and tab[x][y+1] == p and tab[x][y] == 0 and tab[x][y+3] == 0 and not blockPlaced then
                    if tab[x][y] == 0 then
                        tab[x][y] = colour
                        blockPlaced = true
                    elseif tab[x][y+3] == 0 then
                        tab[x][y+3] = colour
                        blockPlaced = true
                    end
                else
                    local v = log[#log]
                    for a = 1, 10 do -- Try ten times to place around area
                        local n = vec2(math.random(-1, 1), math.random(-1, 1))
                        if tab[v.x][v.y] == 0 and not blockPlaced then
                            tab[v.x][v.y] = colour
                            blockPlaced = true
                        end
                    end
                end
            end
            if not blockPlaced then
                --playBot(colour)
            end
        end
    end
end

function startMusic()
    if themeId == 2 then
        music("A Hero's Quest:Battle", true, 1.0)
    elseif themeId == 4 then
        music("A Hero's Quest:Tavern & Inn", true, 0.1)
    else
        music.stop()
    end
end
