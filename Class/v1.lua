
--# To_Do
-- To-Do
-- Author: @tokout
-- Content:
--[[

* Json *
- Add Html coding
- Fix Image coding
- Fix class coding

* Colors *
- ...

* Math *
- Fix random function with float numbers.
- Fix random function.
- Add calculation for different systems.

* Draw *
- Add more Objects
- Fix Randomated Alert - Buttons
- Add Protection Lock

]]
--# Colors
-- Name: Colors
-- Short: Color
-- Author: @tokout
-- Content:
--[[
    Color.random -- Like math random, for ex.: between colors c(1, 1, 50, 255) and c(250, 150, 25, 255)
    Color.oposite -- Returns the oposite rgba color.
    Color.tostring -- Returns a string version of the color.
]]

Color = class()

Color.random = function(col1, col2)
    local r, g, b, a
    -- If col1 is not given use default values
    if col1 == nil then
        col1 = color(0, 0)
        col2 = color(255, 255)
    end
    -- If col2 is not given col1 is maximal value
    if col2 == nil then
        col2 = col1
        col1 = color(0, 0, 0, 0)
    end
    -- Red
    if col1.r == col2.r then
        r = col1.r
    else
        if col1.r < col2.r then
            r = math.random(col1.r, col2.r)
        else
            r = math.random(col2.r, col1.r)
        end
    end
    -- Green
    if col1.g == col2.g then
        g = col1.g
    else
        if col1.g < col2.g then
            g = math.random(col1.g, col2.g)
        else
            g = math.random(col2.g, col1.g)
        end
    end
    -- Blue
    if col1.b == col2.b then
        b = col1.b
    else
        if col1.b < col2.b then
            b = math.random(col1.b, col2.b)
        else
            b = math.random(col2.b, col1.b)
        end
    end
    -- Alpha
    if col1.a == col2.a then
        a = col1.a
    else
        a = math.random(col1.a, col2.a)
    end
    return color(r, g, b, a)
end

Color.oposite = function(col)
    if col == nil then col = color(math.random(255), math.random(255), math.random(200)) end
    col = color(255 - col.r, 255 - col.b, 255 - col.g, 255 - col.a)
    return col
end

Color.tostring = function(col)
    if col == nil then col = color(0, 255) end
    local showAlpha = true
    local isGray = false
    local str = "color"
    if col.a == 255 then
        showAlpha = false
    end
    if col.r == col.g and col.b == col.g and col.r == col.b then
        showGray = true
    end
    str = str .. "(" -- Methodes began
    if showGray then
        str = str .. col.r
        if showAlpha then
            str = str .. ", " .. col.a
        end
    else
        str = str .. col.r .. ", " .. col.g .. ", " .. col.b
        if showAlpha then
            str = str .. ", " .. col.a
        end
    end
    str = str .. ")" -- Methodes ended
    
    return str
end

--# Json
-- Name: Json
-- Short: oc => Objects Coding
-- Author: @tokout
-- Content:
--[[
    oc.table.encode -- Encodes table to string.
       >> NOTES >> Do not call nil from a direct position. Call nil from a function's return. Do not create inner tables currently please.
    oc.table.decode -- Decodes string to table.
       >> NOTES >> The table will automatically sort strings first, following numbers, and later nothing special.
    oc.table.reverse -- Will reverse all table items.
    oc.table.merge -- Will merge many tables into one big, where the outer brackets will be removed.
    oc.table.find -- Two arguments: Table (with String values only); String, to find in table
]]

oc = class()

-- Normal table coding
oc.table = {}

