
--# Player
Player = class()

function Player:init()
    self.y = HEIGHT-100
    self.x = 150
    self.speedY = 0
    self.maximalSpeed = 10
end

function Player:draw()
    sprite("Planet Cute:Character Boy", self.x, self.y)
end

function Player:gravity(gravity) -- gravity: Integer: Gravity Speed.
    if self.speedY < self.maximalSpeed then
        self.speedY = self.speedY + gravity
    end
    self.y = self.y - self.speedY
end

--# Button
Button = class()

function Button:init(t)
    self.x, self.y = t.x or 0, t.y or 0
    self.string = t.text or "Button"
    self.size = t.fontSize or 10
    self.func = t.action or function() end
end

function Button:draw()
    fontSize(self.size)
    font("Futura-CondensedMedium")
    
    fill(120, 200)
    text(self.string, self.x+2, self.y-2)
    fill(200, 220)
    text(self.string, self.x+1, self.y-1)
    fill(255)
    text(self.string, self.x, self.y)
end

function Button:touched(t)
    if t.state == BEGAN then
        fill(255)
        fontSize(self.size)
        font("Futura-CondensedMedium")
        local a, b = textSize(self.string)
        
        if t.x>self.x-a/2 and t.x<self.x+a/2 and t.y>self.y-b/2 and t.y<self.y+b/2 then
            self.func()
        end
    end
end

--# EnterPage

EnterPage = EnterPage or {}

function EnterPage.Init()
    EnterPage.Data = {}
    EnterPage.Data.Buttons = {
        Button{
            x = WIDTH/2,
            y = HEIGHT*(3/4),
            text = "Play!",
            fontSize = 100,
            action = function() Game.Start() end
        }
    }
    EnterPage.Blocks = {}
    
    for n = 1, 300 do
        EnterPage.Block()
    end
end

function EnterPage.Draw()
    local s = {}
    for a, b in ipairs(EnterPage.Blocks) do
        stroke((b.width/450)*255, 200-(b.width/450)*200 + 55)
        strokeWidth((b.width/450)*7.5)
        line(b.x, b.y, b.x + b.width, b.y)
        b.x = b.x - (b.width/450)*20
        b.y = b.y + (b.width/450)*2
        
        if b.x+b.width+10 < 0 then
            table.insert(s, a)
        end
    end
    
    local v = 0
    if #s > 0 then
        for a, b in ipairs(s) do
            EnterPage.Block()
            table.remove(EnterPage.Blocks, b-v)
            v = v + 1
        end
    end
    
    for a, b in ipairs(EnterPage.Data.Buttons) do
        b:draw()
    end
end


function EnterPage.Touched(t)
    for a, b in ipairs(EnterPage.Data.Buttons) do
        b:touched(t)
    end
end

function EnterPage.Block()
    local t = {}
    
    t.x = WIDTH + math.random(1, 100)
    t.y = math.random(-HEIGHT/2, HEIGHT)
    t.width = math.random(2, 450)
    
    table.insert(EnterPage.Blocks, #EnterPage.Blocks + 1, t)
end

--# Game

Game = Game or {}

function Game.Start()
    isPlaying = true
    Game.Init()
end

function Game.Init()
    Game.Data = {}
    Game.Data.Player = Player()
end

function Game.Draw()
    Game.Data.Player:draw()
    Game.Data.Player:gravity(1)
end

function Game.Touched(t)
    
end


--# Main

function setup()
    supportedOrientations(LANDSCAPE_ANY)
    displayMode(OVERLAY)
    displayMode(FULLSCREEN)
    isPlaying = false
    EnterPage.Init()
    Game.Init()
end

function draw()
    background(0)
    resetStyle()
    if isPlaying then
        Game.Draw()
    else
        EnterPage.Draw()
    end
end

function touched(t)
    if isPlaying then
        Game.Touched(t)
    else
        EnterPage.Touched(t)
    end
end
