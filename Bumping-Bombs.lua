-- Physics

function setup()
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    ground = physics.body(EDGE, vec2(100, 50), vec2(WIDTH-100, 50))
    body = {x = WIDTH/2, y = 250}
    gameNotStarted = true
    gameEnded = false
    -- Effects
    effect = {}
    speed_Effect = false
    doubleScore_Effect = false
    secondLife_Effect = false
    effectTypesNum = 3
    -- Effect Timers (default number)
    speed_Effect_Timer_Maximum = 150
    doubleScore_Effect_Timer_Maximum = 150
    secondLife_Effect_Timer_Maximum = 150
    -- (changing numbers)
    speed_Effect_Timer = 0
    doubleScore_Effect_Timer = 0
    secondLife_Effect_Timer = 0
    -- Bombs
    bombs = {}
    timer = 0
    setTimer = 50
    minTimer = 25 -- setTimer will slowly go down. This is the minimum. Not supported fewer then 25.
    -- Score
    score = 0
    -- Help Alert
    helpAlert = false
    helpText = [[
          This is a game made by tokout.
    
    The game codes are confusing because while developing i just went around
    the code and changed everything.
    Please do not copy or re-export my projects to any code sharing sites!
    
                         ==> Point of the game <===
    
    Bombs are very good engines whichwant to bomb you to the side.
    You can't do any thing against them, but you can try to stay alive.
    Effects appear with a green border, and can be collected.
    Bombs are not going to hurt you, but they can kick you from the platform.
    
        --- Touch to go to lobby ---
    ]]
end

function draw()
    rectMode(CORNER)
    if helpAlert then
        background(0, 0, 0, 255)
        fontSize(50)
        fill(255, 255, 255, 255)
        font("AmericanTypewriter-Bold")
        text("Help Guide", WIDTH/2, HEIGHT-50)
        fill(100, 255)
        fontSize(20)
        font("AmericanTypewriter")
        text(helpText, WIDTH/2, HEIGHT/2)
    else
        -- Head
        background(0, 0, 0, 255)
        fill(255, 255, 255, 255)
        -- Ground
        stroke(0, 0, 255, 255)
        strokeWidth(5)
        line(100, 50, WIDTH-100, 50)
        -- Body
        fill(30, 85, 120, 255)
        ellipse(body.x, body.y, 100)
        fontSize(25)
        font("AmericanTypewriter")
        if not gameEnded and not gameNotStarted then
            if speed_Effect then
                body.x = body.x + Gravity.x * 15
            else
                body.x = body.x + Gravity.x * 5
            end
        end
        -- Bombs
        timer = timer + 0.5
        if timer > setTimer then
            timer = 0
            placeBomb()
            local luck = math.random(0, 11)
            if luck > 9 and not gameEnded then -- Chances 2/11
                getEffect()
            end
        end
        for _,v in ipairs(bombs) do v:draw() end
        for _,v in ipairs(effect) do v:draw() end
        if body.y > 0 then else
            gameOver()
        end
        fill(255, 255, 255, 255)
        if gameEnded then
            text("Game over!", WIDTH/2, HEIGHT/2)
            text("Touch to quit!", WIDTH/2, HEIGHT/2-250)
            if secondLife_Effect then
                getLife()
            end
        elseif gameNotStarted then
            text("Touch to", WIDTH/2, HEIGHT/2)
            text("start the game!", WIDTH/2, HEIGHT/2-250)
            fontSize(50)
            font("Georgia-BoldItalic")
            text("Bumping Bombs", WIDTH/2, HEIGHT-150)
        end
        
        -- Remove effect by right time.
        if secondLife_Effect then
            secondLife_Effect_Timer = secondLife_Effect_Timer - 0.1
            if secondLife_Effect_Timer < 0 then
                secondLife_Effect = false
            end
        end
        
        if doubleScore_Effect then
            doubleScore_Effect_Timer = doubleScore_Effect_Timer - 0.1
            if doubleScore_Effect_Timer < 0 then
                doubleScore_Effect = false
            end
        end
        
        if secondLife_Effect then
            secondLife_Effect_Timer = secondLife_Effect_Timer - 0.1
            if secondLife_Effect_Timer < 0 then
                secondLife_Effect = false
            end
        end
        
        -- Test object to see if effects work
        --[[if secondLife_Effect or doubleScore_Effect or speed_Effect then
            text("Effect", WIDTH/2, HEIGHT/2)
        end]]
        
        if not gameNotStarted then
            text("Score: " .. score, WIDTH/2, HEIGHT-50)
        else
            fill(0, 0, 0, 116)
            stroke(0, 0, 255, 255)
            rect(0, 0, WIDTH, HEIGHT)
            line(100, 0, 100, HEIGHT)
            fill(255, 255, 255, 255)
            strokeWidth(0)
            rect(0, 0, 100, HEIGHT)
            rect(WIDTH/2+WIDTH/4-WIDTH/6, 200, 350, 250)
            local words = {"Click", "here", "on", "the", "white", "space", "to", "get", "help!"}
            fill(0, 0, 0, 255)
            fontSize(25)
            for n,v in ipairs(words) do
                text(v, 50, HEIGHT - n * 30)
            end
            
            -- Avatar link: http://i.imgur.com/MCTlxqD.jpg
            http.request('http://i.imgur.com/MCTlxqD.jpg', function(i) avatar = i end)
            text("Made by TokOut", WIDTH-WIDTH/4, 250)
            fill(0, 0, 0, 255)
            rectMode(CENTER)
            rect(WIDTH-WIDTH/4, 350, 152, 152)
            if avatar then
                sprite(avatar, WIDTH-WIDTH/4, 350, 150, 150)
            end
        end
    end
