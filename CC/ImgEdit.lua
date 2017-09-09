
--# Globals

global = {}

function glob()
    --[[
        readImage()
    ]]
    displayMode(OVERLAY)
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    cameraSource(CAMERA_FRONT)
    
    global.pageNow = 1
    global.p = 1
    --global.load = 0
    --global.totalLoad = 1
    global.savePrefix = "ocp" -- Outside created Project
    
    -- For IO.Save
    IMAGE = 1
    --HTML_DOCUMENT = 2
    --TEXT_DOCUMENT = 3
    
end

function global.header(txt)
    resetStyle()
    fill(175, 150)
    stroke(255)
    strokeWidth(2)
    rect(-5, HEIGHT-50, WIDTH+10, 55)
    
    fill(255)
    fontSize(25)
    font(UI.Data.Font2)
    text(txt, WIDTH/2, HEIGHT-25)
end

function global.rightContainer(w)
    resetStyle()
    fill(175, 150)
    stroke(255)
    strokeWidth(2)
    rect(-5, -5, w + 5, HEIGHT-45)
end

--# IO
IO = {}

function IO.Save(id, type, data)
    if (type == IMAGE) then
        saveImage("Project:" .. global.savePrefix .. "-img-" .. math.tointeger(id), data)
    end
    
    if IO.isNew(id) then
        IO.addList(id, type)
    end
end

function IO.Read(id, type)
    --local i = readImage("Project:ocp_img_10.0")
    --print(type(readImage("Project:" .. global.savePrefix .. "img_" .. id .. ".0")))
    if type .. "" == IMAGE .. "" then
        local c = readImage("Project:" .. global.savePrefix .. "-img-" .. math.tointeger(id))
        return c or image(1, 1) --"Project:" .. global.savePrefix .. "img_" .. id .. ".0" --or image(1,1)
        --readImage("Project:" .. global.savePrefix .. "img_" .. math.tointeger(id) .. ".0")
    end
end

function IO.isNew(id)
    local s = IO.listData()
    
    if not s then
        return true
    end
    
    for a, b in ipairs(s) do
        if b == id then
            return false
        end
    end
    return true
end

