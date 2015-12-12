
--# Main

usedPi = false
isNumber1 = true
number = 0
number2 = 0
drawing = true
answernumber = 0
mute = true
operation = "nil"

owner = "Anatoly W."

displayMode(OVERLAY)
displayMode(FULLSCREEN)
supportedOrientations(WIDTH)

function setup()
    -- This are fir temporary control
    parameter.watch("pasteboard.text")
    parameter.watch("number")
    parameter.watch("number2")
    parameter.watch("answernumber")
    parameter.watch("mute")
    --[[
    TextPanel
    Use this subnames:
    
    txt.value
    txt.color
    txt.textsize
    
    ]]
    txt = TextPanel("Start writing number by typing")
    
    -- The Information Page
    information = Info()
    news = News()
    logo = Logo()
    pnl = Panel()
    
    -- The Main Tag
    currentpage = information
    
    --[[
    Buttons
    Use this subnames:
    
    x, y, name, color
    
    ]]
    button1 = Button("1", 75, 75, function()
        calculator(1)
    end)
    button2 = Button("2", 150, 75, function()
        calculator(2)
    end)
    button3 = Button("3", 225, 75, function()
        calculator(3)
    end)
    button4 = Button("4", 75, 150, function()
        calculator(4)
    end)
    button5 = Button("5", 150, 150, function()
        calculator(5)
    end)
    button6 = Button("6", 225, 150, function()
        calculator(6)
    end)
    button7 = Button("7", 75, 225, function()
        calculator(7)
    end)
    button8 = Button("8", 150, 225, function()
        calculator(8)
    end)
    button9 = Button("9", 225, 225, function()
        calculator(9)
    end)
    buttonPLUS = Button("+", 375, 75, function()
        calculator("ans", "+")
    end)
    buttonMINUS = Button("-", 375, 150, function()
        calculator("ans", "-")
    end)
    buttonMULTIPLIE = Button("•", 450, 75, function()
        calculator("ans", "*")
    end)
    buttonDIVIDE = Button(":", 450, 150, function()
        calculator("ans", "/")
    end)
    buttonPI = Button("PI", 375, 225, function()
        calculator(math.pi)
        usedPi = true
    end)
    copytext = Button("Copy", 750, 75, function()
        pasteboard.copy("I copied in the math programm by " .. owner .. " and the answer was '".. answernumber .. "'")
    end)
    answerbutton = Button("=", 525, 225, function()
        answer()
    end)
    button0 = Button("0", 525, 150, function()
        calculator(0)
    end)
    clearbutton = Button("CE", 450, 225, function()
        calculator("ce")
    end)
    button00 = Button("00", 525, 75, function()
        calculator(00)
    end)
    soundmute = Button("🔈", 675, 75, function()
        soundmuting()
    end)
    stepeni = Button("Pow", 75, 375, function()
        calculator("ans", "^2")
    end)
    korni = Button("Root", 150, 375, function()
        calculator("ans", "sqrt")
    end)
    ceil = Button("~", 825, 75, function()
        calculator("ans", "ceil")
    end)
    infobutton = ActivateButton("About", 675, 150, function()
        currentpage = information
    end)
    bugsbutton = ActivateButton("News", 750, 150, function()
        currentpage = news
    end)
    logobutton = ActivateButton("Logo", 825, 150, function()
        currentpage = logo
    end)
    abs = Button("|-5|", 225, 375, function()
        calculator("ans", "abs")
    end)
    homepagegithub = Button("             Script (v1)", 675, 225, function()
        openURL("https://github.com/TokOut/calculator/tree/master/version-1-0", true)
    end, 150)
    panel = Button("                         Control Panel", 75, 450, function()
        currentpage = pnl
    end, 225)
    secondgithubpage = Button(" Main", 825, 225, function()
        openURL("https://github.com/TokOut/calculator/", true)
    end)
end

function draw()
    background(127, 127, 127, 255)
    button1:draw()
    button2:draw()
    button3:draw()
    button4:draw()
    button5:draw()
    button6:draw()
    button7:draw()
    button8:draw()
    button9:draw()
    button0:draw()
    buttonDIVIDE:draw()
    buttonMINUS:draw()
    buttonMULTIPLIE:draw()
    buttonPLUS:draw()
    buttonPI:draw()
    copytext:draw()
    txt:draw()
    answerbutton:draw()
    clearbutton:draw()
    soundmute:draw()
    button00:draw()
    stepeni:draw()
    korni:draw()
    ceil:draw()
    abs:draw()
    infobutton:draw()
    bugsbutton:draw()
    logobutton:draw()
    homepagegithub:draw()
    panel:draw()
    secondgithubpage:draw()
    
    -- The information page
    
    fill(255, 255, 255, 255)
    rect(375, 375, 525, 225)
    fill(0, 0, 0, 255)
    currentpage:draw()
end

