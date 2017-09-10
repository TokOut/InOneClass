-- Uno

function setup()
    displayMode(OVERLAY)
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    reset()
end

function reset()
    Cards = {}
    Colors = {
        -- Name, Col
        {"red", color(220, 0, 0)},
        {"green", color(0, 220, 0)},
        {"blue", color(0, 0, 220)},
        {"yellow", color(220, 220, 0)}
    }
    
    for sameCards = 1, 4 do -- Too repeat
        -- Numeric
        for n = 1, 10 do
            for a, b in ipairs(Colors) do
                table.insert(Cards, b[1] .. "_" .. (n-1))
            end
        end
        for a, b in ipairs(Colors) do
            table.insert(Cards, b[1] .. "_take2")
            table.insert(Cards, b[1] .. "_skip")
            --table.insert(Cards, b[1] .. "_switch")
        end
        table.insert(Cards, "special_take4")
        table.insert(Cards, "special_select")
    end
    
    while true do
        if PlacedCards == nil then
            PlacedCards = {Cards[math.random(1, #Cards)]}
        elseif string.sub(PlacedCards[1], 1, #"special") == "special" then
            PlacedCards = {Cards[math.random(1, #Cards)]}
        elseif string.find(PlacedCards[1], "_take2") or string.find(PlacedCards[1], "_skip") then
            PlacedCards = {Cards[math.random(1, #Cards)]}
        else
            break
        end
    end
    Selected4 = ""
    
    Given = {
        {},
        {}
    }
    GiveCards(1, 7) -- Myself
    GiveCards(2, 7) -- Computer
end

function GiveCards(whome, amount)
    for n = 1, amount do
        if #Cards > 1 then
            local n = math.random(1, #Cards)
            table.insert(Given[whome], Cards[n])
            --print("User '" .. whome .. "' received '" .. Cards[n] .. "'") -- Print all cards received
            table.remove(Cards, n)
        elseif #Cards == 1 then
            table.insert(Given[whome], Cards[1])
            Cards = {}
        end
    end
end

function draw()
    background(0)
    sprite("Project:Background2", WIDTH*.5, HEIGHT*.5, WIDTH, HEIGHT)
    resetStyle()
    
    -- Show your Cards
    for a, b in ipairs(Given[1]) do
        local x = a * 75
        display(x, 50, 70, 100, b)
    end
    
    for a, b in ipairs(Given[2]) do
        --[[fill(127)
        stroke(127)
        strokeWidth(5)
        rect(WIDTH- 75*a -35, HEIGHT-150, 70, 100)]]
        local x = a * 75
        display(WIDTH-x, HEIGHT-150, 70, 100, b)
    end
    
    for a, b in ipairs(PlacedCards) do
        if a == #PlacedCards then
            display(WIDTH/2, HEIGHT/2-75, 105, 150, b)
        end
    end
    
    resetStyle()
    fill(255, 150)
    rect(25, HEIGHT/2-75, 105, 150)
    fill(0)
    fontSize(50)
    text("Take", 77.5, HEIGHT/2)
end

function display(x, y, w, h, card)
    --[[if type(PlacedCards) == "table" then
        for a, b in ipairs(PlacedCards) do
            print(a, b)
        end
    end]]
    if string.sub(card, 1, #"special") == "special" then
        stroke(127)
        strokeWidth(0)
        fill(Colors[1][2])
        rect(x-35, y, w/2, h/2)
        fill(Colors[2][2])
        rect(x-35+w/2, y, w/2, h/2)
        fill(Colors[3][2])
        rect(x-35+w/2, y+h/2, w/2, h/2)
        fill(Colors[4][2])
        rect(x-35, y+h/2, w/2, h/2)
            
        if string.sub(card, #"special_" + 1, #card) == "take4" then
            fill(255)
            font("ArialMT")
            fontSize(math.min(w, h)*.4)
            text("+4", x-35 + w*.25, y + h*.75)
            text("+4", x-35 + w*.75, y + h*.27)
        --[[elseif string.sub(card, #"special_" + 1, #card) == "select" then
            fill(0)
            font("ArialMT")
            fontSize(h)
            text("S", x-35+w/2, y+h/2)]]
        end
    else
        fill(255)
        for c, d in ipairs(Colors) do
            if string.sub(card, 1, #d[1]) == d[1] then
                fill(d[2])
                stroke(127)
                strokeWidth(5)
                rect(x-35, y, w, h)
                    
                if string.sub(card, #d[1] + 2, #card) == "skip" then
                    fill(0, 0)
                    ellipse(x-35+w/2, y + h/2, math.min(w, h))
                    translate(x-35+w/2, y+h/2)
                    rotate(45)
                    line(-math.min(w, h)/2+5, 0, math.min(w, h)/2-5, 0)
                    resetMatrix()
                elseif string.sub(card, #d[1] + 2, #card) == "take2" then
                    fill(0)
                    font("ArialMT")
                    fontSize(math.min(w, h)*.4)
                    text("+2", x-35 + w*.33, y + h*.66)
                    text("+2", x-35 + w*.66, y + h*.33)
                else
                    fill(0)
                    font("ArialMT")
                    fontSize(h)
                    text(string.sub(card, #d[1] + 2, #card), x-35+w/2, y + h/2)
                end
                break
            end
        end
    end
end

function Place(card)
    -- Change Card
    if card then
        table.insert(PlacedCards, #PlacedCards + 1, card)
        
        local r = card
        if string.sub(r, 1, #"special") == "special" then
            Selected4 = Colors [math.random(1, #Colors)]
            if string.sub(r, #"special" + 1, #r) == "take4" then
                GiveCards(2, 4)
            elseif string.sub(r, #r - #"skip", #r) == "skip" then
                return
            end
        else
            if string.sub(r, #r - #"take2", #r) == "take2" then
                GiveCards(2, 2)
            end
        end
        
        for a, b in ipairs(Given[1]) do
            if b == card then
                table.remove(Given[1], a)
                break
            end
        end
    else
        GiveCards(1, 1)
    end
    
    -- Bot
    ::bot::
    
    local v = {}
    for a, b in ipairs(Given[2]) do
        if canPlace(b) then
            table.insert(v, b)
        end
    end
    
    --print(#v)
    local r
    if #v == 0 then
        GiveCards(2, 1)
    elseif #v == 1 then
        table.insert(PlacedCards, #PlacedCards + 1, card)
        
        for a, b in ipairs(Given[2]) do
            if b == v[n] then
                table.remove(Given[2], a)
                return
            end
        end
        
        r = v[n]
    else
        local n = math.random(1, #v)
        table.insert(PlacedCards, #PlacedCards + 1, v[n])
        
        for a, b in ipairs(Given[2]) do
            if b == v[n] then
                table.remove(Given[2], a)
                break
            end
        end
        
        r = v[n]
    end
    
    if r then
        if string.sub(r, 1, #"special") == "special" then
            Selected4 = Colors [math.random(1, #Colors)]
            if string.sub(r, #"special" + 1, #r) == "take4" then
                GiveCards(1, 4)
            end
        else
            if string.sub(r, #r - #"take2", #r) == "take2" then
                GiveCards(1, 2)
            elseif string.sub(r, #r - #"skip", #r) == "skip" then
                goto bot
            end
        end
    end
end

function canPlace(card)
    for a, b in ipairs(Colors) do
        -- Same Color
        if string.sub(PlacedCards[#PlacedCards], 1, #b[1]) == string.sub(card, 1, #b[1]) then
            return true
        end
        
        -- Same Digit
        if b[1] == string.sub(card, 1, #b[1]) then
            --[[if string.sub(PlacedCards[#PlacedCards], ???) == string.sub(card, #b[1]+2, #b[1]+2) then
                return true
            end]]
            for c, d in ipairs(Colors) do
                --print(d[1] .. ", " .. card)
                --print(string.sub(d[1], #d[1] + 1, #d[1] + 1) .. ", " .. string.sub(card, #card, #card))
                if string.sub(PlacedCards[#PlacedCards], #d[1]+2, #d[1]+2) == string.sub(card, #card, #card) then
                    return true
                end
            end
        end
    end
    
    -- Special 4Color Card
    if string.sub(card, 1, #"special") == "special" then
        return true
    end
    
    return false
end

function touched(t)
    for a, b in ipairs(Given[1]) do
        local x = a * 75
        --rect(x-35, 50, 70, 100)
        if t.x>x-35 and t.x<x+35 and t.y>50 and t.y<150 and t.state == ENDED then
            if canPlace(b) then
                Place(b)
            end
        end
    end
    
    --rect(25, HEIGHT/2-75, 105, 150)
    if t.x>25 and t.x<80 and t.y>HEIGHT/2-75 and t.y<HEIGHT/2+75 and t.state == ENDED then
        Place(nil)
    end
end
