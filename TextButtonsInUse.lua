
    displayMode(OVERLAY)
    displayMode(FULLSCREEN)
    supportedOrientations(WIDTH)

    textpanel = ""

function setup()
    -- TextBoxButton("value", x, y, function() k("value") end)
    parameter.watch("textpanel")
    A = TextBoxButton("a", 75, 225, function() k("a") end)
    B = TextBoxButton("b", 150, 225, function() k("b") end)
    C = TextBoxButton("c", 225, 225, function() k("c") end)
    D = TextBoxButton("d", 300, 225, function() k("d") end)
    E = TextBoxButton("e", 375, 225, function() k("e") end)
    F = TextBoxButton("f", 450, 225, function() k("f") end)
    G = TextBoxButton("g", 525, 225, function() k("g") end)
    H = TextBoxButton("h", 600, 225, function() k("h") end)
    I = TextBoxButton("i", 675, 225, function() k("i") end)
    J = TextBoxButton("j", 750, 225, function() k("j") end)
    K = TextBoxButton("k", 825, 225, function() k("k") end)
    L = TextBoxButton("l", 900, 225, function() k("l") end)
    M = TextBoxButton("m", 75, 150, function() k("m") end)
    N = TextBoxButton("n", 150, 150, function() k("n") end)
    O = TextBoxButton("o", 225, 150, function() k("o") end)
    P = TextBoxButton("p", 300, 150, function() k("p") end)
    Q = TextBoxButton("q", 375, 150, function() k("q") end)
    R = TextBoxButton("r", 450, 150, function() k("r") end)
    S = TextBoxButton("s", 525, 150, function() k("s") end)
    T = TextBoxButton("t", 600, 150, function() k("t") end)
    U = TextBoxButton("u", 675, 150, function() k("u") end)
    V = TextBoxButton("v", 750, 150, function() k("v") end)
    W = TextBoxButton("w", 825, 150, function() k("w") end)
    X = TextBoxButton("x", 900, 150, function() k("x") end)
    Y = TextBoxButton("y", 75, 75, function() k("y") end)
    Z = TextBoxButton("z", 150, 75, function() k("z") end)
    dot = TextBoxButton(".", 450, 75, function() k(".") end)
    comma = TextBoxButton(",", 525, 75, function() k(",") end)
    space = TextBoxButton("", 225, 75, function() k(" ") end, 225)
    backspace = TextBoxButton("<—", 825, 75, function() k("back") end)
    doubledot = TextBoxButton(":", 675, 75, function() k(":") end)
    wm = TextBoxButton("!", 750, 75, function() k("!") end)
    say = TextBoxButton("Say!", 900, 75, function() k("say") end)
    qm = TextBoxButton("?", 600, 75, function() k("?") end)
    cl1 = TextBoxButton("(", 75, 300, function() k("(") end)
    cl2 = TextBoxButton(")", 150, 300, function() k(")") end)
    cs1 = TextBoxButton("[", 225, 300, function() k("[") end)
    cs2 = TextBoxButton("]", 300, 300, function() k("]") end)
    l = TextBoxButton("-", 375, 300, function() k("-") end)
    one = TextBoxButton("1", 450, 300, function() k("1") end)
    two = TextBoxButton("2", 525, 300, function() k("2") end)
    three = TextBoxButton("3", 600, 300, function() k("3") end)
    pi = TextBoxButton("PI", 675, 300, function() k("pi") end)
    dollar = TextBoxButton("$", 750, 300, function() k("$") end)
    prozent = TextBoxButton("%", 825, 300, function() k("%") end)
    slash = TextBoxButton("~", 900, 300, function() k("~") end)
    rr = TextBoxButton("<", 75, 375, function() k("<") end)
    lr = TextBoxButton(">", 150, 375, function() k(">") end)
    rct = TextBoxButton("#", 225, 375, function() k("#") end)
    star = TextBoxButton("*", 300, 375, function() k("⭐️") end)
    AND = TextBoxButton("&", 375, 375, function() k(" and ") end)
    pr = TextBoxButton('"', 450, 375, function() k('"') end)
    apostroph = TextBoxButton("'", 525, 375, function() k("'") end)
    is = TextBoxButton("=", 600, 375, function() k("=") end)
    euro = TextBoxButton("€", 675, 375, function() k("€") end)
    at = TextBoxButton("@", 750, 375, function() k("@") end)
    wc = TextBoxButton("WC", 825, 375, function() k("🚾") end)
    undo = TextBoxButton("🔙", 900, 375, function() k("undo") end)