oc.table.encode = function(tab, format)
    local str = ""
    local format = format or {} -- If format is nil, it will stay as a table.
    if format.newline == nil then format.newline = false end
    if format.newtable == nil then format.newtable = true end
    --[[
        format includes - (default, function)
        .newline = boolean (false, formats with new lines)
        .newtable = boolean (true, if another table is in it, should it be encoded again?)
    ]]
    
    for a, b in ipairs(tab) do
        -- Start the table
        if a == 1 then
            if format.newline then
                str = str .. "\n"
            end
            str = str .. "{"
            if format.newline then
                str = str .. "\n  "
            end
        end
        -- Encode
        if type(b) == "string" then
            b = b:gsub("'", "")
            str = str .. "'" .. b .. "'"
        elseif type(b) == "number" then
            str = str .. b
        elseif type(b) == "table" then
            if format.newtable then
                str = str .. oc.table.encode(b, format)
            else
                str = str .. "table(" .. a .. ")"
            end
        elseif type(b) == "userdata" then
            str = str .. "img(" .. a .. ")" -- .. oc.image.encode(b)
        elseif type(b) == "boolean" then
            if b == true then
                str = str .. "true"
            elseif b == false then
                str = str .. "false"
            end
        elseif type(b) == "function" then
            local d = b()
            --print(type(d))
            if type(d) == "nil" then
                str = str .. "nil"
            elseif type(d) == "boolean" then
                if d then
                    str = str .. "true"
                else
                    str = str .. "false"
                end
            elseif type(d) == "string" then
                str = str .. "'" .. d .. "'"
            elseif type(d) == "number" then
                str = str .. d
            end
        else
            assert(false, "Not permitted encode type '" .. type(b) .. "' at table position " .. a)
        end
        --
        if a == #tab then
            if format.newline then
                str = str .. "\n"
            end
            str = str .. "}"
            if format.newline then
                str = str .. "\n"
            end
        else
            
            str = str .. ", "
        end
    end
    if string.sub(str, #str, #str) ~= "}" then -- The table is brocken
        assert(false, "Table contains direct nil values. This is not supported.\nDo this:\n\n" ..
        [[
        { ... , 
        function()
            return nil
        end }
        , ...
        ]] .. "\n\nNot this:\n\n" ..
        [[
        { ... ,
        nil
        , ... }
        ]])
    end
    
    --[[for a, b in pairs(tab) do
        if type(a) ~= "number" then
            str = str .. "; " .. a .. "{" .. b .. "}"
        end
    end]]
    
    return str
end

oc.table.decode = function(str)
    if type(str) == "string" then else
        assert(false, "Wrong argument #1 in oc.table.decode (string expected, got " .. type(str) .. ")")
    end
    local tab = {}
    str = "," .. string.sub(str, 2, #str-1) .. ","
    --[[for a in string.gmatch(str, "{.+}") do
        print(a) -- NEED HELP ENCODING
    end]]
    
    for a in string.gmatch(str, "'.-'") do -- Strings
        table.insert(tab, a)
        str = str:gsub(a, "")
    end
    
    for a in string.gmatch(str, ",%s?,") do
        str = str:gsub(" ", "") -- After strings were encoded, we shall remove any existing spaces.
    end
    
    for a in string.gmatch(str, ",%-?%d-,") do -- Integer Numbers
        a = string.sub(a, 2, #a-1)
        if a ~= "" then
            table.insert(tab, a)
            str = str:gsub(a, "")
        end
    end
    
    for a in string.gmatch(str, ",%-?%d-%p%d-,") do -- Float Numbers
        a = string.sub(a, 2, #a-1)
        if a ~= "" and a ~= "," then
            table.insert(tab, a)
            str = str:gsub(a, "")
        end
    end
    
    for a in string.gmatch(str, ",.-,") do
        a = a:gsub(",", "")
        --a = string.sub(a, 2, #a-2)
        --table.insert(tab, a)
        if a ~= "" then
            table.insert(tab, a)
        end
    end
    
    return tab
end

oc.table.reverse = function(tab)
    local t = {}
    if tab == nil then
        tab = {}
    end
    local n = #tab
    while #t < n do
        for a, b in ipairs(tab) do
            if a == #tab then
                table.remove(tab, a)
                table.insert(t, b)
            end
        end
    end
    return t
end

oc.table.merge = function(...)
    local arg = {...}
    local tab = {}
    for a = 1, #arg do
        if type(arg[a]) == "table" then
            local d = arg[a]
            for c = 1, #d do
                table.insert(tab, #tab + 1, arg[a][c])
            end
        else
            table.insert(tab, #tab + 1, arg[a])
        end
    end
    return tab
end

oc.table.find = function(tab, str)
    local t = {}
    for a = 1, #tab do
        if string.sub(tab[a], 1, #str) == str then
            table.insert(t, #t + 1, tab[a])
        end
    end
    return t
end

--[[NOT WORKING, but why? // K, pairs are randomed

oc.class = {}

oc.class.encode = function(cls)
    str = ""
    -- Encoding class
    str = str .. "{"
    for a, b in pairs(cls) do
        str = str .. a .. "="
        if type(b) == "string" then
            str = str .. "'" .. b .. "'"
        elseif type(b) == "number" then
            str = str .. b
        elseif type(b) == "boolean" then
            if b then
                str = str .. "true"
            else
                str = str .. "false"
            end
        elseif type(b) == "function" then
            local d = b()
            if type(d) == "string" then
                str = str .. "'" .. d .. "'"
            elseif type(d) == "number" then
                str = str .. d
            elseif type(d) == "boolean" then
                if d then
                    str = str .. "true"
                else
                    str = str .. "false"
                end
            --[[else {{YOU SHOULD JUST IFNORE THAT INFO}}
                assert(false, type(d) .. " is not supported as a return from the function oc.class.encode")]
            end
        --[[else {{YOU SHOULD JUST IGNORE THAT INFO}}
            assert(false, type(b) .. "is not supported in function oc.class.encode")]
        end
        str = str .. ","
    end
    str = string.sub(str, 1, #str-2) .. "}" -- Remove last comma, and add brackets closing.
    -- Returning string
    return str
end

oc.class.decode = function(str)
    local tab = {}
    str = "," .. string.sub(str, 2, #str-1) .. ","
    
     print(str) -- Works Currently
    
    for a in string.gmatch(str, ",.-=.-,") do
        print(a)
    end
    
    return tab
end ]]



--[[ NOT WORKING, BECAUSE OF LARGE IMAGES, AND LARGE STRING
oc.image = {}

oc.image.encode = function(img)
    local str = "img"
    local w, h = spriteSize(img)
    for x = 1, w do
        str = str .. "{"
        for y = 1, h do
            str = str .. "{"
            local r, g, b, a = img:get(x, y)
            str = str .. "col[" .. r .. ", " .. g .. ", " .. b .. ", " .. a .. "]"
            str = str .. "}"
        end
        if x == w then
            str = str .. "}"
        else
            str = str .. "}\n"
        end
    end
    return str
end]]



--# Library
-- Name: Library
-- Author: @tokout
-- Content:
--[[
    Math.checksum -- Between many numbers, there will be their checksum given away. Support for tables
    WRONG: Math.random -- Newer mathematical random system. Support for float numbers. Takes it directly from time, so you will get an upcomming number module, so the number will be just going + 1, not randomized.
    Math.system -- Transfroms a number to another system, as default 2 (binary)
    String.random -- Creates random symbols. Arguments: (allowedSymbols, stringLength)
]]

Math = class()
String = class()

-- MATH --

Math.checksum = function(...)
    local arg = {...}
    local n = #arg -- As default, for any non numbers we will remove it.
    if n == 0 then
        return nil -- If we don't have values, we will return nothing.
    elseif n == 1 then
        local t = arg[1]
        if type(t) == "table" then
            local n = #t
            local f = 0
            for a, b in ipairs(t) do
                if type(b) == "number" then
                    f = f + b
                elseif type(b) == "table" then
                    f = f + Math.checksum(b)
                end
            end
            f = f / n
            return f
        elseif type(t) == "number" then
            return t -- We will return the only number we have received.
        elseif type(t) == "string" then
            t = math.tointeger(t) -- We should make the string to a number.
            return t
        else
            assert(false, "Bad argument in Math.checksum (Table or number expected, got " .. type(t) .. ")") -- We can't do anything with a function or userdata.
        end
    else
        local d = 0
        for a, b in ipairs(arg) do
            if type(b) == "table" then
                b = Math.checksum(b)
            elseif type(b) == "string" then
                b = math.tointeger(b)
            elseif not (type(b) == "number") then
                -- We will only ignore it.
                b = 0
                n = n - 1
            end
            d = d + b
        end
        d = d / n
        return d
    end
end

Math.random = function(a, b)
    -- If something is not given, use default values.
    if a == nil then
        a = 0
        b = 1
    elseif b == nil then
        a = 1
        b = a
    end
    if a == b then
        return a -- Because a is b, we can't get a random number
    else
        local x = 0
        local y = 0
        
        -- Restart till integer is given
        while math.type(a) == "float" do
            x = x + 1
            a = a * 10
            local d = a .. ""
            print(a, string.sub(d, #d-1, #d))
            if string.sub(d, #d-1, #d) == ".0" then
                a = math.tointeger(a)
            end
        end
        
        while math.type(b) == "float" do
            y = y + 1
            b = b * 10
            local d = b .. ""
            print(b, string.sub(d, #d-1, #d))
            if string.sub(d, #d-1, #d) == ".0" then
                b = math.tointeger(b)
            end
        end
        
        while not (x == y) do
            if x > y then -- ax > by
                y = y + 1
                b = b * 10
            elseif x < y then -- ax < by
                x = x + 1
                a = a * 10
            end
        end
        
        -- Get Positive Difference
        if a > b then
            local c = a -- Like copy/paste
            a = b
            b = c -- Previous "a"
        end
        
        -- Get Number Difference
        local distance = 0
        distance = b - a
        
        -- Get random number
        local n
        if x == 0 or y == 0 then
            distance = distance + 1
            n = math.ceil((os.clock() * 6)%distance) + a
        else
            n = math.floor(math.ceil((os.clock() * 6)%distance)/x) + a
        end
        
        return n
    end
end

-- Not working

Math.system = function(num, sys)
    -- Symbol position for larger encodes
    local code = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    -- Function
    if not (type(num) == "number") then
        num = 0
        assert(false, "bad argument #1 in Math.system (integer expected, got " .. type(num) .. ")")
    end
    if sys == nil then
        sys = 2 -- Binary -> 0, 1
    end
    if sys <= 1 then
        assert(false, "Not supported mathematical system. Minimal binary (2)")
    end
    if (math.type(num) == "float") or (math.type(sys) == "float") then
        assert(false, "Number is float. Integer expected")
    end
    -- Encoding
    num = num .. "" -- Made to string
    numbers = {}
    for a = 1, #num do
        local d = string.sub(num, #num - (a-1), #num - (a-1)) * 10 ^ (a-1)
        table.insert(numbers, num)
    end
    for a, b in ipairs(numbers) do
        --numbers[a] = b * 10
        -- HOW TO CALCULATE DIFFERENT SYSTEMS?
    end
    
    assert(false, "Not supported function. This version does not support the function.")
    return "Error: Modiefing numbers currently not possible."
end

-- STRING --

--[[This function requires 0 arguments. As default 2.
    String.random() -- Returns random generated string
    String.random(length) -- Returns a string with 'length' symbols
    String.random(length, symbols) -- Gives a random string with 'length' symbols, and only 'symbols' letters

    Ex.:
    String.random(15) -- afjobdu-gyn_thd
    String.random(10, "1234567890") -- 7202582615
]]

String.random = function(length, allowedSymbols)
    local t = {}
    local str = ""
    
    -- Default
    if (allowedSymbols == nil) or (allowedSymbols == "") then
        allowedSymbols = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_"
    end
    if (length == nil) or (length <= 0) then
        length = 100 -- Length should be required, you can use string.sub to get the sub-text for one of it's parts.
    end
    
    -- Function
    
    for a = 1, string.len(allowedSymbols) do
        table.insert(t, 1, string.sub(allowedSymbols, a, a))
    end
    
    for b = 1, length do
        if #t == 1 then
            str = str .. t[1] -- We will use the only existing symbol, to avoid math.random crashes
        else
            str = str .. t[math.random(1, #t)]
        end
    end
    
    return str
end


--# Draw
-- Name: Draw
-- Author: @tokout
-- Content:
--[[
    RoundRect -- Beatiful Rounded Rect
    >> BorderRadius -- Sub-function -- Set or get border radius.
    >> BorderDisplay -- Sub-function -- Show border. Not supported curently.

    Alert - CLASS -- It's a class based on beatiful UI Alert.
    Alert.Open -- Opens an alert. [Arguments: text and title] [text is allowed to have html]

    Protect - CLASS -- It requires one password to do smt. (There can be only one per page.)
]]

-- Alert Notes
--[[
    If you want to use Alert please do following:
    
    Place 'Alert.Init()' in function setup [Not nesessary]
    Place 'Alert.Draw()' in function draw [Nesessary]
    Place 'Alert.Touch(touch)' in function touched(touch) [Nesessary]
    Disable any methodes in function touched(touch) with 'DRAW.alert' like this:
    
    if DRAW.alert then
        Alert.Touch( touch )
    else
        -- Default Methodes
    end
]]

-- Protect Notes
--[[
    If you want to protect something plase do the following:
    
    Place 'Protect.Init()' in function setup
    Place 'Protect.Draw()' in function draw
    Place 'Protect.Touch(t)' in function touched(t)
    Disable any methodes in function touched(touch) with 'Protect.PassWordEnter' like this:
    
    if Protect.PassWordEnter then
        
    else
        -- Default Methodes
    end
]]

DRAW = {}
DRAW.RoundBorder = 0 -- Default. You can reset it with the BorderRadius Function
DRAW.hasBorder = false -- Default. You can reset it with the BorderDisplay Function. Not supported: wrong formula!
DRAW.blur = 0
DRAW.alert = false

RoundRect = function(x, y, w, h)
    -- Get old data
    local col = color(fill()) -- We should get a color format from the unpacked fill
    local str = color(stroke()) -- We should get a color format from the unpacked stroke
    local strW = strokeWidth()
    -- Get border radius
    local border = DRAW.RoundBorder
    
    if DRAW.hasBorder then
        -- Round stroke old "x" and "y"
        -- Calculate exact border position
        local b = border + 4
        local x = x + b/4
        local y = y + b/4
        local w = w - b/2
        local h = h - b/2
        fill(str)
        stroke(str)
        strokeWidth(border)
        line(x, y, w + x, y)
        line(x, y, x, y + h)
        line(x + w, y, x + w, y + h)
        line(x, y + h, x + w, y + h)
    end
    
    -- Calculate exact border position
    x = x + border/2
    y = y + border/2
    w = w - border
    h = h - border
    
    -- Set data
    fill(col)
    stroke(col)
    strokeWidth(0)
    
    -- Rect
    rect(x, y, w, h)
    
    -- Round border
    strokeWidth(border)
    line(x, y, w + x, y)
    line(x, y, x, y + h)
    line(x + w, y, x + w, y + h)
    line(x, y + h, x + w, y + h)
    
    -- Reset data
    fill(col)
    stroke(str)
    strokeWidth(strW)
end

BorderRadius = function(data)
    if data == nil then
        return DRAW.RoundBorder
    else
        DRAW.RoundBorder = data
        -- return data -- We shall not return anything
    end
end

BorderDisplay = function(data)
    if data == nil then
        return DRAW.hasBorder
    else
        DRAW.hasBorder = data
    end
end

--[[
Alerts - are an easy way to show permissions
]]

Alert = class()

function Alert.Init()
    Alert.Title = "Alert"
    Alert.Content = "Body"
    Alert.Buttons = {
    Cancel = function() Alert.Kill("Alert has been cancelled.") end,
    Test = function() end
    }
end

function Alert.Draw()
    if DRAW.alert then
        local a = BorderRadius()
        local b = fill()
        local c = font()
        local d = fontSize()
        local s = textWrapWidth()
        
        -- Background Light
        fill(0, 100)
        rect(-1, -1, WIDTH+2, HEIGHT+2)
        
        -- Container
        BorderRadius(15)
        fill(255, 255, 255, 255)
        RoundRect(125, 125, WIDTH-250, HEIGHT-250)
        
        -- Close Button
        local n = 0
        for a, b in pairs(Alert.Buttons) do
            local red = {"Cancel", "Exit", "Dismiss", "Discard", "Remove", "Disallow", "Forbid", "Skip", "Forget"}
            local green = {"OK", "Ok", "ok", "Agree", "Allow", "Continue"}
            fill(255, 255, 255, 255)
            font("ArialRoundedMTBold")
            RoundRect(WIDTH-250 - n*225, -5, 200, 70)
            fontSize(32)
            fill(0, 100, 255, 255)
            for c, d in ipairs(red) do
                if d == a then
                    fill(255, 0, 0, 255)
                end
            end for c, d in ipairs(green) do
                if d == a then
                    fill(0, 150, 0, 255)
                end
            end
            text(a, WIDTH-150 - n*225, 30)
            n = n + 1
        end
        
        -- Title
        font("Arial-BoldMT")
        fontSize(50)
        fill(255, 255, 255, 255)
        text(Alert.Title, WIDTH/2, HEIGHT-75)
        
        -- ***** Content ***** [[
        local n = Alert.translate(Alert.Content)
        --print(json.encode(n))
        local v = 0
        for c = 1, #n do
            textWrapWidth(WIDTH-240)
            fill(0, 0, 0, 255)
            font("ArialMT")
            fontSize(20)
            local e, r = textSize(n[c])
            text(n[c], WIDTH/2, HEIGHT-150 - v - e/2)
            v = v + e
        end
        
        -- ***** Content ***** ]]
        
        BorderRadius(a)
        fill(b)
        font(c)
        fontSize(d)
        textWrapWidth(s)
    end
end

function Alert.Touch(t)
    if DRAW.alert then -- For a doubled secure of use
        if t.state == ENDED and t.y < 60 then
            local n = 0
            for a, b in pairs(Alert.Buttons) do
                if t.x > WIDTH-250 - n*255 and t.x < WIDTH-50 - n*255 then
                    b()
                    --return -- Exit function
                end
                n = n + 1
            end
        end
    else
        print("not DRAW.alert")
    end
end

function Alert.Open(txt, title, buttons)
    DRAW.alert = true
    Alert.Title = title or "Alert"
    Alert.Content = txt or "Null"
    if type(buttons) == "table" then
        Alert.Buttons = buttons
    else
        Alert.Buttons = {
            Cancel = function() Alert.Kill("Alert has been cancelled.") end
        }
    end
end

function Alert.translate(str)
    local n = {}
    
    local d, c = string.find(str, "<.->")
    --print(d, c) START/END
    
    if d and c then -- We have formatting tags
        if d == 1 then -- The tags are written on start
            
        else -- "else"
            local r = string.sub(str, 1, d-1)
            table.insert(n, 1, r)
            str = str:gsub(r, "")
            -- print(r) -- Works with the first text
        end
    else -- We don't have any tags.
        table.insert(n, str)
    end
    
    return n
end

function Alert.Kill(reason)
    print("Alert.Kill( reason )\n\nreason : '" .. reason .. "'\n\n" .. "in class 'Draw'")
    DRAW.alert = false
end

Protect = class()

function Protect.Init(...)
    Protect.Code = {...}
    Protect.PassWordEnter = true
    local b = {
    {0, 0, 0},
    {7, 8, 9},
    {4, 5, 6},
    {1, 2, 3}
    }
    Protect.Tab = {}
    Protect.TouchTab = {}
    for x = 1, 3 do
        Protect.Tab[x] = {}
        Protect.TouchTab[x] = {}
        for y = 1, 4 do
            Protect.Tab[x][y] = b[y][x]
            Protect.TouchTab[x][y] = 0
        end
    end
    Protect.Input = {}
    
    Protect.Ani = {}
    Protect.Ani.Y = 0
    Protect.Ani.YChange = false
    Protect.Ani.ended = false
    
    Protect.EndAni = {}
    Protect.EndAni.Alpha = 255
    Protect.EndAni.AlphaChange = false
    
    Protect.Tries = 3
    Protect.Blocked = false
    Protect.BlockedAtTime = 0
    Protect.AlreadyBlocked = 0
    
    Protect.StartAnimation() -- As our welcome animation
    Protect.Ani.Y = -HEIGHT
    Protect.Ani.ended = true
    Protect.Tries = Protect.Tries + 1 -- For our security
end

function Protect.Draw()
    if Protect.PassWordEnter then
        local a = BorderRadius()
        local b = fill()
        local c = fontSize()
        local d = font()
        local e = strokeWidth()
        local f = stroke()
        
        -- Container
        translate(0, Protect.Ani.Y)
        strokeWidth(0)
        BorderRadius(25)
        fill(150, Protect.EndAni.Alpha)
        RoundRect(WIDTH/4, HEIGHT/4, WIDTH/2, HEIGHT/2)
        
        -- Container-Inner
        fill(255, 255, 255, Protect.EndAni.Alpha)
        rect(WIDTH/4, HEIGHT/4 + 35, WIDTH/2, HEIGHT/2 - 70)
        
        -- Title
        fill(0, 0, 0, Protect.EndAni.Alpha)
        font("Arial-BoldMT")
        fontSize(35)
        text("Protected", WIDTH/2, HEIGHT/4 + HEIGHT/2 - 17.5)
        
        -- Buttons
        fontSize(35 * Protect.EndAni.Alpha/255)
        for x = 1, 3 do
            for y = 1, 4 do
                if Protect.EndAni.Alpha >= 0 then
                    strokeWidth(3 * Protect.EndAni.Alpha/255)
                    stroke(0, 100, 255, 255)
                    fill(Protect.EndAni.Alpha, Protect.EndAni.Alpha)
                    if Protect.TouchTab[x][y] == 1 then
                        fill(127, 127, 127, Protect.EndAni.Alpha)
                    end
                    rect(WIDTH/4+((WIDTH/2)/3)*(x-1),HEIGHT/4+35+((HEIGHT/2-70)/4)*(y-1),
                                                                                    (WIDTH/2)/3,(HEIGHT/2-70)/4)
                    if y == 1 then
                        rect(WIDTH/4,HEIGHT/4+35+((HEIGHT/2-70)/4)*(y-1),WIDTH/2,(HEIGHT/2-70)/4)
                        fill(0, 100, 255, Protect.EndAni.Alpha)
                        text("0", WIDTH/2, HEIGHT/4+35+((HEIGHT/2-70)/4)*(y-.5))
                    else
                        fill(0, 100, 255, Protect.EndAni.Alpha)
                        text(Protect.Tab[x][y], WIDTH/4+((WIDTH/2)/3)*(x-.5), HEIGHT/4+35+((HEIGHT/2-70)/4)*(y-.5))
                    end
                end
            end
        end
        
        -- Input
        local g = ""
        for a, b in ipairs(Protect.Input) do
            g = g .. b
        end
        fill(0, 0, 0, Protect.EndAni.Alpha)
        fontSize(25)
        font("ArialMT")
        local c,_ = textSize(g)
        text(g, WIDTH/4 + c/2 + 10, HEIGHT/4+17.5)
        
        -- Tries count
        fill(135, 29, 29, Protect.EndAni.Alpha)
        font("CourierNewPS-BoldMT")
        local r = Protect.Tries .. "!"
        local g,_ = textSize(r)
        text(r, WIDTH/4 + WIDTH/2 - g/2 - 10, HEIGHT/4+17.5)
        
        translate(0, -Protect.Ani.Y)
        
        if Protect.Blocked then
            fill(0)
            strokeWidth(0)
            rect(-1, -1, WIDTH+2, HEIGHT+2)
            fill(255, 0, 0, 255)
            fontSize(50)
            font("MarkerFelt-Thin")
            text("Forbidden", WIDTH/2, HEIGHT - HEIGHT/7)
            fontSize(35)
            font("Noteworthy-Light")
            text("You have tried too many times.", WIDTH/2, HEIGHT - HEIGHT/(7/2))
            fill(122, 92, 92, 255)
            text("The Lock will disappear in a certain time.", WIDTH/2, HEIGHT - HEIGHT/(7/4))
        end
        
        BorderRadius(a)
        fill(b)
        fontSize(c)
        font(d)
        strokeWidth(e)
        stroke(f)
    end
    
    -- Check wheather protection was allowed.
    local right = false
    local wrong = false
    local boolean = false
    for a, b in ipairs(Protect.Code) do
        if (#Protect.Input == #Protect.Code) then
            right = true -- Works
            boolean = true
        end
        if not ( Protect.Input[a] == b ) then
            if right then
                wrong = true
            end
            right = false
        end
        
        if wrong then
            boolean = false
        end
    end
    if boolean then
        Protect.Exit(1)
    end
    if wrong then
        Protect.Exit(0)
    end
    
    if Protect.Ani.YChange then
        Protect.Ani.Y = Protect.Ani.Y + 150
        if Protect.Ani.Y > HEIGHT then
            Protect.Ani.Y = -HEIGHT
            Protect.Ani.ended = true
        end
        if Protect.Ani.ended and Protect.Ani.Y >= 0 then
            Protect.Ani.YChange = false
            Protect.Ani.Y = 0
        end
    end
    
    if Protect.Tries <= 0 and not Protect.Blocked then
        Protect.Blocked = true
        Protect.BlockedAtTime = os.time()
    end
    
    Protect.AlreadyBlocked = -os.difftime(Protect.BlockedAtTime, os.time())
    
    -- Exit
    if Protect.EndAni.AlphaChange then
        Protect.EndAni.Alpha = Protect.EndAni.Alpha  - 20
        if Protect.EndAni.Alpha <= 0 then
            Protect.PassWordEnter = true
            Protect.EndAni.AlphaChange = false
            Protect.PassWordEnter = false
        end
    end
end

function Protect.Touch(t)
    if Protect.Blocked then
        -- do smt
    elseif Protect.PassWordEnter and not Protect.EndAni.AlphaChange then
        for x = 1, 3 do
            for y = 1, 4 do
                local a, b, c, d = WIDTH/4+((WIDTH/2)/3)*(x-1),HEIGHT/4+35+((HEIGHT/2-70)/4)*(y-1),(WIDTH/2)/3,(HEIGHT/2-70)/4
                if t.x > a and t.x < a + c and t.y > b and t.y < b + d then
                    if t.state == BEGAN then
                        Protect.TouchTab[x][y] = 1
                    elseif t.state == ENDED then
                        if Protect.TouchTab[x][y] == 1 then
                            print(Protect.Tab[x][y])
                            table.insert(Protect.Input, #Protect.Input + 1, Protect.Tab[x][y])
                        end
                        Protect.TouchTab[x][y] = 0
                    end
                else
                    Protect.TouchTab[x][y] = 0
                end
            end
        end
    end
end

function Protect.Exit(mode)
    if mode == 1 then -- Yes
        Protect.EndAni.AlphaChange = true
    elseif mode == 0 then -- No
        Protect.PassWordEnter = false
        Protect.StartAnimation()
    end
end

function Protect.StartAnimation()
    Protect.PassWordEnter = true
    Protect.Input = {}
    Protect.Ani.YChange = true
    Protect.Ani.Y = 0
    Protect.Ani.ended = false
    Protect.Tries = Protect.Tries - 1 
end



--# Main

function setup()
    --displayMode(FULLSCREEN)
    r = {"Test", "Guys", "Government", "Song", "Simple", "Silly", "Garage", "He", "She", "Gangster", "Death", "Defeat", "Diary", "Thunder", "Theather", "Accidently", "Anything", "Banana", "Cake", "Erik", "Failed", "Finger", "Hello", "Lion", "Lake", "Lagune", "Ocean", "Over"}
    parameter.text("Txt")
    slide = 0
end

function draw()
    background(0)
    if slide <= 0 then
        slide = 0
    end
    local v = oc.table.find(r, Txt)
    local formula = #v * 50 - HEIGHT + 100
    if slide >= formula then
        slide = formula
    end
    if #v * 50 < HEIGHT then
        slide = 0
    end
    --sprite("Cargo Bot:Game Area", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)
    fill(255)
    fontSize(50)
    if #v == 0 then
        fill(255, 0, 0, 255)
        v = {"No Items found."}
    end
    for a, b in ipairs(v) do
        text(b, WIDTH/2, HEIGHT - 50 * a + slide)
    end
end

function touched(t)
    slide = slide + t.deltaY
end
