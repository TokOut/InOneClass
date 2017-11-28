
--# Functions
-- This are server-side functions

-- (item id, chance, amount) BROKEN
RandomChoose = function(...)
    n = ... -- Given Table [Id, Chance, MaxTimes]
    r = {} -- Data by [Id, MaxTimes]
    
    -- Convert N -> R
    for a, b in ipairs(n) do
        print(b)
        for c = 1, b[2] do
            table.insert(r, {b[1], b[3]})
        end
    end
    
    -- Get random  from R
    local s = 0 -- Random Id
    local d = 1 -- Times to get
    if #r >= 2 then
        local v = math.random(1, #r)
        s = r[v][1]
        if r[v][2] >= 2 then
            local p = {} -- Then more then fewer the chance
            for y = 1, r[v][2] do
                table.insert(p, {y, r[v][2], 1})
            end
            d = RandomChoose(p)
        end
    end
    
    return {s, d}
end

--# Enemy
-- ENEMIES

Enemy = class()

function Enemy:init(id, data, spawn, lookTo)
    self.id = id
    self.lifes = data.lifes
    self.lifesMax = data.lifes
    self.protection = data.shield
    self.atack = data.damage
    self.energy = data.energy
    self.pos = vec2(spawn.x, spawn.y)
    self.lookTo = lookTo or LEFT
    self.living = true
    self.tab = boss_list[id].init()
end

function Enemy:draw(x, y)
    if self.living then
        for a, b in ipairs(boss_list) do
            if b.id == self.id then
                if self.lookTo == RIGHT then
                    b.lookRight(x, y, self.tab)
                elseif self.lookTo == LEFT then
                    b.lookLeft(x, y, self.tab)
                end
            end
        end
    else
        for a, b in ipairs(boss_list) do
            if b.id == self.id then
                b.lookDead(x, y)
            end
        end
    end
    self.tab = boss_list[self.id].update(self.tab)
end

function Enemy:removeLifes(dmg)
    dmg = dmg - self.protection
    if dmg < 1 then
        dmg = 1
    end
    
    self.lifes = self.lifes - dmg
    
    if self.lifes <= 0 then
        self.living = false
    end
end

--# Game
-- !! THIS SLIDE MUST BE BEFORE THE SYSTEMS SLIDE !!

game = game or {}
gameData = gameData or {} -- Content of data, local data
gameOption = gameOption or {} -- Content of data, temporary data
gameNow = gameNow or {} -- Content of game (current)

function game.ui()
    resetStyle()
    local base
    if gameOption.inGame then
        base = gameOption.adventureEncode.stages[gameOption.level]
        local cam = gameOption.camera
        local playing = {}
        playing.nextRound = function()
            gameNow.totalRound = gameNow.totalRound + 1
            gameNow.round = gameNow.round + 1
        end
        playing.addEnemy = function(id, a, s, lookTo)
            table.insert(gameNow.enemies,
            Enemy(id, {lifes = a.l, shield = a.s, damage = a.d, energy = a.e}, vec2(s.x, s.y), lookTo)
            )
        end
        playing.start = function()
            
        end
        
        local x, y = 0, 0
        local a, b = spriteSize(game.item[base.bg] or image(1, 1))
        local c, d = spriteSize(game.item[base.map] or image(1, 1))
        if a > c then x = a else x = c end
        if b > d then y = b else y = d end
        
        -- Place
        sprite(game.item[base.bg] or image(1, 1), WIDTH/2+(cam.x * 1.5), HEIGHT/2+(cam.y * 1.5), x * 1.2, y * 1.2)
        
        --local w, h = spriteSize(game.item[base.map])
        sprite(game.item[base.map] or image(1, 1), WIDTH/2+cam.x, HEIGHT/2+cam.y)
        
        --[[ ** User Data ** ]]
        
        -- Lifes
        resetStyle()
        fill(255, 150)
        rect(10, HEIGHT-40, 200, 30)
        fill(0, 50, 255, 200)
        rect(12, HEIGHT-38, 196 * (gameNow.life/gameNow.lifeMaximum), 26)
        fill(0, 255)
        fontSize(26)
        font("Arial-BoldMT")
        text(gameNow.life, 110, HEIGHT-25)
        
        -- Energy
        resetStyle()
        fill(255, 150)
        rect(10, HEIGHT-70, 150, 25)
        fill(0, 255, 50, 200)
        rect(12, HEIGHT-68, 146 * (gameNow.energy/gameNow.energyMaximum), 21)
        fill(0, 255)
        fontSize(26)
        font("Arial-BoldMT")
        text(gameNow.energy .. " ⚡️", 85, HEIGHT-58)
        
        -- Move
        resetStyle()
        fill(255, 125)
        rect(15, 15, 50, 50)
        rect(70, 15, 50, 50)
        fill(0, 0, 0, 255)
        fontSize(50)
        font("Copperplate-Light")
        text("<", 40, 40)
        text(">", 95, 40)
        
        -- Minimap
        local format = 6
        resetStyle()
        fill(255, 100)
        strokeWidth(1)
        stroke(0, 255)
        local w, h = spriteSize(game.item[base.map] or image(1, 1))
        rect(WIDTH-w/format-5, HEIGHT-h/format-5, w/format, h/format)
        tint(255, 175)
        sprite(game.item[base.map] or image(1, 1), WIDTH-(w/2)/format-5, HEIGHT-(h/2)/format-5, w/format-2, h/format-2)
        fill(0, 255)
        font("ArialMT")
        fontSize(10)
        text("Round " .. gameNow.totalRound, WIDTH-5 - w/format + w/(format*2), HEIGHT-12)
        
        -- [Content: Players] Can't find right coordinates
        fill(0, 50, 255, 255)
        ellipse(WIDTH-w/format-5 + gameNow.playerPosition.x/format, HEIGHT-h/format + gameNow.playerPosition.y/format, 6, 6)
        
        for a, b in ipairs(gameNow.enemies) do
            fill(255, 0, 50, 255)
            ellipse(WIDTH-w/format + b.pos.x/format, HEIGHT-h/format-5 + b.pos.y/format, 6, 6)
        end
        
        -- [[ ** User Gaming ** ]]
        
        -- Player movement
        if gameNow.playerPosition.y > 5 then
            local c = game.item[base.texture]
            r,g,b,a = c:get(gameNow.playerPosition.x, gameNow.playerPosition.y-3)
            if r --[[g,b]] == 255 then
                gameNow.playerPosition.y = gameNow.playerPosition.y - 3
            end
        end
        
        if gameOption.touching then
            if base.texture then
                local r, g, b = game.item[base.texture]:get(gameNow.playerPosition.x, gameNow.playerPosition.y)
                local r1, g1, b1 = game.item[base.texture]:get(gameNow.playerPosition.x-2, gameNow.playerPosition.y)
                local r2, g2, b2 = game.item[base.texture]:get(gameNow.playerPosition.x+2, gameNow.playerPosition.y)
                local r3, g3, b3 = game.item[base.texture]:get(gameNow.playerPosition.x-2, gameNow.playerPosition.y+3)
                local r4, g4, b4 = game.item[base.texture]:get(gameNow.playerPosition.x+2, gameNow.playerPosition.y+3)
                
                if gameOption.touch == 1 then
                    if gameNow.playerPosition.x > 4 then
                        if r1 --[[g1, b1]] == 255 then
                            gameNow.playerPosition.x = gameNow.playerPosition.x - 2
                        elseif r3 --[[g3, b3]] == 255 then
                            gameNow.playerPosition.x = gameNow.playerPosition.x - 2
                            gameNow.playerPosition.y = gameNow.playerPosition.y + 3
                        end
                    end
                end
                
                if gameOption.touch == 2 then
                    local w, h = spriteSize(game.item[base.texture])
                    if gameNow.playerPosition.x < w-4 then
                        if r2 --[[g2, b2]] == 255 then
                            gameNow.playerPosition.x = gameNow.playerPosition.x + 2
                        elseif r4 --[[g4, b4]] == 255 then
                            gameNow.playerPosition.x = gameNow.playerPosition.x + 2
                            gameNow.playerPosition.y = gameNow.playerPosition.y + 3
                        end
                    end
                end
            end
        end
        
        -- Player as Object
        resetStyle()
        fill(255, 225)
        local w, h = spriteSize(game.item[base.map] or image(1, 1))
        rect(WIDTH/2-w/2+gameNow.playerPosition.x+cam.x, HEIGHT/2-h/2+gameNow.playerPosition.y+cam.y-5, 50, 50)
        
        
        -- [[ ** Playing ** ]]
        
        if gameNow.round == 0 then
            -- Before playing
            playing.nextRound()
            
            base.e.start(playing, gameOption.dataOfLevel)
        end
        
        -- [ * Music * ]
        
        if music.volume < 1 then
            music.volume = music.volume + 0.005
        end
        
        -- [ * Enemies * ]
        
        for a, b in ipairs(gameNow.enemies) do
            resetStyle()
            b:draw(b.pos.x + cam.x, b.pos.y + cam.y)
        end
        
        -- [[ ** Stage ** ]]
        
        resetStyle()
        if gameNow.state == 1 then
            fill(0, 100)
            rect(0, 0, WIDTH, HEIGHT)
            
            fill(179, 132, 82, 255)
            fontSize(75)
            font("AcademyEngravedLetPlain")
            text("VICTORY!", WIDTH/2, HEIGHT-75)
            
            fill(127, 127, 127, 255)
            rect(WIDTH/2-100, 50, 200, 50)
            fill(0, 0, 0, 255)
            fontSize(50)
            font("Futura-Medium")
            text("Continue", WIDTH/2, 75)
        elseif gameNow.state == 2 then
            fill(0, 175)
            rect(0, 0, WIDTH, HEIGHT)
            
            translate(120, HEIGHT-170)
            rotate(55)
            fill(179, 82, 81, 255)
            fontSize(75)
            font("Courier-Bold")
            text("FAILURE", 0, 0)
            resetMatrix()
            
            fill(127, 127, 127, 255)
            rect(WIDTH/2-100, 50, 200, 50)
            fill(0, 0, 0, 255)
            fontSize(50)
            font("Futura-Medium")
            text("Menu", WIDTH/2, 75)
        end
        
        if gameNow.totalRound >= 500 and gameNow.state == 0 then
            gameOption.func.lose()
        end
        
        base.e.check(playing, gameOption.dataOfLevel)
    else
        fill(255, 255, 255, 255)
        rect(200, 50, WIDTH-400, HEIGHT-100)
        
        fill(250, 120, 0, 255)
        rect(210, 60, WIDTH-420, 70)
        
        fill(255, 255, 255, 255)
        fontSize(35)
        font("ArialRoundedMTBold")
        text("Start Round!", WIDTH/2, 95)
        
        fill(0, 0, 0, 255)
        rect(210, 150, WIDTH-420, HEIGHT-220) -- TEMPORARY, INSTEAD OF IMAGE
        
        --[[fill(255, 255, 255, 255)
        fontSize(50)
        font("AcademyEngravedLetPlain")
        local str = gameOption.adventureEncode.stages[gameOption.level].mission
        local a, b = textSize(str)
        text(str, 210 + x/2, HEIGHT-70 - y/2)]]
    end
end

function game.touch(t)
    if gameOption.inGame then
        local base = gameOption.adventureEncode.stages[gameOption.level]
        if gameNow.state == 1 then
            if t.state == ENDED then
                if t.x > WIDTH/2-100 and t.x < WIDTH/2+100 and t.y > 50 and t.y < 100 then
                    if gameOption.level >= #gameOption.adventureEncode.stages then
                        RoomId = 0
                        lobby.music()
                        param.lobby()
                    else
                        lobby.music()
                        gameOption.inGame = false
                        gameNow.state = 0
                        gameOption.level = gameOption.level + 1
                    end
                end
            end
        elseif gameNow.state == 2 then
            if t.state == ENDED then
                if t.x > WIDTH/2-100 and t.x < WIDTH/2+100 and t.y > 50 and t.y < 100 then
                    RoomId = 0
                    lobby.music()
                    param.lobby()
                end
            end
        else
            if t.state == BEGAN then
                gameOption.touching = true
            end
            
            --[[
            gameOption.touch
            0 - Camera moving/ Nil
            1 - Move Left
            2 - Move Right
            ]]
            
            -- Movement
            if t.x > 15 and t.x < 65 and t.y > 15 and t.y < 65 and t.state == BEGAN then
                gameOption.touch = 1
            end
            
            if t.x > 70 and t.x < 120 and t.y > 15 and t.y < 65 and t.state == BEGAN then
                gameOption.touch = 2
            end
            
            -- Camera movement
            if t.state == MOVING and gameOption.touch == 0 then
                gameOption.camera.x = gameOption.camera.x + t.deltaX
                gameOption.camera.y = gameOption.camera.y + t.deltaY
            end
            
            local w, h = spriteSize(game.item[base.map])
            if gameOption.camera.x > w/2 - WIDTH/2 then
                gameOption.camera.x = w/2 - WIDTH/2
            end
            if gameOption.camera.x < WIDTH/2 - w/2 then
                gameOption.camera.x = WIDTH/2 - w/2
            end
            if gameOption.camera.y < HEIGHT/2 - h/2 then
                gameOption.camera.y = HEIGHT/2 - h/2
            end
            if gameOption.camera.y > h/2 - HEIGHT/2 then
                gameOption.camera.y = h/2 - HEIGHT/2
            end
            
            if t.state == ENDED then
                gameOption.touch = 0
            end
        end
    else
        if t.state == ENDED and t.x > 210 and t.x < WIDTH-210 and t.y > 60 and t.y < 120 then
            game.start()
        end
    end
end

function game.join(data)
    gameData = data
    gameOption.level = 1
    gameOption.inGame = false
    --gameOption.adventureEncode = data--gameOption.adventureEncode or {}
    gameOption.camera = vec2(0, 0)
    gameOption.touch = 0
    gameOption.touching = false
    gameOption.dataOfLevel = gameOption.dataOfLevel or {}
    
    -- Functions
    gameOption.func = {}
    
    gameOption.func.win = function()
        gameNow.state = 1
        music.stop()
        sound("A Hero's Quest:Level Up")
    end
    
    gameOption.func.lose = function()
        gameNow.state = 2
        music.stop()
        sound("Game Sounds One:Pac Death 1")
    end
end

function game.start()
    gameOption.adventureEncode = gameData.levels[lobby.alert_option.difficultySelected]
    
    -- Set Utilities
    gameNow.lifeMaximum = 1000
    gameNow.life = gameNow.lifeMaximum
    gameNow.round = 0
    gameNow.totalRound = 0
    gameNow.energyMaximum = 200
    gameNow.energy = gameNow.energyMaximum
    gameNow.playerPosition = gameOption.adventureEncode.stages[gameOption.level].pos or vec2(1, 1)
    gameNow.state = 0 -- 0 playing, 1 win, 2 lose
    gameNow.enemies = {}
    
    -- Last Action: Start Game + Music
    if gameOption.adventureEncode.stages[gameOption.level].song then
        music(gameOption.adventureEncode.stages[gameOption.level].song, true)
        --music.volume = 0
    end
    gameOption.inGame = true
end

--# Lobby
-- !! THIS SLIDE MUST BE BEFORE THE SYSTEMS SLIDE !!

lobby = lobby or {}

function lobby.ui()
    -- Content
    resetStyle()
    fill(225, 255)
    rect(10, 10, WIDTH-20, HEIGHT-20)
    
    -- Levels
    resetStyle()
    fill(127, 255)
    rect(WIDTH-315, 15, 300, HEIGHT-35)
    -- Buttons
    for a, b in ipairs(level_list) do
        resetStyle()
        fill(0, 0, 0, 255)
        rect(WIDTH-300, HEIGHT-25 - a * 70, 275, 65)
        clip(WIDTH-300, HEIGHT-25 - a * 70, 275, 65)
        fill(255, 255, 255, 255)
        if b.minLevel > lobby.XPIntoLevel() then
            fill(255, 0, 0, 255)
            text(b.minLevel, WIDTH-50, HEIGHT+20 - a * 70)
            fill(50, 255)
        end
        fontSize(35)
        text(b.name, WIDTH-300 + 137.5, HEIGHT+5 - a * 70)
        clip()
    end
    
    -- Navigation
    resetStyle()
    fill(127, 255)
    rect(15, HEIGHT-70, WIDTH-335, 50)
    
    -- Level Number
    fill(255, 255)
    rect(20, HEIGHT-65, 40, 40)
    fill(127, 127, 127, 255)
    if lobby.XPIntoLevel() >= 100 then -- More then 3 digits
        fontSize(20)
    elseif lobby.XPIntoLevel() >= 10 then
        fontSize(30)
    else
        fontSize(40)
    end
    text(lobby.XPIntoLevel(), 40, HEIGHT-45)
    
    -- Inventory Button
    resetStyle()
    fill(255, 255, 255, 255)
    rect(WIDTH-365, HEIGHT-65, 40, 40)
    fill(0, 0, 0, 255)
    fontSize(40)
    font("Baskerville-Bold")
    text("I", WIDTH-345, HEIGHT-45)
    
    -- Content
    resetStyle()
    fill(100, 255)
    rect(15, 15, WIDTH-335, HEIGHT-95)
    
    fill(127, 127, 127, 255)
    rect(20, 250, WIDTH-345, HEIGHT-335)
    
    font("Inconsolata") -- Temporary "text()"
    
    fill(0, 0, 0, 255)
    translate(20 + (WIDTH-335)/2, 500)
    if not loading then
        rotate(os.clock()*70)
    end
    
    if game.item["o-aura-star"] then
        sprite(game.item["o-aura-star"], 0, 0)
    end
    resetMatrix()
    
    -- STATS [[
    
    fill(106, 65, 65, 255)
    rect(25, 205, 250, 40)
    fontSize(25)
    local str = "[Damage]"
    local strL, _ = textSize(str)
    fill(255, 255, 255, 255)
    text(str, 70 + strL/2, 225)
    sprite(game.item["o-symbol-sword"] or image(1, 1), 45, 225)
    
    fill(81, 83, 143, 255)
    rect(25, 159, 250, 40)
    fontSize(25)
    local str = "[Protection]"
    local strL, _ = textSize(str)
    fill(255, 255, 255, 255)
    text(str, 70 + strL/2, 179)
    sprite(game.item["o-symbol-shield"] or image(1, 1), 45, 179)
    
    fill(142, 74, 81, 255)
    rect(25, 113, 250, 40)
    fontSize(25)
    local str = "[Health]"
    local strL, _ = textSize(str)
    fill(255, 255, 255, 255)
    text(str, 70 + strL/2, 133)
    sprite(game.item["o-symbol-heart"] or image(1, 1), 45, 133)
    
    fill(57, 77, 67, 255)
    rect(25, 67, 250, 40)
    fontSize(25)
    local str = "[Energy]"
    local strL, _ = textSize(str)
    fill(255, 255, 255, 255)
    text(str, 70 + strL/2, 87)
    sprite(game.item["o-symbol-energy"] or image(1, 1), 45, 87)

    
    fill(109, 65, 94, 255)
    rect(25, 21, 250, 40)
    fontSize(25)
    local str = "[Power]"
    local strL, _ = textSize(str)
    fill(255, 255, 255, 255)
    text(str, 70 + strL/2, 41)
    sprite(game.item["o-symbol-power"] or image(1, 1), 45, 41)
    
    -- STATS ]]
    
    -- Split Line
    resetStyle()
    strokeWidth(5)
    lineCapMode(SQUARE)
    stroke(127, 127, 127, 255)
    line(285, 21, 285, 245)
    
    -- ITEMS [[
    
    fill(127, 127, 127, 255)
    rect(300, 205, WIDTH-625, 40)
    fill(255, 255, 255, 255)
    fontSize(40)
    font("Inconsolata")
    local str = user.coins
    local strL, _ = textSize(str)
    text(str, 310 + strL/2, 225)
    
    fill(127, 127, 127, 255)
    rect(300, 155, WIDTH-625, 40)
    fill(255, 255, 255, 255)
    fontSize(40)
    font("Inconsolata")
    local str = "[VALUE]"
    local strL, _ = textSize(str)
    text(str, 310 + strL/2, 175)
    
    fill(127, 127, 127, 255)
    rect(300, 105, WIDTH-625, 40)
    fill(255, 255, 255, 255)
    fontSize(40)
    font("Inconsolata")
    local str = "[VALUE]"
    local strL, _ = textSize(str)
    text(str, 310 + strL/2, 125)
    
    fill(127, 127, 127, 255)
    rect(300, 55, WIDTH-625, 40)
    fill(255, 255, 255, 255)
    fontSize(40)
    font("Inconsolata")
    local str = "[VALUE]"
    local strL, _ = textSize(str)
    text(str, 310 + strL/2, 75)
    
    -- ITEMS ]]
    
    
    resetStyle()
    if lobby.alert then
        fill(0, 100)
        rect(-5, -5, WIDTH+10, HEIGHT+10)
        
        fill(255, 255)
        rect(100, 100, WIDTH-200, HEIGHT-200)
        
        fill(225, 255)
        rect(100, HEIGHT-150, WIDTH-250, 50)
        fill(50, 125, 255, 255)
        font("Arial-BoldMT")
        fontSize(45)
        local a, _ = textSize(lobby.alert_data.name)
        text(lobby.alert_data.name, 160 + a/2, HEIGHT-125)
        
        fill(0, 255)
        rect(100, HEIGHT-150, 50, 50) -- TEMPORARY, INSTEAD OF IMAGE
        
        fill(255, 125, 125, 255)
        rect(WIDTH-150, HEIGHT-150, 50, 50)
        
        -- Tab Design
        resetStyle()
        if lobby.XPIntoLevel() < lobby.alert_data.minLevel then
            fill(255, 0, 0, 255)
        else
            fill(0, 150, 0, 255)
        end
        fontSize(25)
        text("Minimal Level: " .. lobby.alert_data.minLevel, WIDTH/2, HEIGHT-165)
        
        -- Entering Design
        resetStyle()
        if (lobby.XPIntoLevel() < lobby.alert_data.minLevel) then
            fill(127, 255)
            rect(105, 105, WIDTH-210, HEIGHT-285)
            
            fill(255, 255, 255, 255)
            fontSize(50)
            font("Baskerville-SemiBold")
            text("Locked!", WIDTH/2, HEIGHT-215)
            
            font("Baskerville")
            fontSize(35)
            text("You can't join this campaign.", WIDTH/2, HEIGHT/2)
        else
            
            if lobby.alert_data.type == "default" then
                fill(200, 255)
                rect(105, 105, 300, HEIGHT-290)
                
                -- for a, b in ipairs(lobby.alert_data.levels) do
                print(#lobby.alert_data.levels)
                for a = 1, #lobby.alert_data.levels do
                    --[[
                    resetStyle()
                    fill(100, 255)
                    if lobby.alert_option.difficultySelected == a then
                        strokeWidth(5)
                        stroke(0, 0, 0, 255)
                    end
                    rect(110, HEIGHT-185 - a*50, 290, 45)
                    if lobby.alert_option.difficultySelected then
                        if lobby.alert_option.difficultySelected == a then
                            strokeWidth(5)
                            stroke(200, 150, 75, 255)
                        end
                    end
                    resetStyle()
                    for c, d in ipairs(user.campaign) do
                        if d.id == lobby.alert_data.id then
                            if d.saved < a then
                                fill(150, 255)
                            else
                                fill(255, 255)
                            end
                        end
                    end
                    fontSize(35)
                    font("Copperplate")
                    text(b.diff, 255, HEIGHT-162.5 - a * 50)
                    ]]
                    
                    resetStyle()
                    fill(65, 0, 255, 255)
                    if lobby.alert_option.difficultySelected == a then
                        strokeWidth(5)
                        stroke(0, 65, 255, 255)
                    end
                    rect(110, HEIGHT-185 - a*50, 290, 45)
                end
                
                resetStyle()
                fill(200, 255)
                rect(410, 110, WIDTH-515, HEIGHT-295)
                
                for a, b in ipairs(lobby.alert_data.levels) do
                    if lobby.alert_option.difficultySelected == a then
                        resetStyle()
                        
                        -- Start
                        fill(204, 133, 76, 255)
                        rect(420, 120, WIDTH-535, 60)
                        
                        fill(255, 255, 255, 255)
                        fontSize(45)
                        font("Arial-BoldMT")
                        text("Join!", 420 + (WIDTH-535)/2, 150)
                        
                        
                        resetStyle()
                        fill(0, 0, 0, 255)
                        rect(420, 200, WIDTH-535, HEIGHT-400) -- TEMPORARY, INSTEAD OF IMAGE
                    end
                end
                
            end
            
        end
    elseif lobby.inv then
        fill(0, 200)
        rect(0, 0, WIDTH, HEIGHT)
        fill(255, 255, 255, 255)
        rect(50, 50, WIDTH-100, HEIGHT-100)
        
        -- Navigation
        fill(255, 125, 125, 255)
        rect(WIDTH-100, HEIGHT-100, 50, 50)
        
        strokeWidth(2)
        stroke(0, 0, 0, 255)
        line(50, HEIGHT-100, WIDTH-50, HEIGHT-100)
        
        fill(50, 125, 255, 255)
        fontSize(50)
        font("Arial-BoldMT")
        str = "Inventory"
        local a,_ = textSize(str)
        text(str, 55 + a/2, HEIGHT-75)
        
        for x = 1, 17 do
            for y = 1, 11 do
                fill(127, 127, 127, 255)
                rect(x * 54, y * 55, 50, 50)
                if not ( user.inv[x][y].id == 0 ) then
                    if game.item[item_list[user.inv[x][y].id].logo] then
                        sprite(game.item[item_list[user.inv[x][y].id].logo],(x+.5)*54-2,(y+.5)*55-2)
                    else
                        fill(0, 0, 0, 255)
                        rect(x * 54, y * 55, 50, 50)
                        fontSize(35)
                        font("ArialRoundedMTBold")
                        fill(255, 255, 255, 255)
                        text("?", x * 54 + 25, y * 55 + 30)
                    end
                        -- Has got "amount"
                    if user.inv[x][y].amount > 1 then
                        fontSize(12)
                        font("Arial-BoldMT")
                        fill(44, 142, 183, 255)
                        local q,_ = textSize(user.inv[x][y].amount)
                        text(user.inv[x][y].amount, x * 54 + 50 - q/2, y * 55 + 10)
                    end
                end
            end
        end
        
        resetStyle()
        if lobby.invObjectShown then
            fill(0, 150)
            rect(0, 0, WIDTH, HEIGHT)
            fill(150, 255)
            rect(150, 150, WIDTH-300, HEIGHT-300)
            
            resetStyle()
            fill(0, 0, 0, 255)
            fontSize(35)
            font("Georgia")
            local str = item_list[lobby.invObjectId].name
            local a, b = textSize(str)
            text(str, 155 + a/2, HEIGHT-155 - b/2)
            
            resetStyle()
            fill(0, 0, 0, 255)
            fontSize(25)
            font("Arial-BoldMT")
            local str = "Quality:"
            local a, c = textSize(str)
            text(str, 155 + a/2, HEIGHT-160 - b - c/2)
            
            resetStyle()
            fontSize(25)
            font("ArialRoundedMTBold")
            local str = ""
            if item_list[lobby.invObjectId].quality == 1 then
                str = "Bad"
                fill(0, 0, 0, 255)
            elseif item_list[lobby.invObjectId].quality == 2 then
                str = "Default"
                fill(41, 79, 36, 255)
            elseif item_list[lobby.invObjectId].quality == 3 then
                str = "Good"
                fill(142, 112, 64, 255)
            elseif item_list[lobby.invObjectId].quality == 4 then
                str = "Perfect"
                fill(159, 63, 39, 255)
            elseif item_list[lobby.invObjectId].quality == 5 then
                str = "Best"
                fill(185, 58, 163, 255)
            elseif item_list[lobby.invObjectId].quality == 6 then
                str = "Legend"
                fill(95, 62, 106, 255)
            else -- Bug
                str = "Null"
                fill(255, 255)
            end
            local d, _ = textSize(str)
            text(str, 160 + a + d/2, HEIGHT-160 - b - c/2)
            
            resetStyle()
            fill(0, 0, 0, 255)
            rect(160, 160, 260, HEIGHT-400)
            
            -- Black Description Block
            resetStyle()
            -- b, c are given values
            if item_list[lobby.invObjectId].type == 1 then
                fill(0, 0, 0, 255)
                fontSize(20)
                font("AmericanTypewriter")
                local str = "(Weapon)"
                local e, _ = textSize(str)
                text(str, 165 + a + d + e/2, HEIGHT-160 - b - c/2)
                
                -- Stats
                fill(255, 255, 255, 255)
                fontSize(25)
                font("HelveticaNeue-Light")
                local str = "DMG:"
                local a,_ = textSize(str)
                text(str, 160 + a/2, HEIGHT-185 - b - c)
                local str = "PRT:"
                local a,_ = textSize(str)
                text(str, 160 + a/2, HEIGHT-215 - b - c)
                local str = "Lifes:"
                local a,_ = textSize(str)
                text(str, 160 + a/2, HEIGHT-245 - b - c)
                local str = "NRG:"
                local a,_ = textSize(str)
                text(str, 160 + a/2, HEIGHT-275 - b - c)
                local str = "POW:"
                local a,_ = textSize(str)
                text(str, 160 + a/2, HEIGHT-305 - b - c)
                
                fill(208, 72, 72, 255)
                local str = item_list[lobby.invObjectId].damage
                local a,_ = textSize(str)
                text(str, 420 - a/2, HEIGHT-185 - b - c)
                fill(71, 148, 208, 255)
                local str = item_list[lobby.invObjectId].protection
                local a,_ = textSize(str)
                text(str, 420 - a/2, HEIGHT-215 - b - c)
                fill(90, 196, 129, 255)
                local str = item_list[lobby.invObjectId].lifes
                local a,_ = textSize(str)
                text(str, 420 - a/2, HEIGHT-245 - b - c)
                fill(68, 141, 85, 255)
                local str = item_list[lobby.invObjectId].energy
                local a,_ = textSize(str)
                text(str, 420 - a/2, HEIGHT-275 - b - c)
                fill(202, 127, 197, 255)
                local str = item_list[lobby.invObjectId].power
                local a,_ = textSize(str)
                text(str, 420 - a/2, HEIGHT-305 - b - c)
                
            elseif item_list[lobby.invObjectId].type == 2 then
                font("Arial-BoldMT")
                if item_list[lobby.invObjectId].minLevel <= lobby.XPIntoLevel() then
                    fill(78, 255, 0, 255)
                else
                    fill(255, 0, 0, 255)
                end
                local str = "Minimal Level: " .. item_list[lobby.invObjectId].minLevel
                local a,_ = textSize(str)
                text(str, 160 + a/2, HEIGHT-185 - b - c)
                
                fill(127, 127, 127, 255)
                text("Content:", 205, HEIGHT-185 - b - c - 20)
                for a, d in ipairs(item_list[lobby.invObjectId].inside) do
                    fill(255, 255, 255, 255)
                    
                    local str = item_list[d[1]].name
                    
                    -- Modify String
                    if d[2] > 1 then
                        str = str .. " (x" .. d[2] .. ")" 
                    end
                    if item_list[d[1]].type == 1 then
                        str = str .. " ⚔" --  ⚒
                    end
                    
                    local e,_ = textSize(str)
                    text(str, 180 + e/2, HEIGHT-185 - b - c - (a+1) * 20)
                end
            elseif item_list[lobby.invObjectId].type == 3 then
                textWrapWidth(250)
                fill(255, 255, 255, 255)
                fontSize(25)
                font("Futura-Medium")
                local str = item_list[lobby.invObjectId].desc
                local a, d = textSize(str)
                text(str, 165 + a/2, HEIGHT-185 - b - c - d/2)
            elseif item_list[lobby.invObjectId].type == 4 then
                fill(52, 174, 184, 255)
                fontSize(25)
                font("Futura-Medium")
                local str = "HEAL: " .. item_list[lobby.invObjectId].effect
                local a,_ = textSize(str)
                text(str, 160 + a/2, HEIGHT-185 - b - c)
            end
            
            -- Actions
            
            resetStyle()
            fill(0, 0, 0, 255)
            if item_list[lobby.invObjectId].canSell then
                fill(255, 175, 0, 255)
            end
            rect(WIDTH-300, 150, 150, 50)
            fill(255, 255, 255, 255)
            fontSize(40)
            font("ArialMT")
            text("Sell", WIDTH-225, 175)
            
            resetStyle()
            if item_list[lobby.invObjectId].type == 2 then
                fill(210, 85, 85, 255)
                rect(WIDTH-300, 200, 150, 50)
                fill(255, 255, 255, 255)
                fontSize(40)
                font("ArialMT")
                text("Open", WIDTH-225, 225)
            end
            
            resetStyle()
            fill(255, 100, 100, 255)
            rect(WIDTH-200, HEIGHT-200, 50, 50)
        end
    end
    
    if user.experience < 0 then
        user.experience = 0
    end
end

function lobby.touch(t)
    if lobby.alert then
        -- Close
        if t.x > WIDTH-150 and t.x < WIDTH-100 and t.y > HEIGHT-150 and t.y < HEIGHT-100 and t.state == ENDED then
            lobby.alert = false
            lobby.alert_option.difficultySelected = nil
        end
        
        -- Level UI
        if lobby.alert_data.type == "default" then
            -- Difficult select
            for a, b in ipairs(lobby.alert_data.levels) do
                if t.x>110 and t.y>HEIGHT-185-a*50 and t.x<400 and t.y<HEIGHT-140-a*50 and t.state==BEGAN then
                    for c, d in ipairs(user.campaign) do
                        if d.id == lobby.alert_data.id then
                            if d.saved < a then else
                                lobby.alert_option.difficultySelected = a
                            end
                        end
                    end
                end
                
                -- Join Level
                if t.x > 420 and t.x < WIDTH-135 and t.y > 120 and t.y < 180 and t.state == ENDED then
                    if lobby.alert_option.difficultySelected == a then
                        lobby.alert = false
                        param.game()
                        RoomId = 1
                        game.join(lobby.alert_data)
                        -- After game.join. Command is there translated. Breaks Game class
                        --lobby.alert_option.difficultySelected = nil
                    end
                end
            end
        end
    elseif lobby.inv then
        if lobby.invObjectShown == true then
            if t.x>WIDTH-200 and t.x<WIDTH-150 and t.y>HEIGHT-200 and t.y<HEIGHT-150 and t.state==ENDED then
                lobby.invObjectShown = false
            end
            
            --rect(WIDTH-300, 150, 150, 50)
            if t.x>WIDTH-200 and t.x<WIDTH-150 and t.y>150 and t.y<200 then
                -- Sell
            end
            
            if t.x>WIDTH-200 and t.x<WIDTH-150 and t.y>150 and t.y<200 and item_list[lobby.invObjectId].type then
                -- Open Chest
                user.inv[lobby.invObject.x][lobby.invObject.y].amount =
                                            user.inv[lobby.invObject.x][lobby.invObject.y].amount - 1
                if user.inv[lobby.invObject.x][lobby.invObject.y].amount == 0 then
                    user.inv[lobby.invObject.x][lobby.invObject.y] = {}
                end
                
                for a, b in ipairs(item_list[lobby.invObjectId].inside) do
                    -- Put inside existing item
                    local k = true
                    
                    local p = item_list[lobby.invObjectId].type == 2
                    if (p == 2) or (p == 3) then
                        for x = 1, 17 do
                            for y = 1, 11 do
                                if user.inv[x][y].id == b[1] then
                                    user.inv[x][y].amount = user.inv[x][y].amount + b[2]
                                    k = false
                                    break break
                                end
                            end
                        end
                    end
                        
                    if k then
                        for x = 1, 17 do
                            for y = 1, 11 do
                                if user.inv[x][y] == {} then
                                    user.inv[x][12-y] = {id = b[1], amount = b[2]}
                                end
                            end
                        end
                    end
                end
            end
        else
            for x = 1, 17 do
                for y = 1, 11 do
                    if t.x>x*54 and t.x<x*54+50 and t.y>y*55 and t.y<y*55+50
                        and t.state == ENDED and not (user.inv[x][y].id == 0) then
                        --rect(x * 54, y * 55, 50, 50)
                        lobby.invObjectShown = true
                        lobby.invObject = vec2(x, y)
                        lobby.invObjectId = user.inv[x][y].id
                    end
                end
            end
            
            if t.x>WIDTH-100 and t.x<WIDTH-50 and t.y>HEIGHT-100 and t.y<HEIGHT-50 and t.state == ENDED then
                lobby.inv = false
                param.lobby()
            end
        end
    else
        for a, b in ipairs(level_list) do
            if t.x > WIDTH-300 and t.x < WIDTH-25 and t.y > HEIGHT-25 - a * 70 and t.y < HEIGHT + 40 - a * 70 then
                if t.state == ENDED then
                    lobby.openRoom(level_list[a])
                end
            end
        end
        
        -- WIDTH-365, HEIGHT-65, 40, 40
        if t.x>WIDTH-365 and t.x<WIDTH-325 and t.y>HEIGHT-65 and t.y<HEIGHT-25 and t.state == ENDED then
            lobby.inv = true
            param.inventory()
        end
    end
end

function lobby.openRoom(tab)
    lobby.alert = true
    
    lobby.alert_data = tab
end

function lobby.XPIntoLevel()
    local a = user.experience
    
    -- Level, Required XP
    local calculations = {
    {1, -1},
    {2, 5},
    {3, 15},
    {4, 50},
    {5, 100},
    {6, 300},
    {7, 450},
    {8, 950},
    {9, 1255},
    {10, 1350},
    {11, 1500},
    {12, 2750},
    {13, 3000},
    {14, 3275},
    {15, 4650},
    {16, 5900},
    {17, 6250},
    {18, 7500},
    {19, 8750},
    {20, 9525}
    }
    
    -- Return Item
    local xp = user.experience
    local d = #calculations
    local maxXP = 0
    
    for a = 1, d do
        maxXP = maxXP + calculations[a][2]
        if (calculations[a][2] >= xp) and (not f) then
            xp = xp - calculations[a][2]
            return calculations[a][1]-1
        end
    end
    
    if user.experience > calculations[d][2] then
        local s = user.experience - calculations[d][2]
        local r = math.ceil(math.floor(s * 2) ^ (3/4))
        user.experience = calculations[d][2]
        print("Reached maximal level. " .. s .. " experience points will be moved to " .. r .. " coins")
        user.coins = user.coins + r
        return calculations[d][1]
    end
end

--# Cheats
-- !! THIS SLIDE MUST BE BEFORE THE SYSTEMS SLIDE !!

param = param or  {}
param.option = param.option or {}

param_totalround = 5
param_xp = ""
param_inv_id = 1
param_inv_amount = 1

function param.lobby()
    parameter.clear()
    
    parameter.text("param_xp", "0")
    parameter.action("Add XP", function()
        user.experience = user.experience + tonumber(param_xp)
    end)
end

function param.game()
    parameter.clear()
    
    parameter.integer("param_totalround", 1, 500)
    parameter.action("Set Round", function()
        if gameOption.inGame then
            gameNow.totalRound = param_totalround
        end
    end)
    
    parameter.action("Win!", function()
        if gameOption.inGame then
            for a, b in ipairs(gameNow.enemies) do
                b:removeLifes(50000)
            end
            gameOption.func.win()
        end
    end)
    
    parameter.action("Lose!", function()
        if gameOption.inGame then
            gameOption.func.lose()
        end
    end)
end

function param.inventory()
    parameter.clear()
    
    parameter.text("param_inv_id", "1")
    
    parameter.integer("param_inv_amount", 1, 999, 1)
    
    -- Brocken
    parameter.action("Add!", function()
        
    end)
end


--# System
-- !! THIS SLIDE MUST BE BEFORE MAIN, BUT AFTER ALL OTHER TABLES !!

main = main or {}
user = user or {}

function main.setup(name, release)
    -- "main"
    GameName = name
    GameVersion = "v" .. release
    
    param.lobby()
    RoomId = 0
    
    -- Boss List
    boss_list = {
    
    --[[
    Default Values (Here)
    
    .id - The unique number of the monster
    .name - The random name of the monster
    .phy - The physic, were your gun will stop (Not going trough monster.)
    
    . - You can change this values
    
    Values (To Specify)
    
    lifes - The number of points how many the monster has.
    shield - The number of points, which will be taken from your damage.
    damage - The number of points, which will be the default damage to you.
    energy - The maximal movement energy the monster will have
    power - The power which will be added to the damage randomly.
    ]]
    
        {
            id = 1,
            name = "kingjack_warrior_1",
            phy = vec2(50, 50),
            
            -- Main Functions
            init = function()
                local t = {}
                t.y = math.random(-20, 20) -- Position
                t.s = math.random(0, 1) -- State
                t.v = math.random(3, 10)/10 -- Speed
                t.d = math.random(15, 35)
                return t
            end,
            update = function(t)
                if t.s == 1 then
                    t.y = t.y + t.v
                elseif t.s == 0 then
                    t.y = t.y - t.v
                end
                
                if t.y > t.d then
                    t.s = 0
                end
        
                if t.y < -t.d then
                    t.s = 1
                end
        
                return t
            end,
            
            -- How they look like
            lookLeft = function(x, y, t)
                local a,_ = spriteSize(game.item["e-bug-left"])
                sprite(game.item["e-bug-left"], x - a, y + t.y)
            end,
            lookRight = function(x, y, t)
                local a,_ = spriteSize(game.item["e-bug-right"])
                sprite(game.item["e-bug-right"], x - a, y + t.y)
            end,
            lookDead = function(x, y)
                translate(x, y)
                rotate(180)
                tint(80, 80, 80, 255)
                sprite(game.item["e-bug-right"], 0, 0)
                rotate(-180)
                translate(-x, -y)
            end,
            atack = function(x, y, pX, pY)
                
            end
        },
            
        {
            id = 2,
            name = "kingjack",
            phy = vec2(50, 50),
            
            -- Main Functions
            init = function()
                local t = {}
                
                return t
            end,
            update = function(t)
                
                return t
            end,
            
            -- How they look like
            lookLeft = function(x, y, t)
                sprite(game.item["e-lavis-head"], x, y)
            end,
            lookRight = function(x, y, t)
                sprite(game.item["e-lavis-head"], x, y)
            end,
            lookDead = function(x, y)
                
            end,
            atack = function(x, y, pX, pY)
                
            end
        }
    }
    
    -- Item List
    --[[
    logo - Picture from game.item[logo]
    name - The displayed name.
    quality - Is it bad or good?
    type - Which type is this Object?
        (type == 1)
            -- Weapon
            damage - The basic damage, this Object has got.
            protection - The basic Protection this Object gives to you.
            lifes - The amount of life points you get from item.
            energy - The amount of additional energy
            power - The amount of additional power
            lookDefault - The graphic, for the weapon.
        (type == 2)
            -- Chests
            inside - Table of items you'll receive: [Id, Amount, Table of Item's-Data]
            required - Id of Object which is required. 0 for nothing
            minLevel - Minimal Level to open it.
        (type == 3)
            -- Object
            desc - Description
        (type == 4)
            -- Artifact
            (sub_type == 1)
            -- Heal Sphere
            effect - The amount of lifepoints you will regenerate
        (everyone)
            canSell - Ability to sell it.
            (canSell == true)
            sell_costs - Function, what happens when sold
                -> Argument "i" - Amount sold
    ]]
    item_list = {
    
    -- Shuriken
    [1] = {
        logo = "inv-galaxy",
        name = "☆ Galaxy",
        quality = 1,
        type = 1,
        
        damage = 100,
        protection = 10,
        lifes = 2000,
        energy = 100,
        power = 75,
        
        lookDefault = "wp-galaxy",
        
        canSell = false
    },
    
    [2] = {
        logo = "inv-chest",
        name = "☆ Level Box",
        quality = 2,
        type = 2,
        
        inside = {
            {3, 1},
            {5, 1},
            {6, 50}
        },
        minLevel = 10,
        required = 0,
        
        canSell = false
    },
    
    [3] = {
        logo = "inv-chest",
        name = "☆☆ Level Box",
        quality = 2,
        type = 2,
        
        inside = {
            {4, 1}
        },
        minLevel = 20,
        required = 0,
        
        canSell = false
    },
    
    [4] = {
        logo = "inv-chest",
        name = "☆☆☆ Level Box",
        quality = 3,
        type = 2,
        
        inside = {
            {10, 1}
        },
        minLevel = 30,
        required = 0,
        
        canSell = false
    },
    
    [5] = {
        logo = "inv-totem",
        name = "☆ Totem",
        quality = 3,
        type = 1,
        
        damage = 300,
        protection = 100,
        lifes = 7500,
        energy = 150,
        power = 125,
        
        canSell = true,
        sell_costs = function(i)
            user.coins = user.coins + 500
        end
    },
    
    [6] = {
        logo = "nil",
        name = "Upgrade Stone",
        quality = 5,
        type = 3,
        
        desc = "Use this stones to upgrade your weapon. Then higher the upgrade then more stones you need. But Upgrades on high levels have more effect.",
        
        canSell = true,
        sell_costs = function(i)
            user.coins = user.coins + 50
        end
    },
    
    [7] = {
        logo = "nil",
        name = "☆ Key",
        quality = 0,
        type = 3,
        
        desc = "Use this key to open chests.",
        
        canSell = true,
        sell_costs = function(i)
            
        end
    },
    
    [8] = {
        logo = "inv-blade2",
        name = "☆☆ Dark Blade",
        quality = 6,
        type = 1,
        
        damage = 1000,
        protection = 500,
        lifes = 10000,
        energy = 350,
        power = 300,
        
        lookDefault = "wp-blade",
        
        canSell = true,
        sell_costs = function(i)
            
        end
    },
    
    [9] = {
        logo = "inv-blade",
        name = "☆ Dark Blade",
        quality = 5,
        type = 1,
        
        damage = 750,
        protection = 450,
        lifes = 5000,
        energy = 250,
        power = 290,
        
        lookDefault = "wp-blade",
        
        canSell = true,
        sell_costs = function(i)
            
        end
    },
    
    [10] = {
        logo = "inv-bloodsphere",
        name = "☆ Blood Elixir",
        quality = 2,
        type = 4,
        sub_type = 1,
        
        effect = 20,
        
        canSell = true,
        sell_costs = function(i)
            
        end
    },
    
    [11] = {
        logo = "inv-chest",
        name = "☆ Chest",
        quality = 2,
        type = 2,
        
        inside = {
            --RandomChoose(
                {10, 2, 1},
                {9, 1, 1},
                {5, 5, 1},
                {1, 20, 1},
                {6, 200, 50}
            --)
        },
        minLevel = 10,
        required = 7,
        
        canSell = true
    }
    
    
    }
    
    
    -- Level List
    level_list = {
    
    --[[
    .id – The unique identifier for every map
    !type – The type of the campaign {"default"}
    .name – The string visible for the user
    .minLevel – The minimal level for being allowed to enter the campaign.
    .dsc – Description per each total campaign
    
    #levels – All Difficulties listed
        #diff – The String for the difficulty name.
        :stages – The amount of stages and their playing
            ?map – The map of the level.
            ?bg – The Background.
            ?texture – An image white/black, to show were there is texture (For weapons to stop)
            ?destroyableTexture – Texture which can be removed, or nil
            .song – The music of the level
            .pos – Players position on start (vec2)
            .mission – String. What player has to do
            :e – Game playing
                %start – When starting the game, this will be runned.
                %check - Checked always, to announce failure, victory or continued playing
            
    
    
    . - You can change this values
    ? - You can change this values, but it might break the design
    # - Table (Nothing to change)
    : - Table, but you can change content
    ! - Do not change. It's a keyword in form of a string
    % - Function (Do what you want)
    ]]
    
    
    -- Lava Land
    {
        id = 1,
        type = "default",
        name = "Lava Land",
        minLevel = 1,
        dsc = "WiP",
        levels = {
            diff = "Basic",
            stages = {
                {
                    map = "mp-lavabridge",
                    bg = "bg-lavaland",
                    texture = "tx-lavabridge",
                    destroyableTexture = nil,
                    "Game Music One:Zero",
                    pos = vec2(50, 400),
                    mission = "[...]",
                    e = {}
                }, {
                    map = "mp-lavamountain",
                    bg = "bg-thunder",
                    texture = "tx-lavamountain",
                    destroyableTexture = nil,
                    "Game Music One:Zero",
                    pos = vec2(50, 400),
                    mission = "[...]",
                    e = {}
                }
            }--, {}
        }
    }

    }
    
    
    -- "lobby" (Lobby is also used between all pages)
    
    lobby.alert = false
    lobby.alert_data = {}
    lobby.alert_option = {}
    lobby.music = function()
        music("A Hero's Quest:Exploration", true)
    end
    
    lobby.inv = false
    lobby.invObjectShown = false
    lobby.invObject = {}
    
    -- "game"
    
    --game.currentJourney = {}
    
    -- Data
    loading = true
    loadingRequested = 0
    
    game.item = {}
    
    -- Background (bg)
    main.getItem("BkHxO7o.jpg", "bg-lavaland") --X
    main.getItem("lgNlbPq.png", "bg-mramor")
    main.getItem("mQZObpF.png", "bg-thunder")
    main.getItem("lFKui4P.png", "bg-labyrinth")
    main.getItem("rsbzqra.png", "bg-nightmare")
    main.getItem("OVf0atm.png", "bg-chinese")
    
    -- Map (mp)/ Texture (tx)
    main.getItem("TAAskpk.png", "mp-lavabridge")
    main.getItem("6anRuHC.png", "tx-lavabridge")
    
    main.getItem("jEvRVSu.png", "mp-lavamountain")
    main.getItem("AF4qjy4.png", "tx-lavamountain")
    
    main.getItem("eJdoYoT.png", "mp-spacearena")
    main.getItem("GQp9HrR.png", "tx-spacearena")
    
    -- Weapon (wp)
    main.getItem("YW8Nmn9.png", "wp-galaxy")
    main.getItem("RNNWtnj.png", "wp-galaxy-gold")
    main.getItem("P8rMCWx.png", "wp-totem")
    main.getItem("Ihj83F8.png", "wp-blade")
    main.setItem(readImage("Tyrian Remastered:Flame 1"), "wp-flame")
    main.setItem(readImage("Tyrian Remastered:Blades"), "wp-blade")
    main.setItem(readImage("Tyrian Remastered:Evil Spike"), "wp-lavis-greendrill")
    -- * boss weapon * (bwp)
    main.getItem("ed8Cahq.png", "bwp-ax")
    
    -- Enemy Graphics (e)
    main.setItem(readImage("Tyrian Remastered:Space Bug Left"), "e-bug-left")
    main.setItem(readImage("Tyrian Remastered:Space Bug Right"), "e-bug-right")
    main.setItem(readImage("Tyrian Remastered:Boss B"), "e-spaceship-blueB")
    main.setItem(readImage("Tyrian Remastered:Evil Head"), "e-lavis-head")
    --
    
    -- Other (o)
    main.getItem("zLPyoDc.png", "o-aura-star")
    main.getItem("T2ujRjP.png", "o-symbol-heart")
    main.getItem("92h9BG6.png", "o-symbol-shield")
    main.getItem("AuLOWzl.png", "o-symbol-sword")
    main.getItem("OybDTDy.png", "o-symbol-energy")
    main.getItem("WxiItkL.png", "o-symbol-power")
    
    -- Inventory (inv)
    main.getItem("XaR4vEe.png", "inv-chest")
    main.getItem("htxeuzy.png", "inv-galaxy")
    main.getItem("R3gb5QH.png", "inv-galaxy2")
    main.getItem("nKBNnwr.png", "inv-totem")
    main.getItem("uFjX6hc.png", "inv-blade")
    main.getItem("CnWXgi1.png", "inv-blade2")
    main.getItem("U98LYIn.png", "inv-bloodsphere")
    
    --[[
    Behind the images you sometimes see "--X". That means it's not my Graphic.
    ]]
    
    
    
    
    totalLoading = loadingRequested
    
    -- "user" (used to store data)
    user.inv = {}
    for x = 1, 17 do
        user.inv[x] = {}
        for y = 1, 11 do
            user.inv[x][y] = {id = 0}
        end
    end
    
    -- User gets on Start
    user.experience = 0
    user.coins = 100
    user.campaign = {
        {id=1, saved=1}
    }
    user.inv[1][11] = {id = 1, amount = 1}
    user.inv[2][11] = {id = 2, amount = 1}
    user.inv[3][11] = {id = 6, amount = 150}
    
    -- Tests
    user.inv[1][9] = {id = 7, amount = 500}
    user.inv[2][9] = {id = 11, amount = 500}
    user.inv[3][9] = {id = 8, amount = 1}
    user.inv[4][9] = {id = 10, amount = 1}
    
    -- Prepare
    lobby.music()
end

function main.draw()
    if RoomId == 0 then
        lobby.ui()
    elseif RoomId == 1 then
        game.ui()
    end
    
    if loadingRequested <= 0 then
        loading = false
    end
    
    if loading then
        resetStyle()
        fill(0, 150)
        rect(-5, -5, WIDTH+10, HEIGHT+10)
        fill(255, 255, 255, 255)
        rect(150, 150, WIDTH-300, HEIGHT-300)
        fill(127, 127, 127, 255)
        rect(150, 150, WIDTH-300, 50)
        fill(0, 200, 50, 255)
        rect(150, 150, (WIDTH-300) * ((totalLoading-loadingRequested) / totalLoading), 50)
        fill(0, 255)
        fontSize(45)
        text("Loading: " .. totalLoading-loadingRequested .. "/" .. totalLoading
        .. "  (" .. math.floor(((totalLoading-loadingRequested)/totalLoading)*100) .. "%)"
        , WIDTH/2, 175)
        
        translate(WIDTH/2, HEIGHT/2)
        rotate(os.clock() * -70)
        sprite("Space Art:Green Explosion", 0, 0, 250, 250)
        resetMatrix()
    end
end

function main.touch(t)
    if not loading then
        if RoomId == 0 then
            lobby.touch(t)
        elseif RoomId == 1 then
            game.touch(t)
        end
    end
end

function main.getItem(url, name)
    local img = readImage("Space Art:Red Explosion")
    local function s(data)
        game.item[name] = data or img
        loadingRequested = loadingRequested - 1
    end
    
    local function f(err)
        assert(false, "The package '" .. name .. "' could not be installed for this reason: " .. err)
    end
    
    http.request("https://i.imgur.com/" .. url, s, f)
    loadingRequested = loadingRequested + 1
end

function main.setItem(data, name)
    game.item[name] = data or readImage("Space Art:Red Explosion")
end

--# Main

function setup()
    displayMode(OVERLAY)
    displayMode(FULLSCREEN)
    main.setup("Worms (?)", "v0")
end

function draw()
    background(0)
    main.draw()
end

function touched(t)
    main.touch(t)
end