end

function touched(t)
    if t.state == BEGAN then
        if helpAlert then
            helpAlert = false
        else
            if gameEnded then
                setup()
            elseif gameNotStarted then
                if t.x > 150 then
                    gameStart()
                else
                    help()
                end
            end
        end
    end
end

function getLife()
    secondLife_Effect = false
    gameEnded = false
    body = physics.body(CIRCLE, 50)
    body.x = WIDTH/2
    body.y = 250
    body.gravity = 200
end

function help()
    helpAlert = true
end

function placeBomb()
    
    y = HEIGHT-50
    
    x = (0.8/4) * WIDTH
    table.insert(bombs, 1, useBomb(x, y))
    
    x = (2/4) * WIDTH
    table.insert(bombs, 1, useBomb(x, y))
    
    x = (3.2/4) * WIDTH
    table.insert(bombs, 1, useBomb(x, y))
end

function getEffect()
    local x = math.random(100, WIDTH-100)
    local y = HEIGHT-100
    table.insert(effect, useEffect(x, y))
end

function collide(c)
    for _,v in ipairs(bombs) do v:collide(c) end
end

function gameOver()
    body = nil
    body = {x = WIDTH/2, y = 250}
    gameEnded = true
end

function gameStart()
    body = physics.body(CIRCLE, 50)
    body.x = WIDTH/2
    body.y = 250
    body.gravity = 100
    gameNotStarted = false
    effect = {}
    bombs = {}
end

useBomb = class()

function useBomb:init(x, y)
    self.object = physics.body(CIRCLE, 50)
    self.object.x = x
    self.object.y = y
    self.object.gravityScale = 5
    self.timer = 0
    self.timerEnabled = false
    self.timerMaximum = 100
end

function useBomb:draw()
    stroke(255, 0, 0, 255)
    fill(255, 255, 255, 255)
    if self.object.x and self.object.y then
        rect(self.object.x, self.object.y, 50, 50)
        self.object.x = self.object.x + math.random(-20, 20)
    end
    if self.timerEnabled then
        self.timer = self.timer + 1
        if self.timer > self.timerMaximum then
            self:explode()
        end
    end
end

function useBomb:collide(c)
    self.timerEnabled = true
end

function useBomb:explode()
    self.object:destroy()
    table.remove(bombs, #bombs)
    if not gameEnded and not gameNotStarted then
        if (setTimer < minTimer) then
            score = score + 0.25
            
            if doubleScore_Effect then
                score = score + 1
            end
        else
            setTimer = setTimer-1
            score = score + 0.05
            
            if doubleScore_Effect then
                score = score + 0.75
            end
        end
    end
end

useEffect = class()

function useEffect:init(x, y)
    self.pos = vec2(x, y)
    self.effectId = math.random(1, effectTypesNum)
    self.size = 50
end

function useEffect:draw()
    fill(255, 255, 255, 255)
    stroke(0, 255, 50, 255)
    rect(self.pos.x, self.pos.y, self.size, self.size)
    self:getEffect()
    
    if self.effectEnabled then
        self.pos.y = self.pos.y + 10
    else
        self.pos.y = self.pos.y - 5
    end
    
    if self.effectId == 1 then
        sprite("Tyrian Remastered:Bullet Wave B", self.pos.x+self.size/2, self.pos.y+self.size/2, 35, 35)
    elseif self.effectId == 2 then
        sprite("SpaceCute:Star", self.pos.x+self.size/2, self.pos.y+self.size/2, 35, 35)
    elseif self.effectId == 3 then
        sprite("Planet Cute:Heart", self.pos.x+self.size/2, self.pos.y+self.size/2, 35, 75)
    end
end

function useEffect:getEffect()
    if self.pos.y > 0 and self.pos.y < 200 then
        --print("WORKING Break point 1") -- Exact 40 times
        if (self.pos.x-75 < body.x-25 and self.pos.x+75 > body.x+25) and not gameNotStarted then
            --print("FIXED Break point 2") 
            self.effectEnabled = true
            if self.effectId == 1 then
                speed_Effect = true
                speed_Effect_Timer = speed_Effect_Timer_Maximum
            elseif self.effectId == 2 then
                doubleScore_Effect = true
                doubleScore_Effect_Timer = doubleScore_Effect_Timer_Maximum
            elseif self.effectId == 3 then
                secondLife_Effect = true
                secondLife_Effect_Timer = secondLife_Effect_Timer_Maximum
            end
        end
    end
end

