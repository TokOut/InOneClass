-- Http Tables

brouser = {}
brouser.page = {}
brouser.page.html = [[
<html>
  <head>
    <title>Brouser StartPage</title>
  </head>
  <body>
    <b>Start Page</b><br>
    <div class="content" id="content">
      This Page is the startpage. Add something to it.<br>
    </div>
    <footer>
      Credits to Tokout
    </footer>
  </body>
</html>
]]
brouser.page.adress = "about:startpage"
brouser.page.title = "Error: No Title"
brouser.page.editAdress = false
brouser.page.adressInput = ""

function brouser.draw()
    -- First destroy and complete every second our elements, to make it updateable
    local n = brouser.page.html
    local elements = {}
    
    -- Check Elements
    local head = ""
    local body = ""
    
    -- Get head
    for a in string.gmatch(n, "<head.->.-</head>") do
        head = a
        n = n:gsub(a, "")
    end
    
    -- Get body
    for b in string.gmatch(n, "<body.->.-</body>") do
        body = b
        n = n:gsub(b, "")
    end
    
    -- Get title
    for t in string.gmatch(head, "<title.->.-</title>") do
        t = t:gsub("<.->", "")
        brouser.page.title = t
    end
    
    body = body:gsub("<body.->", "")
    body = body:gsub("</body.->", "")
    body = body:gsub("\n", "")
    body = body:gsub("<br>", "\n")
    
    local tag = {}
    -- Don't forget to sort by length when adding new tags, and by alphabet, for some secure reasons.
    tag.footer = function() end
    tag.div = function() end
    tag.h1 = function() font("Baskerville-SemiBold") fontSize(50) end
    tag.b = function() font("Arial-BoldMT") end
    tag.i = function() font("Arial-ItalicMT") end
    
    for a, b in pairs(tag) do
        -- "a" represents all tags
        -- "b" represents their function (display)
        for c in string.gmatch(body, "<" .. a .. ".->.-</" .. a .. ".->")  do
            -- "c" represents the tag length
            c = c:gsub("<" .. a .. ".->", "")
            c = c:gsub("</" .. a .. ".->", "")
            while string.sub(c, 1, 1) == " " do
                c = string.sub(c, 2, #c)
            end
            table.insert(elements, #elements + 1, {b, c})
        end
    end
    
    for a, b in ipairs(elements) do
        b[2] = b[2]:gsub("<.->", "")
    end
    
    -- Display Fixed Container
    fill(81, 59, 76, 255)
    RoundRect(78, HEIGHT-78, WIDTH-150, 50, 10)
    fill(200, 166, 194, 255)
    RoundRect(75, HEIGHT-75, WIDTH-150, 50, 10)
    clip(75, HEIGHT-75, WIDTH-150, 50)
    if brouser.page.editAdress then
        fill(74, 86, 88, 255)
        local a, _ = textSize(brouser.page.adressInput)
        text(brouser.page.adressInput, 80 + a/2, HEIGHT-50)
        stroke(0, 200, 255, 255)
        strokeWidth(3)
        line(a + 80, HEIGHT-70, a + 80, HEIGHT-30)
    else
        fill(0)
        font("Arial-BoldMT")
        fontSize(30)
        local a, _ = textSize(brouser.page.title)
        text(brouser.page.title, 80 + a/2, HEIGHT-50)
        font("ArialMT")
        fontSize(20)
        local b, _ = textSize(brouser.page.adress)
        text(brouser.page.adress, 85 + a + b/2, HEIGHT-55)
    end
    
    clip(80, 80, WIDTH-160, HEIGHT-160)
    --[[ -- Display website html version
    fontSize(25)
    local a, b = textSize(body)
    fill(0, 0, 0, 255)
    text(body, 85 + a/2, HEIGHT-85 - b/2)]]
    
    local h = 0
    brouser.backToNormal()
    for a, b in ipairs(elements) do
        b[1]() -- Call display function
        local c, d = textSize(b[2])
        ::here::
        while c >= WIDTH-170 do
            for a = 2, #b[2] do
                local f = string.sub(b[2], 1, a)
                r, t = textSize(f)
                if r >= WIDTH-170 then
                    b[2] = string.sub(b[2], 1, a-1) .. "\n" .. string.sub(b[2], a, #b[2])
                    goto here
                end
            end
        end
        text(b[2], 85 + c/2, HEIGHT-85 - h - d/2)
        brouser.backToNormal()
        h = h + d
    end
    
    -- Check Functions
    if not isKeyboardShowing then
        brouser.page.editAdress = false
    end
end

function brouser.backToNormal()
    fill(0, 0, 0, 255)
    fontSize(25)
    font("ArialMT")
end

function brouser.touched(t)
    -- In First case show this, for secure touching reasons.
    if t.x > 75 and t.y > HEIGHT-75 and t.x < WIDTH-75  and t.y < HEIGHT-25 then
        if t.state == BEGAN then
            brouser.page.editAdress = true
            showKeyboard()
        end
    else
        brouser.page.editAdress = false
        hideKeyboard()
    end
    
end

function brouser.keyboard(k)
    if brouser.page.editAdress then
        if k == RETURN then
            brouser.open(brouser.page.adressInput)
        elseif k == BACKSPACE then
            if #brouser.page.adressInput >= 1 then
                brouser.page.adressInput = string.sub(brouser.page.adressInput, 1, #brouser.page.adressInput - 1)
            end
        else
            brouser.page.adressInput = brouser.page.adressInput .. k
        end
    end
end

function brouser.open(url)
    -- Set datas origins
    if not (string.sub(url, 1, 4) == "http") then
        url = "https://" .. url
    end
    -- Get Usuall start data
    brouser.page.adress = url
    brouser.page.title = "Loading..."
    hideKeyboard()
    brouser.page.editAdress = false
    -- Translate data
    local function s(data)
        if type(data) == "userdata" then -- We trade with an image
            
        else
            brouser.page.html = data
        end
    end
    
    local function f(error)
        brouser.page.html = [[
        <html>
          <head>
            <title>Can't connect to given URL</title>
          </head>
          <body>
            <h1>]] .. error .. [[</h1>
          </body>
        </html>
        ]]
        brouser.page.title = "Error"
    end
    
    http.request(url, s, f)
end

-- The '3 main' functions

function setup()
    displayMode(FULLSCREEN)
end

function draw()
    background(0, 0, 0, 255)
    fill(135, 147, 122, 255)
    RoundRect(50, 50, WIDTH-100, HEIGHT-100, 15)
    fontSize(25) -- Default
    font("ArialMT") -- Default
    strokeWidth(0) -- For restarting Defaults
    clip() -- Default, removing it
    brouser.draw()
end

function touched(t)
    brouser.touched(t)
end

function keyboard(key)
    brouser.keyboard(key)
end

-- 'RoundRect' function from 'DRAW' class in TOKOUT's local library
-- Author: @tokout & Function edited by: @tokout

RoundRect = function(x, y, w, h, brd)
    -- Get old data
    local col = color(fill()) -- We should get a color format from the unpacked fill
    local str = color(stroke()) -- We should get a color format from the unpacked stroke
    local strW = strokeWidth()
    -- Get border radius
    local border = brd or 0
    
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
