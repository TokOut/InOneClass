
--# Pages
Page = Page or {}

Page.Intro = [[
<html>
  <head>
    <title>Welcome!</title>
  </head>
  <body>
    <h1>Welcome!</h1>
  </body>
</html>
]]

Page.Error = function(err)
    return [[
<html>
  <head>
    <title>Not accessible</title>
  </head>
  <body>
    <h1>Not accessible</h1>
    <p>]] .. err .. [[</p>
  </body>
</html>
    ]]
end

--# Tab
Tab = class()

function Tab:init(url)
    self.link = url
    self.body = "<html></html>"
    self.content = {}
end

function Tab:connect(url)
    self.link = url
    function suc(content)
        if type(content) == "string" then
            self.body = content
        end
        self:getBody()
    end
    
    function fail(error)
        self.body = Page.Error(error)
        self:getBody()
    end
    
    http.request(url, suc, fail)
end

function Tab:getBody()
    local s = self.body
    local v = {}
    
    self.content = v
end

function Tab:draw()
    
end

--# Head
Top = class()

function Top:init()
    self.tabs = {Tab("l://intro/newpage")}
    self.url = Text(50, HEIGHT-25, WIDTH-100, 30)
    self.url.ph = "Enter Webpage URL"
    self.url.action = function(txt) self.tabs[1]:connect(txt) end
end

function Top:draw()
    resetStyle()
    fill(200)
    rect(0, HEIGHT-50, WIDTH, 50)
    self.url:draw()
end

function Top:touched(t)
    self.url:touched(t)
end

function Top:keyboard(k)
    self.url:keyboard(k)
end

--# TextBox
Text = class()

function Text:init(x, y, w, h)
    self.x, self.y, self.w, self.h = x, y, w, h
    self.text = ""
    self.ph = ""
    self.selected = false
    self.action = function() end
end

function Text:draw()
    resetStyle()
    stroke(255)
    strokeWidth(self.h)
    lineCapMode(SQUARE)
    line(self.x, self.y, self.x + self.w, self.y)
    
    fontSize(self.h)
    font("ArialMT")
    if #self.text == 0 then
        fill(175)
        text(self.ph, self.x + self.w/2, self.y)
    else
        fill(0)
        text(self.text, self.x + self.w/2, self.y)
        
        if self.selected and os.time()%2 == 0 then
            stroke(50, 50, 200)
            strokeWidth(3)
            local a, b = textSize(self.text)
            line(self.x + self.w/2 + a/2, self.y-self.h/2, self.x + self.w/2 + a/2, self.y+self.h/2)
        end
    end
end

function Text:touched(t)
    if self:isTouched(t.x, t.y) then
        self.selected = true
        showKeyboard()
    else
        if self.selected and isKeyboardShowing() then
            hideKeyboard()
        end
        self.selected = false
    end
end

function Text:isTouched(x, y)
    if y > self.y - self.h/2 and y < self.y + self.h/2 then
        if x > self.x and x < self.x + self.w then
            return true
        end
    end
    return false
end

function Text:keyboard(k)
    if self.selected then
        if k == BACKSPACE then
            self.text = string.sub(self.text, 1, #self.text -1)
        elseif k == RETURN then
            self.action(self.text)
            hideKeyboard()
            self.selected = false
        else
            self.text = self.text .. k 
        end
    end
end

--# Main

function setup()
    displayMode(OVERLAY)
    top_navbar = Top()
end

function draw()
    background(0)
    top_navbar:draw()
end

function touched(t)
    top_navbar:touched(t)
end

function keyboard(k)
    top_navbar:keyboard(k)
end