function touched(t)
    button1:touched(t)
    button2:touched(t)
    button3:touched(t)
    button4:touched(t)
    button5:touched(t)
    button6:touched(t)
    button7:touched(t)
    button8:touched(t)
    button9:touched(t)
    button0:touched(t)
    buttonMINUS:touched(t)
    buttonMULTIPLIE:touched(t)
    buttonPLUS:touched(t)
    buttonDIVIDE:touched(t)
    buttonPI:touched(t)
    copytext:touched(t)
    answerbutton:touched(t)
    clearbutton:touched(t)
    soundmute:touched(t)
    button00:touched(t)
    stepeni:touched(t)
    korni:touched(t)
    ceil:touched(t)
    infobutton:touched(t)
    bugsbutton:touched(t)
    logobutton:touched(t)
    abs:touched(t)
    homepagegithub:touched(t)
    panel:touched(t)
    secondgithubpage:touched(t)
end

--# ActivateButton
ActivateButton = class()

function ActivateButton:init(name, x, y, action)
    if x == nil or y == nil then x = 0 y = 0 end
    if name == nil then name = "Nil" end
    if action == nil then action = function() print("Nil value for action!") end end
    
    self.x = x
    self.y = y
    self.name = name
    self.action = action
    self.color = color(255, 158, 0, 255)
    self.textcolor = color(0, 0, 0, 255)
end

function ActivateButton:draw()
    strokeWidth(1)
    fill(self.color)
    rect(self.x, self.y, 75, 75)
    font("AmericanTypewriter")
    fontSize(25)
    textMode(CENTER)
    fill(self.textcolor)
    text(self.name, self.x + 35, self.y + 35)
end

function ActivateButton:touched(t)
    if t.state == BEGAN and self:hit(vec2(t.y,t.x)) then
        if mute == false then
            sound(DATA, "ZgBAaT1ASEBAQEBAWkA+PW/XSj9lCNY+ZABAf0BAQEBAQEBA")
        end
        self.color = color(189, 255, 0, 255)
        self.action()
    else
        self.color = color(255, 158, 0, 255)
    end
    
    if t.state == ENDED then
        self.color = color(255, 158, 0, 255)
    end
end

function ActivateButton:hit(p)
    local t = self.x + 75
    local b = self.x - 1
    local l = self.y - 1
    local r = self.y + 75
    if p.x > l and p.x < r and p.y > b and p.y < t then
        return true
    end
        return false
end
--# Button
Button = class()

function Button:init(name, x, y, action, w)
    if x == nil or y == nil then
        x = 0
        y = 0
    end
    
    if name == nil then
        name = "Nil"
    end
    
    if action == nil then
        action = function() print("Using a Non-Function Button") end
    end
    
    if w == nil then
        w = 75
    end
    
    self.x = x
    self.y = y
    self.name = name
    self.action = action
    self.color = color(255, 255, 255, 255)
    self.textcolor = color(0, 0, 0, 255)
    self.w = w
end

function Button:draw()
    strokeWidth(1)
    fill(self.color)
    rect(self.x, self.y, self.w, 75)
    font("AmericanTypewriter")
    fontSize(25)
    textMode(CENTER)
    fill(self.textcolor)
    text(self.name, self.x + 35, self.y + 35)
end

function Button:touched(t)
    if t.state == BEGAN and self:hit(vec2(t.y,t.x)) then
        if mute == false then
            sound("A Hero's Quest:Arrow Shoot 1")
        end
        
        self.color = color(187, 187, 187, 255)
        self.action()
    else
        self.color = color(255, 255, 255, 255)
    end
    
    if t.state == ENDED then
        self.color = color(255, 255, 255, 255)
    end
end

function Button:hit(p)
    local t = self.x + self.w
    local b = self.x - 1
    local l = self.y - 1
    local r = self.y + 75
    if p.x > l and p.x < r and p.y > b and p.y < t then
        return true
    end
    return false
end

--# TextPanel
TextPanel = class()

function TextPanel:init(value)
    self.value = value
    self.color = color(183, 181, 181, 255)
    self.textsize = 50
end

function TextPanel:draw()
    fill(70, 70, 70, 255)
    rect(0, HEIGHT - 75, 1023.5, 75)
    fill(self.color)
    font("AcademyEngravedLetPlain")
    fontSize(self.textsize)
    text(self.value, WIDTH/2, HEIGHT - 50)
end

--# Function

--[[
    The Functionality of our calculator
    
    Made by TokOut
    Born: 26/01/2003
    Made since: 27/11/2015
    Made till: Non Value
]]


function calculator(key, key2)
        if key == "ce" then
            number = 0
            number2 = 0
            operation = "nil"
            isNumber1 = true
            usedPi = false
            txt.value = "0"
            drawing = false
        end
    
        if key == "ans" then
            print("Answer Status")
            number2 = number
            operation = key2
        
            if key2 == "+" then
                txt.value = number .. " + "
            elseif key2 == "-" then
                txt.value = number .. " - "
            elseif key2 == "*" then
                txt.value = number .. " • "
            elseif key2 == "/" then
                txt.value = number .. " : "
            elseif key2 == "^2" then
                txt.value = number .. " ^ "
            elseif key2 == "sqrt" then
                answer()
            elseif key2 == "ceil" then
                answer()
            elseif key2 == "abs" then
                answer()
            end
            drawing = false
            isNumber1 = false
            number = 0
            usedPi = false
        end
    
    if drawing == true then
        if isNumber1 == true then
            if usedPi == false then
                if number == 0 then
                    number = key
                    txt.value = number
                else
                    number = number .. key
                    txt.value = number
                end
            else
                number = 0
                usedPi = false
            end
        end
    
        if isNumber1 == false then
            if usedPi == false then
                if number == 0 then
                    number = key
                    txt.value = txt.value .. key
                else
                    number = number .. key
                    txt.value = txt.value .. key
                end
            else
                number = 0
                number2 = 0
                isNumber1 = true
                txt.value = "Error"
                usedPi = false
            end
        end
    end
    drawing = true
