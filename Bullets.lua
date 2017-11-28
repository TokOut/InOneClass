function setup()
    displayMode(FULLSCREEN)
    supportedOrientations(CurrentOrientation)
    x, y = WIDTH/2, HEIGHT/2
    plays = true
    touching = false
    SCORE = 100
    
    -- Massives
    bullets = {}
    rewards = {}
    scorePoints = 0
    extraPoints = 0
    -- Effects
    slowMode = 0
    slowModeTime = 5 -- Maximal Time
    LIFES = 10
    protectMode = 0
    protectModeTime = 7 -- Maximal Time
    magnetTime = 0
    
    t = 0 -- Time
    st = os.time() -- Score Time
    bt = os.time() -- Bonus Time
    
    if not readLocalData("highscore") then
        saveLocalData("highscore", 0)
    end
    HIGHSCORE = readLocalData("highscore")
    HS = true
end

function draw()
    background(0)
    -- Platform
    fill(0)
    stroke(255, 0, 0)
    strokeWidth(2)
    rect(100, 100, WIDTH-200, HEIGHT-200)
    
    -- You
    resetStyle()
    fill(255)
    if os.time()-protectMode <= protectModeTime then
        sprite("Tyrian Remastered:Rock Boss Left", x-32, y)
        sprite("Tyrian Remastered:Rock Boss Right", x+32, y)
    elseif plays then
        ellipse(x, y, 50)
    end
    if plays then
        --[[local c = 2
        x = x + Gravity.x * c
        y = y + (Gravity.y+.2) * c]]
        if not touching then
            x = x --[[+ math.random(-5, 5)]] + Gravity.x*(WIDTH/20)
            y = y --[[+ math.random(-5, 5)]] + Gravity.y*(HEIGHT/20) + 8
        end
        
        fill(255, 0, 0)
        fontSize(25)
        font("Arial-BoldMT")
        local str = #bullets .. " Bullets Total"
        local w,h = textSize(str)
        text(str, 10+w/2, HEIGHT-10-h)
        
        fill(0, 0, 200)
        local str = SCORE .. " Score"
        local w,h = textSize(str)
        text(str, WIDTH-10-w/2, HEIGHT-10-h)
        
        for a, b in ipairs(rewards) do
            b:draw()
        end
        
        if os.time()-slowMode < slowModeTime then
            local p = {"🕖", "🕕", "🕔", "🕓", "🕒", "🕑", "🕐"}
            fill(255)
            local m = os.time()-slowMode
            if slowModeTime-m < 1 then
                fill(255, 0, 0)
            elseif slowModeTime-m < 3 then
                fill(255, 150, 150)
            end
            fontSize(50)
            font("AppleColorEmoji")
            text(p[os.time()-slowMode] or "", WIDTH/2, HEIGHT-50)
            fontSize(25)
            text("⏱", WIDTH/2+25, HEIGHT-25)
        end
        
        if os.time()-protectMode < protectModeTime then
            local p = {"🕖", "🕕", "🕔", "🕓", "🕒", "🕑", "🕐"}
            fill(255)
            local m = os.time()-protectMode
            if protectModeTime-m < 1 then
                fill(255, 0, 0)
            elseif protectModeTime-m < 3 then
                fill(255, 150, 150)
            end
            fontSize(50)
            font("AppleColorEmoji")
            text(p[os.time()-protectMode] or "", WIDTH/2, HEIGHT-50)
            fontSize(25)
            text("🛡", WIDTH/2+25, HEIGHT-25)
        end
        
        if LIFES >= 1 then
            for i = 1, LIFES do
                sprite("SpaceCute:Health Heart", WIDTH/2-(i-LIFES/2)*40, 50, 35)
            end
        end
        
        SCORE = math.floor(#bullets/3) + scorePoints + extraPoints
    else
        fill(150)
        font("AppleColorEmoji")
        fontSize(50)
        text("Touch to restart.", WIDTH/2, HEIGHT/2)
        fontSize(35)
        text("Score: " .. SCORE, WIDTH/2, HEIGHT/2-50)
        if HIGHSCORE < SCORE then
            fontSize(35)
            text("New highscore!", WIDTH/2, HEIGHT/2-100)
            if HS then
                HS = false -- Repeat once
                saveLocalData("highscore", SCORE)
            end
        else
            fontSize(35)
            text("Highscore: " .. math.tointeger(HIGHSCORE), WIDTH/2, HEIGHT/2-100)
        end
    end
    
    for a, b in ipairs(bullets) do
        b:draw()
    end
    
    if x < 125 or y < 125 or x >= WIDTH-125 or y >= HEIGHT-125 and plays then
        --[[LIFES = LIFES - 1
        x, y = WIDTH/2, HEIGHT/2]]
        plays = false -- The code above triggers!
    end
    
    if os.time()-t >= 3 then -- Every 2 seconds bullet spawns
        local v = {0, 5, 10, 20, 35, 50, 75, 100, 150, 200, 250, 500, 750, 1000, 1250, 1500}
        for a, b in ipairs(v) do
            if v[a] <= SCORE then
                table.insert(bullets, Bullet())
            end
        end
        
        t = os.time()
    end
    
    if os.time()-st >= 15 then -- Every 15 seconds 100 points for surviving
        scorePoints = scorePoints + 100
        st = os.time()
    end
    
    if os.time()-bt >= 5 then -- Bonus spawn time
        table.insert(rewards, Bonus())
        bt = os.time()
    end
    
    if LIFES < 1 and plays then
        plays = false
    end
end

function touched(t)
    if t.state == BEGAN then
        touching = true
    elseif t.state == ENDED then
        touching = false
    end
    if plays then
        local a, b = x-t.x, y-t.y
        if a < 0 then a = -a end if b < 0 then b = -b end
        if a < 50 and b < 50 then
            x = t.x
            y = t.y
        end
    else
        if t.state == BEGAN then
            setup()
        end
    end
end

Bullet = class()

function Bullet:init()
    self.x, self.y, self.speedX, self.speedY = 0, 0, 0, 0
    self.dead = false
    
    -- Asign
    --[[local direction = math.random(1, 4)
    if direction == 1 then
        self.x = 100
        self.y = math.random(1, HEIGHT)
    elseif direction == 2 then
        self.x = math.random(1, WIDTH)
        self.y = 100
    elseif direction == 3 then
        self.x = WIDTH-100
        self.y = math.random(1, HEIGHT)
    else -- 4
        self.x = math.random(1, WIDTH)
        self.y = HEIGHT-100
    end]]
    
local direction = math.random(1, 4)
    if direction == 1 then
        self.x = -100
        self.y = math.random(1, HEIGHT)
    elseif direction == 2 then
        self.x = math.random(1, WIDTH)
        self.y = -100
    elseif direction == 3 then
        self.x = WIDTH+100
        self.y = math.random(1, HEIGHT)
    else -- 4
        self.x = math.random(1, WIDTH)
        self.y = HEIGHT+100
    end
end

function Bullet:draw()
    resetStyle()
    if not self.dead then
        --fill(255, 0, 0)
        --ellipse(self.x, self.y, 20)
        sprite("Tyrian Remastered:Energy Orb 1", self.x, self.y, 40, 40)
        
        if plays then
            if x >= self.x-30 and x <= self.x+30 and y >= self.y-30 and y <= self.y+30 then
                if os.time()-protectMode <= protectModeTime then
                    extraPoints = extraPoints + 5
                else
                    LIFES = LIFES - 1
                end
                self.dead = true
            end
        end
        
        -- Speed
        if os.time()-slowMode <= slowModeTime then
            self.x = self.x + self.speedX/3
            self.y = self.y + self.speedY/3
        else
            local a, b = 0, 0
            if #rewards >= 1 then
                if rewards[#rewards].alive then
                    if self.x > rewards[#rewards].x then
                        a = -10
                    else
                        a = 10
                    end
                    if self.y > rewards[#rewards].y then
                        b = -10
                    else
                        b = 10
                    end
                end
            end
            
            if plays then
                if self.x > x then
                    a = a - 1
                    if os.time()-protectMode <= protectModeTime then
                        a = a - 3
                    end
                else
                    a = a + 1
                    if os.time()-protectMode <= protectModeTime then
                        a = a + 3
                    end
                end
                if self.y > y then
                    b = a - 1
                    if os.time()-protectMode <= protectModeTime then
                        b = b - 3
                    end
                else
                    b = a + 1
                    if os.time()-protectMode <= protectModeTime then
                        b = b + 3
                    end
                end
            end
            
            self.x = self.x + self.speedX + a
            self.y = self.y + self.speedY + b
        end
        
        -- Maximal speed
        self.speedX = self.speedX + math.random(-2, 2)
        self.speedY = self.speedY + math.random(-1, 1)
        if self.speedX <= -20 then
            self.speedX = math.random(1, 10)
        elseif self.speedX >= 20 then
            self.speedX = math.random(-10, 1)
        elseif self.speedY <= -20 then
            self.speedY = math.random(1, 10)
        elseif self.speedY >= 20 then
            self.speedY = math.random(-10, -1)
        end
        
        -- Limit Moving Area
        -- Works worser then Magnetical Effect of Bonus
        
        if self.x <= -WIDTH*3 then
            self.speedX = -self.speedX
        elseif self.y <= -HEIGHT*3 then
            self.speedY = -self.speedY
        elseif self.x >= WIDTH*4 then
            self.speedX = -self.speedX
        elseif self.y >= HEIGHT*4 then
            self.speedY = -self.speedY
        end
        
        
    end
end

function BonusTypes()
    local c = {
        {"💣", "bomb"}, -- Kills all enemies in radius of 500 pixels around
        {"🔑", "key"}, -- Then more enemies, then more score you get
        {"⏱", "slow-mode"}, -- Slows enemies for seven seconds
        {"💵", "money1"}, -- Gives money/score
        {"💶", "money2"}, -- Gives money/score
        {"💴", "money3"}, -- Gives money/score
        {"❤️", "life"}, -- Gives one life
        {"💥", "superbomb"}, -- Kills all Enemies
        {"🛡", "protect"}, -- Protects you from any bomb touch for 7 seconds.
        {"🍀", "luck"} -- Moves all enemies, currently in screen, outside of thequadrants
    }
    return c[math.random(1, #c)]
end

function BonusAction(n)
    local v = {
        {"bomb", function()
            local n = 0
            for a, b in ipairs(bullets) do
                local radius = 500
                local difference = vec2(x-b.x, y-b.y)
                if difference.x < 0 then
                    difference.x = -difference.x
                end if difference.y < 0 then
                    difference.y = -difference.y
                end
                
                if difference.x ^ 2 + difference.y ^2 <= radius ^ 2 then
                    bullets[a].dead = true
                    n = n + 1
                end
            end
            extraPoints = extraPoints + n * 5
        end},
        {"key", function()
            extraPoints = extraPoints + #bullets * 2
        end},
        {"slow-mode", function()
            slowMode = os.time()
            extraPoints = extraPoints + 15
        end},
        {"money1", function()
            extraPoints = extraPoints + 5
        end},
        {"money2", function()
            extraPoints = extraPoints + 10
        end},
        {"money3", function()
            extraPoints = extraPoints + 25
        end},
        {"life", function()
            LIFES = LIFES + 1
            extraPoints = extraPoints + LIFES * 2 + 35
        end},
        {"superbomb", function()
            for a, b in ipairs(bullets) do
                bullets[a].dead = true
                extraPoints = extraPoints + 5
            end
        end},
        {"protect", function()
            protectMode = os.time()
            extraPoints = extraPoints + protectModeTime*2
        end},
        {"luck", function()
            for a, b in ipairs(bullets) do
                if b.x > 0 and b.y > 0 and b.x < WIDTH and b.y < HEIGHT then
                    o, p = math.random(1, 3), math.random(1, 3)
                    bullets[a].x = -WIDTH + (o-1) * WIDTH
                    bullets[a].y = -HEIGHT + (p-1) * HEIGHT
                end
            end
        end}
    }
    
    for a, b in ipairs(v) do
        if b[1] == n then
            b[2]()
        end
    end
end

Bonus = class()

function Bonus:init()
    self.lifeStarts = os.time()
    
    self.alive = true
    local t = BonusTypes()
    self.text = t[1]
    self.typeId = t[2]
    
    self.x = math.random(155, WIDTH-155)
    self.y = math.random(155, HEIGHT-155)
end

function Bonus:draw()
    if self.alive then
        if os.time()-self.lifeStarts > 3 then
            self.alive = false
        end
        
        fill(150, 150, 255)
        rect(self.x-25, self.y-25, 50, 50)
        fill(255)
        fontSize(50)
        font("AppleColorEmoji")
        text(self.text, self.x, self.y)
        
        if x >= self.x-25 and x <= self.x+25 and y >= self.y-25 and y <= self.y+25 then
            BonusAction(self.typeId)
            self.alive = false
        end
    end
end

