
--# Main

displayMode(FULLSCREEN)

function setup()
    k = KeyBoard()
    k.visible = true
end

function draw()
    background(0, 0, 0, 255)
    k:draw()
end

function touched(t)
    k:touched(t)
end

--# KeyBoard
KeyBoard = class()

function KeyBoard:init()
    -- You can accept and set parameyers here
    -- To make the key visible if you have in setup "k = KeyBoard()" then use "k.visible = true"
    self.visible = false
    self.textSize = 25
    self.xy = 68
    self.letters = {"1","z","a","q","2","x","s","w","3","c","d","e","4","v","f","r","5","b","g","t","6","n","h","y","7","m","j","u","8", ",","k","i","9",".","l", "o", "0", "!","?","p","_",'"',"(","BCK",";","/",")","RET"}
    self.positions = {}
end

function KeyBoard:draw()
    local n = 0
    if self.visible then
        for x = 1, 12 do
            self.positions[x] = {}
            for y = 1, 4 do
                n = n + 1
                fill(255, 255, 255, 255)
                rect(x * self.xy + self.xy/2, y * self.xy + self.xy/2, self.xy, self.xy)
                fill(0, 0, 0, 255)
                if self.bolden then font("Arial-BoldMT") else font("ArialMT") end
                fontSize(self.textSize)
                text(self.letters[n], x * self.xy + self.xy, y * self.xy + self.xy)
            end
        end
    end
end

function KeyBoard:touched(t)
    if self.visible then
        local n = 0
        for x = 1, 12 do
            self.positions[x] = {}
            for y = 1, 4 do
                n = n + 1
                local y = y
                if t.x>self.xy*x+self.xy/2 and t.x<self.xy*x+self.xy*1.5 and t.y>self.xy*y+self.xy/2 and t.y<self.xy*y+self.xy*1.5 and t.state == BEGAN then
                    print(self.letters[n])
                end
            end
        end
    end
end