end

function answer()
    if operation == "+" then
        answernumber = number2 + number
        txt.value = txt.value .. " = " .. answernumber
    elseif operation == "-" then
        answernumber = number2 - number
        txt.value = txt.value .. " = " .. answernumber
    elseif operation == "/" then
        answernumber = number2 / number
        txt.value = txt.value .. " = " .. answernumber
    elseif operation == "*" then
        answernumber = number2 * number
        txt.value = txt.value .. " = " .. answernumber
    elseif operation == "^2" then
        answernumber = math.pow(number2, number)
        txt.value = txt.value .. " = " .. answernumber
    elseif operation == "sqrt" then
        txt.value = math.sqrt(number) .. " = " .. number .. " • " .. number
        answernumber = math.sqrt(number)
    elseif operation == "ceil" then
        txt.value = txt.value .. " ~~ " .. math.ceil(number2)
        answernumber = math.ceil(number2)
    elseif operation == "abs" then
        if number2 >= 1 then
            txt.value = "|" .. number2 .. "| = " .. 0 - math.abs(number2)
            answernumber = 0 - math.abs(number2)
        elseif number2 <= -1 then
            txt.value = "|" .. number2 .. "| = " .. math.abs(number2)
            answernumber = math.abs(number2)
        else
            -- Only 0
            txt.value = "0 (Actually its funny but 0 = 0)"
            number = 0
            number2 = 0
            answernumber = 0
            pasteboard.copy("In the math project by " .. owner .. ", I found out, that 0 = 0")
        end
    end
    if mute == false then
        sound("Game Sounds One:Bell 2")
    end
end

function soundmuting()
    if mute == true then
        mute = false
    else
        mute = true
    end
end

--# Panel
Panel = class()

function Panel:draw()
    
    if isNumber1 == true then
        isNumberBoalen = "true"
    else
        isNumberBoalen = "false"
    end
    
    if usedPi == true then
        PI = ""
    else
        PI = "not"
    end
    
    if mute == true then
        soundstate = "Off"
    else
        soundstate = "On"
    end
    
    fill(0, 0, 0, 255)
    font("AmericanTypewriter-Bold")
    fontSize(20)
    textMode(CORNER)
    text("Control Panel for Developers", 500, 565)
    fontSize(15)
    font("AmericanTypewriter")
    text("Number (1) is " .. number, 500, 550)
    text("Number (2) is " .. number2, 500, 535)
    text("Number (A) is " .. answernumber, 500, 520)
    text("Current Operation is << " .. operation .. ">>", 500, 495)
    text("Music is " .. soundstate, 500, 480)
    text("Extra", 500, 460)
    text("Number1 is now " .. isNumberBoalen, 500, 445)
    text("The Number Pi is currently " .. PI .. " used.", 500, 430)
end

--# Logo
Logo = class()

function Logo:draw()
    translate(637.5, 490)
    rotate(ElapsedTime*75)
    fill(48, 255, 0, 255)
    ellipse(5, 5, 220)
    fill(0, 255, 157, 255)
    rect(-58.5, -58.5, 130, 130)
    stroke(255, 255, 255, 255)
    strokeWidth(15)
    line(5, -45, 5, 56)
    line(55, 5, -45, 5)
end

--# Bugs
News = class()

function News:draw()
    fill(0, 0, 0, 255)
    font("AmericanTypewriter-Bold")
    fontSize(20)
    textMode(CORNER)
    text("News and Bugs", 590, 565)
    fontSize(15)
    font("AmericanTypewriter")
    text("NEW - Logo  is updated and with more effects and", 500, 540)
    text("the Control panels have been updated! 2.0!", 500, 525)
end

--# Info
Info = class()

function Info:draw()
    fill(0, 0, 0, 255)
    font("AmericanTypewriter-Bold")
    fontSize(20)
    textMode(CORNER)
    text("About "..owner, 590, 565)
    fontSize(15)
    font("AmericanTypewriter")
    text(owner .. " is an very new developer with Lua (Codea)", 500, 540)
    text("Born in Russia and live in Germany (EU). He came to", 500, 515)
    text("world at year 2003 in the 26th of the January.", 500, 500)
    text("This calculator is his first released project.", 500, 475)
    
    font("Baskerville-Italic")
    text("Quote: It is easy to programm, but nobody can", 500, 450)
    text("develop without mistakes. But they will get fixed!", 500, 435)
end
