-- Win 5

function setup()
    -- You can change this!! Currently not working.
    playersPlaying = 2 -- Maximal: 5 !!
    
    
    -- Do not change!!
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    currentTurn = 1
    msg = "Blue's Turn 🔵"
    msgColor = color(255, 255, 255, 255)
    helpAlert = false
    helpAlertY = 0
    winner = nil
    
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
        text("This game can be only played by two people. They placesomewhere a block of their color,\nand then it's the others turn. You must have 5 blocks in order to win. You can place\nhorizontally, vertically or diagonal the 5 blocks. It works in all directions ➕✖️.\nWhen the entire field is placed with blocks,the game will begin from new.", WIDTH/2, helpAlertY + 425)
        font("AmericanTypewriter-Bold")
        fontSize(30)
        text("To-Do List", WIDTH/2, helpAlertY + 350)
        fontSize(20)
        font("AmericanTypewriter")
        text("• Add \"How many players playing\" changeable values till minimal 5.\n• Collect specialized ideas\n• AI for Bots playing.", WIDTH/2, helpAlertY + 275)
        clip()
    else
        for x = 1, 18 do
            for y = 1, 13 do
                strokeWidth(2)
                stroke(255, 255, 255, 255)
                if tab[x][y] == 0 then
                    fill(127, 127, 127, 255)
                elseif tab[x][y] == 1 then
                    fill(0, 0, 255, 255)
                elseif tab[x][y] == 2 then
                    fill(255, 0, 0, 255)
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
        
        -- Button (Do not change)
        
        local pos = vec2(WIDTH-225, HEIGHT-50)
        
        fill(255, 255, 255, 255)
        strokeWidth(0)
        rect(pos.x, pos.y, 200, 45)
        
        fill(223, 146, 138, 255)
        font("AmericanTypewriter-Bold")
        text("Help ❓", pos.x + 100, pos.y + 22.5)
        
        
        if winner then
            fill(color(255, 255))
            text("Touch to restart 🔄", WIDTH/2 + math.random(-1, 1), HEIGHT/2 + math.random(-1, 1))
        end
    end
end

function touched(t)
    if t.state == BEGAN then
        if winner then
            if t.x>65 and t.y>50 and t.x<WIDTH-65 and t.y<HEIGHT-75 then
                setup()
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
                                    
                                    -- 🔴🔵 --
                                    if currentTurn == 1 then
                                        currentTurn = 2
                                        msg = "Red's Turn 🔴"
                                    else
                                        currentTurn = 1
                                        msg = "Blue's Turn 🔵"
                                    end
                                end
                            end
                        end
                    end
                end
                
                if t.x>WIDTH-225 and t.x<WIDTH-25 and t.y>HEIGHT-50 and t.y<HEIGHT-5 then
                    print("Help Alert.. Opening...")
                    helpAlert = true
                    helpAlertY = 0
                end
            end
        end
    end
    
    if helpAlert then
        if t.x > 75 and t.y > 75 and t.x < WIDTH-75 and t.y < HEIGHT-75 then
            helpAlertY = helpAlertY + t.deltaY * 1.25
        end
    end
end

function checkWins()
    for x = 1, 18 do
        for y = 1, 13 do
            -- Horizontally
            if tab[x][y]==1 and tab[x+1][y]==1 and tab[x+2][y]==1 and tab[x+3][y]==1 and tab[x+4][y]==1 then
                msg = "🔵 🏆 Blue Wins! 🔵"
                winner = 1
            elseif tab[x][y]==2 and tab[x+1][y]==2 and tab[x+2][y]==2 and tab[x+3][y]==2 and tab[x+4][y]==2 then
                msg = "🔴 🏆 Red Wins! 🔴"
                winner = 2
            -- Diagonally (left-bottom -> right-top)
            elseif tab[x][y]==1 and tab[x+1][y+1]==1 and tab[x+2][y+2]==1 and tab[x+3][y+3]==1 and tab[x+4][y+4]==1 then
                msg = "🔵 🏆 Blue Wins! 🔵"
                winner = 1
            elseif tab[x][y]==2 and tab[x+1][y+1]==2 and tab[x+2][y+2]==2 and tab[x+3][y+3]==2 and tab[x+4][y+4]==2 then
                msg = "🔴 🏆 Red Wins! 🔴"
                winner = 2
            -- Vertically
            elseif tab[x][y]==1 and tab[x][y+1]==1 and tab[x][y+2]==1 and tab[x][y+3]==1 and tab[x][y+4]==1 then
                msg = "🔵 🏆 Blue Wins! 🔵"
                winner = 1
            elseif tab[x][y]==2 and tab[x][y+1]==2 and tab[x][y+2]==2 and tab[x][y+3]==2 and tab[x][y+4]==2 then
                msg = "🔴 🏆 Red Wins! 🔴"
                winner = 2
            -- Other Diagonally
            elseif tab[x][y+4]==2 and tab[x+1][y+3]==2 and tab[x+2][y+2]==2 and tab[x+3][y+1]==2 and
                tab[x+4][y]==2 then
                msg = "🔴 🏆 Red Wins! 🔴"
                winner = 2
            elseif tab[x][y+4]==1 and tab[x+1][y+3]==1 and tab[x+2][y+2]==1 and tab[x+3][y+1]==1 and
                tab[x+4][y]==1 then
                msg = "🔵 🏆 Blue Wins! 🔵"
                winner = 1
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
        setup()
    end
end