function IO.addList(id, type_)
    local s = IO.listData() or {}
    local d = {} -- To prevent doubled saves
    table.insert(s, {id, type_})
    
    --[[local v = "{"
    for a, b in ipairs(s) do
        print(a, b[1], b[2])
        v = v .. b[1] .. "," .. b[2]
        if a == #s then
            v = v .. ";" .. id .. "," .. type .. "}"
        else
            v = v .. ";"
        end
    end]]
    
    local v = "{"
    for a, b in ipairs(s) do
        local m = true
        for q, w in ipairs(d) do
            if b[1] == w then -- Existing
                m = false
            end
        end
        if m then
            table.insert(d, b[1])
            v = v .. math.tointeger(b[1]) .. "," .. b[2]  .. ";"
        end
    end
    v = string.sub(v, 1, #v-1) .. "}"
    
    saveLocalData("listdata", v)
end

function IO.listData()
    local v = {}
    local r = readLocalData("listdata") or "{}"
    r = string.sub(r, 2, #r-1) .. ";"
    --print(r)
    for a, b in string.gmatch(r, "(.-),(%w+);") do
        table.insert(v, {math.tointeger(a), b})
    end
    --print(#v[1])
    return v
end

function IO.NewId()
    local m = IO.GetId()
    m = m + 1
    saveLocalData("object_id", m)
    return m
end

function IO.GetId()
    return readLocalData("object_id") or 0
end

-- Replaced with IO.addList

--[[function IO.saveListData(tab)
    local v = "{"
    for a, b in ipairs(tab) do
        v = v .. b
        if #tab == a then
            v = v .. "}"
        else
            v = v .. ","
        end
    end
end]]


--# UI
UI = {}
UI.Data = {}

function UI.I()
    UI.Data.Font1 = "Arial-BoldMT"
    UI.Data.Font2 = "ArialMT"
    
    UI.Data.FontList = {
        -- Ameican Type Witer
        ["ATWriter"] = {
            ["default"] = "AmericanTypewriter",
            ["bold"] = "AmericanTypewriter-Bold",
            ["light"] = "AmericanTypewriter-Light",
            ["condensed"] = "AmericanTypewriter-Condensed"
        },
        
        -- Arial
        ["Arial"] = {
            ["default"] = "ArialMT",
            ["bold"] = "Arial-BoldMT",
            ["italic"] = "Arial-ItalicMT",
            ["bold-italic"] = "Arial-BoldItalicMT",
            ["round"] = "ArialRoundedMTBold"
        },
        
        -- Baskerville
        ["BV"] = {
            ["default"] = "Baskerville",
            ["bold"] = "Baskerville-SemiBold",
            ["italic"] = "Baskerville-Italic",
            ["bold-italic"] = "Baskerville-SemiBoldItalic"
        },
        
        -- Courier
        ["Courier"] = {
            ["default"] = "Courier",
            ["bold"] = "Courier-Bold",
            ["italic"] = "Courier-Oblique",
            ["bold-italic"] = "Courier-BoldOblique"
        }
    }
end

UI.Button = class()

function UI.Button:init(t)
    self.x, self.y, self.w, self.h = t.x or 0, t.y or 0, t.w or 0, t.h or 0
    self.fontsize = t.fs or self.h
    self.t = t.text
    self.hold = false
    self.act = t.act or function(t) print("Button Touch at vec2(" .. t.x .. ", " .. t.y .. ")") end
end

function UI.Button:draw()
    resetStyle()
    if self.hold then
        fill(200, 150)
    else
        fill(127, 100)
    end
    stroke(255)
    strokeWidth(3)
    rect(self.x, self.y, self.w, self.h)
    fill(255)
    font(UI.Data.Font1)
    fontSize(self.fontsize)
    textWrapWidth(self.w)
    text(self.t or "Button", self.x + self.w/2, self.y + self.h/2)
end

function UI.Button:touched(t)
    if not t then return end
    
    if t.x > self.x and t.x < self.x + self.w and t.y > self.y and t.y < self.y + self.h then
        if t.state == BEGAN then
            self.hold = true
        elseif t.state == ENDED then
            if self.hold then
                self.hold = false
                self.act(t)
            end
        end
    else
        self.hold = false
    end
end

function UI.Button:keyboard(key)
    return
end

UI.TextBox = class()

function UI.TextBox:init(t)
    self.x, self.y, self.w, self.h = t.x or 0, t.y or 0, t.w or 0, t.h or 0
    self.fontsize = t.fs or self.h
    self.text = t.text or ""
    self.ph = t.placeholder or "Touch to enter Text"
    self.stringType = t.type or "alphanumeric"
    self.selected = false
    self.hold = false
    self.error = false
    self.maximalSize = t.max or 0
    --self.mark = 0
end

function UI.TextBox:draw()
    resetStyle()
    fill(255)
    stroke(127)
    if self.error then
        stroke(255, 0, 0)
    end
    strokeWidth(3)
    rect(self.x, self.y, self.w, self.h)
    fill(0)
    font(UI.Data.Font1)
    fontSize(self.fontsize)
    textWrapWidth(self.w)
    local textWidth,_ = textSize(self.text)
    text(self.text, self.x + self.w/2, self.y + self.h/2)
    font(UI.Data.Font2)
    local phWidth,_ = textSize(self.ph)
    if #self.text == 0 then
        fill(200)
        if self.error then
            fill(255, 200, 200)
        end
        text(self.ph, self.x + self.w/2, self.y + self.h/2)
    end
    
    if self.selected then
        if os.time()%2 == 0 then
            strokeWidth(3)
            stroke(0, 50, 255)
            --local tW = textSize(string.sub(self.text, 1, self.mark))
            local x
            if self.text == "" then
                x = self.x + self.w/2 + phWidth/2
            else
                x = self.x + self.w/2 + --[[(textWidth-tW)]]textWidth/2
            end
            line(x, self.y, x, self.y + self.h)
        end
    end
    
    if not isKeyboardShowing() and self.selected then
        self.selected = false
    end
end

function UI.TextBox:touched(t)
    if t.x > self.x and t.x < self.x + self.w and t.y > self.y and t.y < self.y + self.h then
        if t.state == BEGAN then
            self.hold = true
        elseif t.state == ENDED then
            if self.hold then
                font(UI.Data.Font1) -- For TextSize
                fontSize(self.fontsize) -- For TextSize
                
                -- {{ Fix
                
                --[[local p = t.x-self.x-self.w/2
                
                for h = 1, #self.text do
                    local m,_ = textSize(string.sub(self.text, 1, h))
                    --print(h, m)
                    if m >= p then
                        self.mark = h
                        print(h)
                        break
                    end
                end]]
                
                -- }}
                
                self.hold = false
                self.selected = true
                showKeyboard()
            end
        end
    else
        self.hold = false
        if self.selected then
            hideKeyboard()
        end
        self.selected = false
    end
end

function UI.TextBox:keyboard(k)
    if self.selected then
        if self.error then
            self.error = false
        end
        if k == RETURN then
            self.selected = false
            hideKeyboard()
        elseif k == BACKSPACE then
            -- {{ Fix
            --self.text = string.sub(self.text, 1, self.mark) .. string.sub(self.text, self.mark, #self.text)
            -- }}
            self.text = string.sub(self.text, 1, #self.text-1)
        else
            local v = {
                -- Type, LettersAllowed
                {"alphanumeric", "abcdefghijklmnopjrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"},
                {"numeric", "0123456789"},
                {"fileformat", "abcdefghijklmnopjrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ._-?'\""},
                {"alpha", "abcdefghijklmnopjrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"},
                {"all", ""},
                {"floatnumeric", "0123456789./-+*%,|:;()"},
                {"text", "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM.,?!'\"\\/1234567890-/:;()$&@_|~<>€£¥[]{}#%^*+=•…¿¡`’‘«»„”“¢₽¥€£₩§°‰"},
            }
            
            for a, b in ipairs(v) do
                if (self.stringType == b[1]) then
                    if b[2] == "" then
                        if (#self.text < self.maximalSize) or (self.maximalSize == 0) then
                            self.text = self.text .. k --string.sub(self.text, 1, self.mark) .. k .. string.sub(self.text, self.mark+1, #self.text)
                        end
                    else
                        for z = 1, #b[2] do
                            if string.sub(b[2], z, z) == k then
                                if (#self.text < self.maximalSize) or (self.maximalSize == 0) then
                                    self.text = self.text .. k --string.sub(self.text, 1, self.mark) .. k .. string.sub(self.text, self.mark+1, #self.text)
                                end
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end



--# SlideShow
--[[SlideShow = class()

function SlideShow.I()
    -- Page Settings
    SlideShow.Page = 4
    
    -- Intro
    local img = image(WIDTH, HEIGHT)
    setContext(img)
    background(0)
    fill(255)
    font("ArialMT")
    fontSize(35)
    text("Touch to stop the slide show.", WIDTH*.5, HEIGHT*.5)
    local img_err = image(WIDTH, HEIGHT)
    setContext(img_err)
    background(0)
    fill(255)
    font("ArialMT")
    fontSize(35)
    text("You haven't got any images.", WIDTH*.5, HEIGHT*.5)
    setContext()
    
    local tab = {}
    local f = IO.listData()
    for a, b in ipairs(f) do
        table.insert(tab, IO.Read(b[1], b[2]))
    end
    
    -- Data
    SlideShow.Data = {}
    SlideShow.Data.Images = tab
    SlideShow.Data.Img1 = img
    SlideShow.Data.Img2 = image(0, 0)
    
    -- Timer
    SlideShow.Data.Timer = {}
    SlideShow.Data.Timer.State = 0 -- State
    SlideShow.Data.Timer.Num = 0 -- Value
    SlideShow.Data.Timer.MaxNum = 100 -- Maximal mixing time
    SlideShow.Data.Timer.Pause = 0 -- Pause timing
    SlideShow.Data.Timer.MaxPause = 500 -- Maximal pause time per image
    SlideShow.Data.Timer.NextImage = 0
    
    SlideShow.Data.EmptyImage = img_err
end

function SlideShow.D()
    resetStyle()
    sprite(SlideShow.Data.Img1, WIDTH*.5, HEIGHT*.5)
    tint(255, SlideShow.Data.Timer.MaxNum - SlideShow.Data.Timer.Num)
    sprite(SlideShow.Data.Img2, WIDTH*.5, HEIGHT*.5)
    
    if SlideShow.Data.Timer.State == 0 then -- Start Loop
        SlideShow.Data.Timer.State = 1
        SlideShow.Data.Timer.Num = 0
        SlideShow.Data.Timer.Pause = 0
    elseif SlideShow.Data.Timer.State == 1 then -- Growing Loop
        SlideShow.Data.Timer.Num = SlideShow.Data.Timer.Num + 1
        if SlideShow.Data.Timer.Num >= SlideShow.Data.Timer.MaxNum then
            SlideShow.Data.Timer.Num = 0
            SlideShow.Data.Timer.State = 2
            
            -- Switch Images
            SlideShow.Data.Img1 = SlideShow.Data.Img2
            SlideShow.Data.Img2 = SlideShow.NextImage(SlideShow.Data.Timer.NextImage, SlideShow.Data.Images)
        end
    elseif SlideShow.Data.Timer.State == 2 then -- Pausing Loop
        SlideShow.Data.Timer.Pause = SlideShow.Data.Timer.Pause + 1
        if SlideShow.Data.Timer.Pause >= SlideShow.Data.Timer.MaxPause then
            SlideShow.Data.Timer.State = 1
        end
    end
end

function SlideShow.NextImage(next, tab)
    if #tab == 0 then
        return SlideShow.Data.EmptyImage
    elseif #tab == 1 then
        return tab[1]
    else
        next = next + 1
        if next > #tab then
            SlideShow.Data.Timer.NextImage = 1
        end
        return tab[next]
    end
end

function SlideShow.T(t)
    if t.state == ENDED then
        global.pageNow = Lobby.Page()
    end
end]]

--# ImageEdit
ImageEditing = {}

function ImageEditing.I()
    -- Page Settings
    ImageEditing.Page = 2
    
    -- Data
    ImageEditing.IsEdit = false
    ImageEditing.Id = 0
    ImageEditing.SaveState = "//new" -- new, saved
    ImageEditing.Saving1 = false
    ImageEditing.Saved = false
    ImageEditing.Image = nil
    ImageEditing.Zoom = 1
    ImageEditing.ZoomScroll = 50
    ImageEditing.Move = vec2(0, 0)
    ImageEditing.Name = "George Washington"
    ImageEditing.Lock = false
    ImageEditing.Figures = {
        function(x, y, size, c)
            resetStyle()
            fill(c)
            ellipse(x, y, size)
        end,
        function(x, y, size, c)
            resetStyle()
            fill(c)
            rect(x-size/2, y-size/2, size, size)
        end,
        function(x, y, size, c)
            resetStyle()
            stroke(c)
            strokeWidth(size/5)
            line(x-size*3, y-size*2, x+size*3, y+size*2)
        end,
        function(x, y, size, c)
            resetStyle()
            stroke(c)
            strokeWidth(size/5)
            line(x-size*3, y-size*2, x+size*3, y+size*2)
            line(x+size*3, y-size*2, x-size*3, y+size*2)
        end,
        function(x, y, size, c)
            resetStyle()
            fill(0, 0)
            strokeWidth(size * .25)
            stroke(c)
            ellipse(x, y, size)
        end--[[,
        function(x, y, size, c)
            resetStyle()
            local v = 12
            for x = 1, v do
                fill(c.r, c.g, c.b, 255-(x/v)*250)
                ellipse(x, y, size-(x/v)*size)
            end
        end]]
    }
    ImageEditing.Files = {
        --[[
            hcf = hard coded function
            tf = table function [Simple]
                Name, "tf", icon, Function(x, y, color)
            oa = table function [Option Alert]
                Name, "oa", Function(x, y, color, filters), AlertButtons, CheckFunction(AlertButtons)
            list = Sub container
                Name, "list", Array
        ]]
        {"Save", "hcf", "//save"},
        {"Save New", "hcf", "//saveas"},
        --[[{"Filters", "list", {
            {"Invert", "tf", function(x, y, c) ImageEditing.Image:set(x, y, 255-c.r, 255-c.g, 255-c.b, c.a) end},
            {"Desaturate", "tf", function(x, y, c) ImageEditing.Image:set(x, y, (c.r+c.g+c.b)/3) end},
            --{"Blur", "tf", function(x, y, c) end}
        }},]]
        {"Radial Blur", "tf", "💧", function(v)
            local x, y = v.width, v.height
            local m = mesh()
            m.texture = v
            m.shader = shader("Filters:Radial Blur")
            m.shader.sampleDist = 1
            m.shader.sampleStrength = 2.2
            local s = m:addRect(0, 0, 0, 0)
            m:setRect(s, x/2, y/2, x, y)
            setContext(ImageEditing.Image)
            m:draw()
            setContext()
        end},
        {"Blur", "tf", "💧", function(v)
            local x, y = v.width, v.height
            local m = mesh()
            m.texture = v
            m.shader = shader("Filters:Blur")
            m.shader.conPixel = vec2(2/x, 2/y)
            m.shader.conWeight = 1/9
            local s = m:addRect(0, 0, 0, 0)
            m:setRect(s, x/2, y/2, x, y)
            setContext(ImageEditing.Image)
            m:draw()
            setContext()
        end},
        {"Invert", "tf", "✋🏿", function(v)
            local x, y = v.width, v.height
            local m = mesh()
            m.texture = v
            m.shader = shader("Basic:Invert")
            local s = m:addRect(0, 0, 0, 0)
            m:setRect(s, x/2, y/2, x, y)
            setContext(ImageEditing.Image)
            m:draw()
            setContext()
        end},
        {"Take Photo", "tf", "📷", function(v)
            --[[resetStyle()
            local x, y = v.width, v.height
            setContext(ImageEditing.Image)
            cameraSource(CAMERA_FRONT)
            sprite(CAMERA, WIDTH*.5, HEIGHT*.5, WIDTH, HEIGHT)
            setContext()]]
            alert("As you are using the Beta Version, some functions are not available!", "Beta")
        end},
        {"Edge", "tf", "❕", function(v)
            local x, y = v.width, v.height
            local m = mesh()
            m.texture = v
            m.shader = shader("Filters:Edge")
            m.shader.conPixel = vec2(2/x, 2/y)
            m.shader.conWeight = 1/9
            local s = m:addRect(0, 0, 0, 0)
            m:setRect(s, x/2, y/2, x, y)
            setContext(ImageEditing.Image)
            m:draw()
            setContext()
        end},
        {"Posterize", "tf", "🌈", function(v)
            local x, y = v.width, v.height
            local m = mesh()
            m.texture = v
            m.shader = shader("Filters:Posterize")
            m.shader.numColors = 10
            m.shader.gamma = 1
            local s = m:addRect(0, 0, 0, 0)
            m:setRect(s, x/2, y/2, x, y)
            ImageEditing.Image = image(x, y)
            setContext(ImageEditing.Image)
            m:draw()
            setContext()
        end},
        {"Desaturate", "tf", "🖤", function(v)
            local x, y = v.width, v.height
            local m = mesh()
            m.texture = v
            m.shader = shader("Documents:Desaturate")
            m.shader.brightness = .33
            local s = m:addRect(0, 0, 0, 0)
            m:setRect(s, x/2, y/2, x, y)
            ImageEditing.Image = image(x, y)
            setContext(ImageEditing.Image)
            m:draw()
            setContext()
        end},
        {"Noise", "tf", "🏁", function(v)
            local x, y = v.width, v.height
            local m = mesh()
            m.texture = v
            m.shader = shader("Documents:4Split")
            m.shader.size = vec2(x, y)
            local s = m:addRect(0, 0, 0, 0)
            m:setRect(s, x/2, y/2, x, y)
            ImageEditing.Image = image(x, y)
            setContext(ImageEditing.Image)
            m:draw()
            setContext()
        end},
        {"Copy", "tf", "📩", function(v)
            pasteboard.copy(v)
            alert("The image has been converted and is now exported to your pasteboard!", "Exported")
        end},
        {"Exit", "hcf", "//exit"}
    }
    
    ImageEditing.Edit = {}
    ImageEditing.Edit.FGColor = color(255, 0, 0)
    ImageEditing.Edit.Size = 5
    ImageEditing.Edit.FigurePick = 1
    ImageEditing.Fill = false
    
    ImageEditing.isShowing = {}
    ImageEditing.isShowing.ColorPick = false
    ImageEditing.isShowing.SizePick = false
    ImageEditing.isShowing.FigurePick = false
    ImageEditing.isShowing.FileOptions = false
    ImageEditing.isShowing.ImageSize = false
    
    ImageEditing.Saving1Buttons = {
        
        -- Submit
        UI.Button({
            x = 30, y = 30, w = WIDTH-60, h = 50, fs = 40,
            act = function()
                IO.NewId()
                IO.Save(IO.GetId(), IMAGE, ImageEditing.Image)
                ImageEditing.Saved = true
                ImageEditing.SaveState = "//saved"
                ImageEditing.Id = IO.GetId()
                ImageEditing.Saving1 = false
                Lobby.I()
            end,
            text = "Save"
        })
    }
    ImageEditing.NonEditError = ""
    ImageEditing.NonEdit = {
        UI.TextBox({
            x = 30, y = HEIGHT-140, w = WIDTH-60, h = 50, fs = 40,
            type = "numeric",
            placeholder = "Width",
            text = WIDTH .. "",
            max = 6
        }),
        UI.TextBox({
            x = 30, y = HEIGHT-210, w = WIDTH-60, h = 50, fs = 40,
            type = "numeric",
            placeholder = "Height",
            text = HEIGHT .. "",
            max = 6
        }),
        
        -- Go Back
        UI.Button({
            x = 30, y = HEIGHT-70, w = 50, h = 50, fs = 40,
            act = function() global.pageNow = Lobby.Page end,
            text = "<"
        }),
        
        -- Control, Submit
        UI.Button({
            x = 30, y = 30, w = WIDTH-60, h = 50, fs = 40,
            act = function()
                ImageEditing.CreateNew(ImageEditing.NonEdit[1].text, ImageEditing.NonEdit[2].text, "simple")
            end,
            text = "Create Blank Image"
        })--[[,
        UI.Button({
            x = 30, y = 100, w = WIDTH-60, h = 50, fs = 40,
            act = function()
                ImageEditing.CreateNew(ImageEditing.NonEdit[1].text, ImageEditing.NonEdit[2].text, "camera")
            end,
            text = "Create Camera"
        })]]
    }
end

function ImageEditing.D()
    if ImageEditing.Saving1 then
        local w, h = spriteSize(ImageEditing.Image)
        sprite(ImageEditing.Image, WIDTH/2, HEIGHT*.33, w/4, h/4)
        for a, b in ipairs(ImageEditing.Saving1Buttons) do
            b:draw()
        end
    elseif ImageEditing.IsEdit then
        noSmooth()
        local a, b = spriteSize(ImageEditing.Image)
        sprite(ImageEditing.Image,
            WIDTH/2 + ImageEditing.Move.x,
            HEIGHT/2 + ImageEditing.Move.y,
            a/ImageEditing.Zoom,
            b/ImageEditing.Zoom
        )
        resetStyle()
        
        global.rightContainer(70)
        global.header(ImageEditing.Name .. " [Image]")
        
        -- Color Picker Icon
        resetStyle()
        fill(ImageEditing.Edit.FGColor)
        strokeWidth(3)
        stroke(255)
        ellipse(35, HEIGHT-85, 60)
        
        -- Size Picker Icon
        resetStyle()
        fill(255)
        fontSize(5)
        text("A", 10, HEIGHT-155)
        fontSize(10)
        text("A", 20, HEIGHT-155)
        fontSize(15)
        text("A", 35, HEIGHT-155)
        fontSize(20)
        text("A", 55, HEIGHT-155)
        
        -- Brush Picker Icon
        resetStyle()
        fill(255)
        rect(5, HEIGHT-255, 60, 60)
        fill(0)
        ellipse(35, HEIGHT-225, 60)
        
        -- Fill
        resetStyle()
        --[[fill(255)
        strokeWidth(3)
        stroke(0)
        if ImageEditing.Fill then
            stroke(100, 100, 255)
        end
        rect(5, HEIGHT-325, 60, 60)
        fill(0)
        strokeWidth(0)
        rect(15, HEIGHT-315, 40, 40)]]
        --[[fontSize(60)
        font("ArialMT")
        --tint(255)
        if ImageEditing.Fill then
            fill(255)
        end
        text("🛢", 35, HEIGHT-295)
        if ImageEditing.Fill then
            fontSize(25)
            text("FILL", 35, HEIGHT-295)
        end]]
        
        -- File (Save/..)
        resetStyle()
        spriteMode(CENTER)
        sprite("Cargo Bot:Dialogue Box", 35, HEIGHT-365, 60, 60)
        
        -- Lock
        resetStyle()
        --[[fill(255)
        strokeWidth(3)
        stroke(0)
        if ImageEditing.Lock then
            stroke(100, 100, 255)
        end
        rect(5, HEIGHT-465, 60, 60)
        fill(0)
        strokeWidth(0)
        if ImageEditing.Lock then
            fill(0, 0, 150)
        end
        rect(10, HEIGHT-460, 50, 25)
        fill(0, 0)
        strokeWidth(5)
        ellipse(35, HEIGHT-435, 45)]]
        fontSize(60)
        fill(150)
        if ImageEditing.Lock then
            fill(255)
        end
        text("🔒", 35, HEIGHT-435) --⛔️📵🚫⏺🔓↔️
        
        -- Image Zoom
        resetStyle()
        fontSize(60)
        fill(255)
        text("🔎", 35, HEIGHT-505)
        
        if ImageEditing.isShowing.ColorPick then
            resetStyle()
            strokeWidth(3)
            stroke(255)
            fill(100)
            rect(80, HEIGHT-200, 350, 150)
            
            stroke(255, 200, 200)
            line(100, HEIGHT-100, 410, HEIGHT-100)
            stroke(200, 255, 200)
            line(100, HEIGHT-125, 410, HEIGHT-125)
            stroke(200, 200, 255)
            line(100, HEIGHT-150, 410, HEIGHT-150)
            
            strokeWidth(1)
            stroke(255)
            fill(ImageEditing.Edit.FGColor.r, 0, 0, 255)
            ellipse(100 + (ImageEditing.Edit.FGColor.r/255) * 310, HEIGHT-100, 10)
            fill(0, ImageEditing.Edit.FGColor.g, 0, 255)
            ellipse(100 + (ImageEditing.Edit.FGColor.g/255) * 310, HEIGHT-125, 10)
            fill(0, 0, ImageEditing.Edit.FGColor.b, 255)
            ellipse(100 + (ImageEditing.Edit.FGColor.b/255) * 310, HEIGHT-150, 10)
        end
        if ImageEditing.isShowing.SizePick then
            resetStyle()
            strokeWidth(3)
            stroke(255)
            fill(100)
            rect(80, HEIGHT-200, 350, 80)
            
            line(100, HEIGHT-160, 410, HEIGHT-160)
            
            fill(255)
            ellipse(100 + (ImageEditing.Edit.Size/100) * 310, HEIGHT-160, 10)
            
            fontSize(30)
            font("Futura-Medium")
            text(math.floor(ImageEditing.Edit.Size), 255, HEIGHT-140)
        end
        if ImageEditing.isShowing.FigurePick then
            resetStyle()
            strokeWidth(3)
            stroke(255)
            fill(100)
            rect(80, HEIGHT-265, 350, 80)
            
            for a, b in ipairs(ImageEditing.Figures) do
                if a == ImageEditing.Edit.FigurePick then
                    fill(0, 0)
                    strokeWidth(5)
                    stroke(100, 100, 255)
                    rect(50 + a*60, HEIGHT-265, 60, 80)
                end
                resetStyle()
                b(80 + a*60, HEIGHT-225, 10, color(255))
            end
        end
        if ImageEditing.isShowing.FileOptions then
            resetStyle()
            strokeWidth(3)
            stroke(255)
            fill(100)
            rect(70, 1, 200, HEIGHT-50)
            
            for a, b in ipairs(ImageEditing.Files) do
                fill(255)
                fontSize(20)
                font("ArialMT")
                local textWidth,_ = textSize(b[1])
                text(b[1], 80 + textWidth/2, HEIGHT-50-a*35)
                if b[2] == "list" then
                    fontSize(35)
                    font("AppleColorEmoji")
                    text("📘", 240, HEIGHT-50-a*35)
                elseif b[2] == "hcf" then
                    fill(255)
                    fontSize(35)
                    font("AppleColorEmoji")
                    
                    if b[3] == "//save" or b[3] == "//saveas" then
                        text("💾", 240, HEIGHT-50-a*35)
                    elseif b[3] == "//exit" then
                        text("❌", 240, HEIGHT-50-a*35)
                    end
                elseif b[2] == "tf" then
                    fill(255)
                    fontSize(35)
                    font("AppleColorEmoji")
                    text(b[3], 240, HEIGHT-50-a*35)
                end
            end
        end
        if ImageEditing.isShowing.ImageSize then
            resetStyle()
            strokeWidth(3)
            stroke(255)
            fill(100)
            rect(80, HEIGHT-550, 350, 80)
            
            line(100, HEIGHT-510, 410, HEIGHT-510)
            
            --[[fill(255)
            ellipse(255, HEIGHT-510, 7)
            if ImageEditing.Zoom == 1 then
                ellipse(255, HEIGHT-510, 13)
            elseif ImageEditing.Zoom > 1 then
                --ellipse(255 - (ImageEditing.Zoom/10) * 155, HEIGHT-510, 13)
                ellipse(ImageEditing.Zoom, HEIGHT-510, 13)
            elseif ImageEditing.Zoom < 1 then
                --ellipse(255 - (ImageEditing.Zoom/10+1) * 155, HEIGHT-510, 13)
                ellipse(355 - (1/ImageEditing.Zoom), HEIGHT-510, 13)
            end]]
            ellipse(100 + (ImageEditing.ZoomScroll/100) * 310, HEIGHT-510, 13)
        end
    elseif ImageEditing.IsEdit == false then
        resetMatrix()
        fill(255, 0, 0)
        fontSize(20)
        font(UI.Data.Font1)
        text(ImageEditing.NonEditError, WIDTH/2, 100)
        fill(255)
        fontSize(35)
        text("New Image", WIDTH/2, HEIGHT-50)
        
        --local a, b = spriteSize(CAMERA)
        --sprite(CAMERA, WIDTH/2, HEIGHT/2, a*.33, b*.33)
        
        for a, b in ipairs(ImageEditing.NonEdit) do
            b:draw()
        end
    end
end

function ImageEditing.T(t)
    if ImageEditing.Saving1 then
        for a, b in ipairs(ImageEditing.Saving1Buttons) do
            b:touched(t)
        end
    elseif ImageEditing.IsEdit then
        if t.x < 75 and t.y < HEIGHT-55 and t.y > HEIGHT-115 and t.state == BEGAN then
            if ImageEditing.isShowing.ColorPick then
                ImageEditing.isShowing.ColorPick = false
            else
                ImageEditing.CloseSubTabs()
                ImageEditing.isShowing.ColorPick = true
            end
            return
        end
        if t.x < 75 and t.y < HEIGHT-115 and t.y > HEIGHT-175 and t.state == BEGAN then
            if ImageEditing.isShowing.SizePick then
                ImageEditing.isShowing.SizePick = false
            else
                ImageEditing.CloseSubTabs()
                ImageEditing.isShowing.SizePick = true
            end
            return
        end
        if t.x < 75 and t.y > HEIGHT-260 and t.y < HEIGHT-190 and t.state == BEGAN then
            -- (5, HEIGHT-255, 60, 60)
            if ImageEditing.isShowing.FigurePick then
                ImageEditing.isShowing.FigurePick = false
            else
                ImageEditing.CloseSubTabs()
                ImageEditing.isShowing.FigurePick = true
            end
            return
        end
        --[[if t.x < 75 and t.y > HEIGHT-345 and t.y < HEIGHT-275 and t.state == BEGAN then
            if ImageEditing.Fill then
                ImageEditing.Fill = false
            else
                ImageEditing.Fill = true
            end
            return
        end]]
        if t.x < 75 and t.y > HEIGHT-395 and t.y < HEIGHT-335 and t.state == BEGAN then
            if ImageEditing.isShowing.FileOptions then
                ImageEditing.isShowing.FileOptions = false
            else
                ImageEditing.CloseSubTabs()
                ImageEditing.isShowing.FileOptions = true
            end
            return
        end
        if t.x < 75 and t.y > HEIGHT-465 and t.y < HEIGHT-405 and t.state == BEGAN then
            if ImageEditing.Lock then
                ImageEditing.Lock = false
            else
                ImageEditing.Lock = true
            end
            return
        end
        --HEIGHT-505, fontSize(60)
        if t.x < 75 and t.y > HEIGHT-535 and t.y < HEIGHT-475 and t.state == BEGAN then
            if ImageEditing.isShowing.ImageSize then
                ImageEditing.isShowing.ImageSize = false
            else
                ImageEditing.CloseSubTabs()
                ImageEditing.isShowing.ImageSize = true
            end
            return
        end
        
        if ImageEditing.isShowing.ColorPick and
            t.x > 80 and t.x < 430 and t.y > HEIGHT-200 and t.y < HEIGHT-50 then
            --rect(80, HEIGHT-200, 350, 150)
            if t.x > 120 and t.x < 430 then
                if t.y > HEIGHT-110 and t.y < HEIGHT-90 then
                    ImageEditing.Edit.FGColor.r = (t.x/310) * 255 - 100
                elseif t.y > HEIGHT-135 and t.y < HEIGHT-115 then
                    ImageEditing.Edit.FGColor.g = (t.x/310) * 255 - 100
                elseif t.y > HEIGHT-160 and t.y < HEIGHT-140 then
                    ImageEditing.Edit.FGColor.b = (t.x/310) * 255 - 100
                end
            end
            
            return
        end
        
        if ImageEditing.isShowing.SizePick and
            t.x > 80 and t.x < 430 and t.y > HEIGHT-200 and t.y < HEIGHT-120 then
            
            if t.x > 110 and t.x < 422 then
                if t.y > HEIGHT-170 and t.y < HEIGHT-150 then
                    ImageEditing.Edit.Size = (t.x/310) * 100 - 35
                    --print(ImageEditing.Edit.Size)
                end
            end
            return
        end
        
        if ImageEditing.isShowing.FigurePick and
            t.x > 80 and t.x < 430 and t.y > HEIGHT-265 and t.y < HEIGHT-185 then
            -- rect(80, HEIGHT-265, 350, 80)
            -- Position 4: line(x+size*3, y-size*2, x-size*3, y+size*2)
            -- => x-20, x+20
            
            for a, b in ipairs(ImageEditing.Figures) do
                --rect(50 + a*60, HEIGHT-265, 60, 80)
                if t.x > 50 + a*60 and t.x < 110 + a*60 and t.y > HEIGHT-265 and t.y < HEIGHT-185 then
                    ImageEditing.Edit.FigurePick = a
                    return
                end
            end
            
            return
        end
        
        if ImageEditing.isShowing.FileOptions --then
            and t.x > 70 and t.x < 270 and t.y < HEIGHT-49 then
            -- rect(70, 1, 250, HEIGHT-50)
            for a, b in ipairs(ImageEditing.Files) do
                if t.y>HEIGHT-67-a*35 and t.y<HEIGHT-3-a*35 then
                    --print(b[1])
                    if t.state == ENDED then
                        if b[2] == "hcf" then
                            if b[3] == "//save" then
                                ImageEditing.SaveImage()
                            elseif b[3] == "//saveas" then
                                ImageEditing.Saving1 = true
                            elseif b[3] == "//exit" then
                                global.pageNow = Lobby.Page
                            end
                        elseif b[2] == "tf" then
                            b[4](ImageEditing.Image)
                            ImageEditing.CloseSubTabs()
                        end
                    end
                    return
                end
            end
            return
        end
        
        if ImageEditing.isShowing.ImageSize then
            -- rect(80, HEIGHT-550, 350, 80)
            if t.x > 80 and t.x < 430 and t.y > HEIGHT-550 and t.y < HEIGHT-470 then
                --line(100, HEIGHT-510, 410, HEIGHT-510)
                if t.x > 100 and t.x < 400 then
                    --[[local x = t.x-100
                    if x >= 150 and x <= 160 then
                        ImageEditing.Zoom = 1
                    elseif x < 150 then
                        ImageEditing.Zoom = 10-x/10
                    elseif x > 160 then
                        ImageEditing.Zoom = 1/(200-x)/10
                    end]]
                    v = t.x-100
                    if v >= 150 and v <= 155 then
                        ImageEditing.Zoom = 1
                        ImageEditing.ZoomScroll = 50 --(v/300)*100
                    elseif v < 140 then
                        ImageEditing.Zoom = 1/(v/140)
                        ImageEditing.ZoomScroll = v/3 --(v/300)*100
                    elseif v > 160 then
                        ImageEditing.Zoom = (50-((v-150)/160)*50)/50
                        ImageEditing.ZoomScroll = v/3 --(v/300)*100
                    end
                end
                --print(ImageEditing.Zoom)
                return
            end
        end
        
        if t.x > 70 and t.y < HEIGHT-50 then
            local w, h = spriteSize(ImageEditing.Image)
            local x = (-WIDTH/2+w/2/ImageEditing.Zoom+t.x-ImageEditing.Move.x) * ImageEditing.Zoom --+
                        --ImageEditing.Move.x * ImageEditing.Zoom
            local y = (-HEIGHT/2+h/2/ImageEditing.Zoom+t.y-ImageEditing.Move.y) * ImageEditing.Zoom --+
                        --ImageEditing.Move.y * ImageEditing.Zoom
                
            if not ImageEditing.Lock then
                if ImageEditing.Fill then
                    if t.state == ENDED then
                        --[[local s = {}
                        for a = 1, w do
                            s[a] = {}
                            for b = 1, h do
                                s[a][b] = 0
                            end
                        end]]
                        --local v = ImageEditing.Image
                            
                        alert("Fill is brocken and causes bugs. That's why this function is locked!", "Attention")
                        --ImageEditing.FillFunction(x, y, v:get(math.floor(x), math.floor(y)))
                    end
                else
                    setContext(ImageEditing.Image)
                        
                    --strokeWidth(0)
                    --fill(ImageEditing.Edit.FGColor)
                    if t.x > WIDTH/2-w/2/ImageEditing.Zoom and t.x < WIDTH/2+w/2/ImageEditing.Zoom and t.y > HEIGHT/2-h/2/ImageEditing.Zoom and t.y < HEIGHT/2+h/2/ImageEditing.Zoom then
                        for a, b in ipairs(ImageEditing.Figures) do
                            if a == ImageEditing.Edit.FigurePick then
                                ImageEditing.Saved = false
                                b(x, y, ImageEditing.Edit.Size, ImageEditing.Edit.FGColor)
                            end
                        end
                    end
                    setContext()
                end
            else
                ImageEditing.Move = vec2(
                    ImageEditing.Move.x + t.deltaX,
                    ImageEditing.Move.y + t.deltaY
                )
            end
            return
        end
    else
        for a, b in ipairs(ImageEditing.NonEdit) do
            b:touched(t)
        end
    end
end

--[[function ImageEditing.FillFunction(x, y, c)
    local w, h = spriteSize(ImageEditing.Image)
    if not (
        x >= 1 and
        y >= 1 and
        x <= w and
        y <= h
    ) then
        return
    end
    
    
    if not ( ImageEditing.Image:get(math.floor(x), math.floor(y)) == c ) then
        return
    else
        ImageEditing.Image:set(math.floor(x), math.floor(y), ImageEditing.Edit.FGColor)
        
        --if x >= 1 then
        ImageEditing.FillFunction(x-1, y, c)
        --end if x <= w then
        ImageEditing.FillFunction(x+1, y, c)
        --end if y >= 1 then
        ImageEditing.FillFunction(x, y-1, c)
        --end if y <= w then
        ImageEditing.FillFunction(x, y+1, c)
        --end
    end
end]]

function ImageEditing.CloseSubTabs()
    ImageEditing.isShowing.ColorPick = false
    ImageEditing.isShowing.SizePick = false
    ImageEditing.isShowing.FigurePick = false
    ImageEditing.isShowing.FileOptions = false
    ImageEditing.isShowing.ImageSize = false
end

function ImageEditing.K(key)
    for a, b in ipairs(ImageEditing.NonEdit) do
        b:keyboard(key)
    end
end

function ImageEditing.SaveImage()
    ImageEditing.CloseSubTabs()
    if ImageEditing.SaveState == "//new" then
        ImageEditing.Saving1 = true
    elseif ImageEditing.SaveState == "//saved" then
        IO.Save(ImageEditing.Id, IMAGE, ImageEditing.Image)
        ImageEditing.Saved = true
        Lobby.I()
    end
end

function ImageEditing.CreateNew(w, h, t)
    if t == "simple" then
        local a = false
        local b = false
            
        if w == "" then
            ImageEditing.NonEdit[1].error = true
            a = true
        elseif w == "0" then
            ImageEditing.NonEdit[1].error = true
            b = true
        else
            ImageEditing.NonEdit[1].error = false
        end
            
        if h == "" then
            ImageEditing.NonEdit[2].error = true
            a = true
        elseif h == "0" then
            ImageEditing.NonEdit[2].error = true
            b = true
        else
            ImageEditing.NonEdit[2].error = false
        end
                        
        if a then
            ImageEditing.NonEditError = "Width or height of image do not exist!"
        elseif b then
            ImageEditing.NonEditError = "Width or height of image is 0! This is not allowed!"
        else
            ImageEditing.Image = image(w, h)
            setContext(ImageEditing.Image)
            background(255)
            setContext()
            
            ImageEditing.Name = "Untitled Work"
            ImageEditing.Move = vec2(0, 0)
            ImageEditing.Edit.FGColor = color(255, 0, 0)
            ImageEditing.SaveState = "//new"
            
            ImageEditing.IsEdit = true
        end
    elseif t == "camera" then
        local a, b = spriteSize(CAMERA)
        ImageEditing.Image = image(a, b)
        setContext(ImageEditing.Image)
        sprite(CAMERA, a*.5, b*.5, a, b)
        setContext()
            
        ImageEditing.Name = "Untitled Camera"
        ImageEditing.Move = vec2(0, 0)
        ImageEditing.Edit.FGColor = color(255)
        ImageEditing.SaveState = "//new"
            
        ImageEditing.IsEdit = true
    end
end



--# TextEdit
TextEditing = {}

function TextEditing.I()
    -- Page Settings
    TextEditing.Page = 3
    
    -- Data
    TextEditing.Data = {}
    TextEditing.Data.Text = [[]]
    TextEditing.Data.Name = "Georg Washington"
end

function TextEditing.D()
    global.header(TextEditing.Data.Name .. " [TextDoc]")
    
end

--# Lobby

Lobby = {}

function Lobby.I()
    -- Page Settings
    Lobby.Page = 1
    
    -- Data
    Lobby.Data = {}
    Lobby.Data.BackGround = mesh()
    Lobby.Data.BackGround.texture = "Cargo Bot:Game Area"
    Lobby.Data.BackGround.shader = shader("Filters:Radial Blur")
    Lobby.Data.BackGroundRects = Lobby.Data.BackGround:addRect(0, 0, 0, 0)
    
    local l = IO.listData()
    Lobby.Data.Projects = {}
    Lobby.Data.ProjectsHold = 0
    
    for a, b in ipairs(l) do
        --print(b[1])
        --local z = IO.Read(b[1], b[2])
        
        --[[table.insert(Lobby.Data.Projects, {
            id = b[1],     -- Project Id
            type = b[2],   -- Type: IMAGE, ...
            content = z    -- Saved content
        })]]
        Lobby.Data.Projects[a] = {}
        Lobby.Data.Projects[a].id = b[1]
        Lobby.Data.Projects[a].type = b[2]
        Lobby.Data.Projects[a].content = IO.Read(b[1], b[2])
        --local w, h = spriteSize(Lobby.Data.Projects[a].content)
        --print(w, h)
    end

    --Lobby.Data.BackGroundTimer = 15 -- Replaced with sin and ElapsedTime
    --Lobby.Data.BackGroundTimerIncrease = false
    
    Lobby.Data.CreateNew = {
        --[[UI.Button({
            x = 30, y = HEIGHT-60, w = 250, h = 40, fs = 20,
            act = function() global.pageNow = SlideShow.Page end,
            text = "Slideshow"
        }),]]
    
        UI.Button({
            x = 30, y = HEIGHT-100, w = 250, h = 40, fs = 30,
            act = function() global.pageNow = ImageEditing.Page end,
            text = "Image"
        }),
        UI.Button({
            x = 30, y = HEIGHT-140, w = 250, h = 40, fs = 30,
            act = function() global.pageNow = TextEditing.Page end,
            text = "Text Doc"
        })
    }
    
    --[[
    Example of "listdata"
    
    List Data: [8 Item(s)]
    {7,1;9,1;10,1;11,1;15,1;20,1;21,1;22,1}
    
    ]]
    --saveLocalData("listdata", "{}") in case Projects currently made had save bug. Do not use if you don't want to lose projects.
    
    Lobby.Data.TranslateY = 0
end

function Lobby.D()
    Lobby.Data.BackGround:setRect(Lobby.Data.BackGroundRects, WIDTH*.5, HEIGHT*.5, WIDTH, HEIGHT)
    Lobby.Data.BackGround.shader.sampleDist = 2.2
    Lobby.Data.BackGround.shader.sampleStrength = math.sin(ElapsedTime)
    Lobby.Data.BackGround:draw()
    
    --[[if Lobby.Data.BackGroundTimerIncrease then
        Lobby.Data.BackGroundTimer = Lobby.Data.BackGroundTimer + 1
        if Lobby.Data.BackGroundTimer >= 150 then
            Lobby.Data.BackGroundTimerIncrease = false
        end
    else
        Lobby.Data.BackGroundTimer = Lobby.Data.BackGroundTimer - 1
        if Lobby.Data.BackGroundTimer <= 0 then
            Lobby.Data.BackGroundTimerIncrease = true
        end
    end]]
    
    fill(255)
    font(UI.Data.Font1)
    fontSize(25)
    local a, b = textSize("Create new")
    text("Create new", 30 + a/2, HEIGHT-30-b/2)
    
    for a, b in ipairs(Lobby.Data.CreateNew) do
        b:draw()
    end
    
    resetStyle()
    translate(0, Lobby.Data.TranslateY)
    for a, b in ipairs(Lobby.Data.Projects) do
        --print(b.type)
        local x = a
        local y = 0
        while (x >= 4) do
            x = x - 3
            y = y + 1
        end
        fill(0, 150)
        if Lobby.Data.ProjectsHold == a then
            fill(255, 150)
        end
        strokeWidth(5)
        if b.type == IMAGE .. "" then
            stroke(0, 255, 255)
        end
        rect(100 + x * 220, HEIGHT - (y+1) * 220, 200, 200)
        if b.type == IMAGE .. "" then
            local w, h = spriteSize(b.content)
            --print(w, h)
            --assert(false, "Breakpoint. ...")
            if w > h then
                sprite(b.content, 200 + x * 220, HEIGHT + 100 - (y+1) * 220, math.min(w, 190))
            elseif w == h then
                sprite(b.content, 200 + x * 220, HEIGHT + 100 - (y+1) * 220, 190, 190)
            elseif w < h then
                sprite(b.content, 200 + x * 220, HEIGHT + 100 - (y+1) * 220, w * math.min(w, 190)/w, math.min(h, 190))
            end
        end
    end
    
    --saveLocalData("listdata", "{23,1;24,1}")
    --sprite("Project:T_T.7", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT) Bug: saveImage/readImage doesn't support "." charachter.
    
    local a = #Lobby.Data.Projects
    local b = 0
    while a >= 4 do
        b = b + 1
        a = a - 3
    end
    local max = (b-2.25) * 200
    
    if Lobby.Data.TranslateY <= 0 then
        Lobby.Data.TranslateY = 0
    elseif Lobby.Data.TranslateY >= max then
        Lobby.Data.TranslateY = max
    end
end

function Lobby.T(t)
    for a, b in ipairs(Lobby.Data.CreateNew) do
        b:touched(t)
    end
    
    for a, b in ipairs(Lobby.Data.Projects) do
        local x = a
        local y = 0
        while (x >= 4) do
            x = x - 3
            y = y + 1
        end
        
        --rect(100 + x * 220, HEIGHT - (y+1) * 220, 200, 200)
        local m = Lobby.Data.TranslateY
        if t.x > 100+x*220 and t.x < 300+x*220 and t.y > HEIGHT-(y+1)*220+m and t.y < HEIGHT-(y+1)*220+200+m then
            if t.state == BEGAN then
                Lobby.Data.ProjectsHold = a
                --print(b.id)
            elseif t.state == ENDED then
                if Lobby.Data.ProjectsHold == a then
                    if b.type == IMAGE .. "" then
                        global.pageNow = ImageEditing.Page
                        --print(Lobby.Page, ImageEditing.Page)
                        draw()
                        
                        ImageEditing.IsEdit = true
                        ImageEditing.Id = b.id
                        ImageEditing.SaveState = "//saved" -- Not new
                        --ImageEditing.Saving1 = false
                        ImageEditing.Saved = true
                        ImageEditing.Image = b.content
                        ImageEditing.Name = "Unnamed Project"
                        ImageEditing.Lock = true
                        
                        -- Init
                        ImageEditing.Zoom = 1
                        ImageEditing.Move = vec2(0, 0)
                    end
                        
                    Lobby.Data.ProjectsHold = 0
                    return
                end
            end
            
            --print(b.id)
            --return
        else
            if Lobby.Data.ProjectsHold == a then
                Lobby.Data.ProjectsHold = 0
            end
            --return
        end
    end
    
    if #Lobby.Data.Projects > 9 then
        Lobby.Data.TranslateY = Lobby.Data.TranslateY + t.deltaY 
        local a = #Lobby.Data.Projects
        local b = 0
        while a >= 4 do
            b = b + 1
            a = a - 3
        end
        local max = (b-2.25) * 200
        
        if Lobby.Data.TranslateY <= 0 then
            Lobby.Data.TranslateY = 0
        elseif Lobby.Data.TranslateY >= max then
            Lobby.Data.TranslateY = max
        end
    end
end

--# Main

--[[
Project 'LibreRemake'
Project Name:   Untitled
Project Author: Anatoly W.
Project Since:  27-08-2017
]]

--[[
File List
*********

Lobby [All created Files located here, enterPage]
ImageEdit [Image Editings located here, editPage]
UI, global [User Interface of Project and global values]
IO [Saves Data]
]]

function setup()
    -- File Inititials
    UI.I()
    glob()
    Lobby.I()
    ImageEditing.I()
    TextEditing.I()
    --SlideShow.I()
    
    local l = IO.listData()
    print("List Data: [" .. #l .. " Item(s)]\n\nHold below to get\nreadLocalData(\"listdata\")")
    print('"' .. readLocalData("listdata") .. '"')
end

function draw()
    background(0)
    resetStyle()
    resetMatrix()
    if global.pageNow == Lobby.Page then
        Lobby.D()
    elseif global.pageNow == ImageEditing.Page then
        ImageEditing.D()
    elseif global.pageNow == TextEditing.Page then
        TextEditing.D()
    --[[elseif global.pageNow == SlideShow.Page then
        SlideShow.D()]]
    end
    
    if not ( global.pageNow == global.p ) then
        global.p = global.pageNow
        Lobby.I()
        ImageEditing.I()
        --SlideShow.I()
    end
end

function touched(touchData)
    if global.pageNow == Lobby.Page then
        Lobby.T(touchData)
    elseif global.pageNow == ImageEditing.Page then
        ImageEditing.T(touchData)
    elseif global.pageNow == TextEditing.Page then
        TextEditing.T(touchData)
    --[[elseif global.pageNow == SlideShow.Page then
        SlideShow.T(touchData)]]
    end
end

function keyboard(key)
    if global.pageNow == ImageEditing.Page then
        ImageEditing.K(key)
    end
end