end

function draw()
    background(0, 0, 0, 255)
    A:draw() B:draw() C:draw() D:draw() E:draw() F:draw() G:draw() H:draw() I:draw() J:draw()
    K:draw() L:draw() M:draw() N:draw() O:draw() P:draw() Q:draw() R:draw() S:draw() T:draw()
    U:draw() V:draw() W:draw() X:draw() Y:draw() Z:draw() dot:draw() comma:draw() space:draw()
    backspace:draw() doubledot:draw() wm:draw() say:draw() qm:draw() cl1:draw() cl2:draw()
    cs1:draw() cs2:draw() l:draw() one:draw() two:draw() three:draw() pi:draw() dollar:draw()
    prozent:draw() slash:draw() rr:draw() lr:draw() rct:draw() star:draw() AND:draw() pr:draw()
    apostroph:draw()  is:draw() euro:draw() at:draw() wc:draw() undo:draw()
        
    -- TextBox
    fill(255, 255, 255, 125)
    font("AmericanTypewriter")
    fontSize(75)
    text(textpanel, WIDTH/2, HEIGHT/2 + 200)
end

function touched(t)
    A:touched(t) B:touched(t) C:touched(t) D:touched(t) E:touched(t) F:touched(t) G:touched(t)  
    H:touched(t) I:touched(t) J:touched(t) K:touched(t) L:touched(t) M:touched(t) N:touched(t)
    O:touched(t) P:touched(t) Q:touched(t) R:touched(t) S:touched(t) T:touched(t) U:touched(t)
    V:touched(t) W:touched(t) X:touched(t) Y:touched(t) Z:touched(t) dot:touched(t)
    comma:touched(t) space:touched(t) backspace:touched(t) doubledot:touched(t) wm:touched(t)
    say:touched(t) qm:touched(t) cl1:touched(t) cl2:touched(t) cs1:touched(t) cs2:touched(t)
    l:touched(t) one:touched(t) two:touched(t) three:touched(t) pi:touched(t) dollar:touched(t)
    prozent:touched(t) slash:touched(t) rr:touched(t) lr:touched(t) rct:touched(t) star:touched(t)
    AND:touched(t) pr:touched(t) apostroph:touched(t) is:touched(t) euro:touched(t) 
    at:touched(t) wc:touched(t) undo:touched(t)
end

function k(key)
    speech.stop()
    if key == "back" then
        if textpanel == "" then
            speech.say("Nothing to clear!")
        else
            speech.say("The Text has been cleared!")
            textpanel = ""
        end
    elseif key == "say" then
        speech.say(textpanel)
        textpanel = ""
    elseif key == "pi" then
        speech.say("Pi")
        if textpanel == "" then
            textpanel = math.pi
        else
            textpanel = textpanel .. " 3.141592"
        end
    elseif key == "undo" then
        -- This process is inprogress
        speech.say("Hello to my textbox! In line 122 i didn't know how to create a backspace, so ask in forum for help. Thanks! Made by TokOut!")
    else
        speech.say(key)
        textpanel = textpanel .. key
    end
end

TextBoxButton = class()

function TextBoxButton:init(name, x, y, action, w, h)
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
    
    if h == nil then
        h = 75
    end
    
    self.x = x
    self.y = y
    self.name = name
    self.action = action
    self.color = color(255, 255, 255, 255)
    self.w = w
    self.h = h
end

function TextBoxButton:draw()
    fill(self.color)
    rect(self.x, self.y, self.w, self.h)
    fill(0, 0, 0, 255)
    font("AmericanTypewriter")
    fontSize(25)
    textMode(CENTER)
    text(self.name, self.x + 35, self.y + 35)
end

function TextBoxButton:touched(t)
    if t.state == BEGAN and self:hit(vec2(t.y,t.x)) then
        self.color = color(187, 187, 187, 255)
        self.action()
    else
        self.color = color(255, 255, 255, 255)
    end
    
    if t.state == ENDED then
        self.color = color(255, 255, 255, 255)
    end
end

function TextBoxButton:hit(p)
    local t = self.x + self.w
    local b = self.x - 1
    local l = self.y - 1
    local r = self.y + self.h
    if p.x > l and p.x < r and p.y > b and p.y < t then
        return true
    end
        return false
end
