
--# Client
Client = {}
Client.Data = {}

function Client.Init()
    Client.Data.Items = {}
    Client.Data.Uploads = 0
    Client.Data.UploadsTotal = 0
    Client.Data.Page = 1
    Client.Data.User = {}
    Client.Data.UserId = 0
    Client.Data.LoadTime = 0
    --[[
    * "empty"
        
    * "p", id, amount
        . = data table
    
    WEAPON
        .stat [Statistics ( More at Connection.GetInv() )]
        .upgrade [Level, which currently has been added to the weapon]
    ]]
    Client.Data.Inv = {
        {
            {"empty"},
            {"empty"},
            {"empty"},
            {"empty"},
            {"empty"}
        }
    }
    
    Client.Data.ListItems = {
        
    }
end

--# UserInterface
UI = {}

-- Navigation Buttons

UI.NavButton = class()

function UI.NavButton:init(t)
    self.img = t.img or NULL
    self.img2 = t.imgHold or t.img or NULL
    self.act = t.action or function() end
    self.x, self.y = t.x or 0, t.y or 0
    self.hold = false
    self.text = t.txt or ""
    self.w, self.h = t.w or 0, t.h or 0
end

function UI.NavButton:draw()
    spriteMode(CENTER)
    local a = NULL
    if type(self.img) == "string" then
        a = Client.Data.Items[self.img]
        if (self.w == 0) or (self.h == 0) then
            self.w = a.width
            self.h = a.height
        end
        
        if self.hold then
            sprite(Client.Data.Items[self.img2], self.x, self.y, self.w, self.h)
        else
            sprite(Client.Data.Items[self.img], self.x, self.y, self.w, self.h)
        end
    else
        a = self.img
        if (self.w == 0) or (self.h == 0) then
            self.w = a.width
            self.h = a.height
        end
        sprite(self.img, self.x, self.y, self.w, self.h)
    end
    
    fill(255, 255, 255, 255)
    fontSize(self.h*.75)
    textWrapWidth(self.w)
    font("Arial-BoldMT")
    text(self.text, self.x --[[+ self.w/2]], self.y --[[+ self.h/2]])
end

function UI.NavButton:touched(t)
    local a
    if type(self.img) == "string" then
        a = Client.Data.Items[self.img]
    else
        a = self.img
    end
    w, h = a.width, a.height
    if t.x > self.x-w/2 and t.x < self.x+w/2 and t.y > self.y-h/2 and t.y < self.y+h/2 then
        if t.state == BEGAN then
            self.hold = true
        elseif t.state == ENDED and self.hold then
            self.hold = false
            self.act()
        end
    else
        self.hold = false
    end
end

-- Window

UI.Window = class()

function UI.Window:init(t)
    self.show = true
    self.title = "New Tab"
    self.canClose = true
    
    self.lib = {}
    self.lib.close = UI.NavButton({x = WIDTH-100, y = HEIGHT-75, img="ui_exit1", imgHold="ui_exit2"})
    self.lib.close.act = function()
        self:visible(false)
    end
    
    self.d = function(d)
        return d
    end
    
    self.t = function(t, d)
        return d
    end
    
    self.funcData = {}
end

function UI.Window:draw()
    if self.show then
        resetStyle()
        sprite(Client.Data.Items["ui_window"], WIDTH*.5, HEIGHT*.5, WIDTH-100, HEIGHT-100)
        fontSize(15)
        font("Arial-BoldMT")
        fill(255)
        local w, h = textSize(self.title)
        text(self.title, 75 + w/2, HEIGHT-75)
        
        if self.canClose then
            self.lib.close:draw()
        end
        
        if self.d then
            self.funcData = self.d(self.funcData)
        end
    end
end

function UI.Window:visible(t)
    if t == nil then
        return self.show
    else
        self.show = t
    end
end

function UI.Window:setName(name)
    while string.sub(name, 1, 1) == " " do
        name = string.sub(name, 2, #name)
    end
    self.title = name or "Untitled Window"
end

function UI.Window:touched(t)
    if self.show then
        if self.canClose then
            self.lib.close:touched(t)
        end
        
        if self.t then
            local n = {}
            
            -- Variables
            n.x = t.x
            n.y = t.y
            n.state = t.state
            
            -- Functions
            --[[
            n.inCircle = function(pos, rad)
                if (t.x-pos.x ^ 2) + (t.y-pos.y) ^ 2 <= rad ^ 2 then
                    return true
                end
                return false
            end]]
            
            self.funcData = self.t(n, self.funcData)
        end
    end
end

-- Functions

function UI.GetLevel()
    local b = {"level_001", "level_002", "level_003", "level_004", "level_005", "level_006", "level_007", "level_008", "level_009", "level_010"}
    local a = Client.Data.User.level
    
    return Client.Data.Items[b[a]]
end





--# Connection
Connection = {}

function Connection.GetLobbyData()
    -- All Items the Inventar can have.
    --[[
    Every Table contains:
      • Int DataHost String ImgPublicName, String ImgId
    ]]
    local local_items = {
        -- Items, Icons, UI
        {1, "XaR4vEe.png", "inv_i_chest"},
        {1, "uFjX6hc.png", "inv_w_darkblade"},
        {1, "CnWXgi1.png", "inv_w_darkblade1"},
        {1, "htxeuzy.png", "inv_w_galactic"},
        {1, "Zz8Nc99.png", "inv_w_knife"},
        {1, "nKBNnwr.png", "inv_w_rocket"},
        {1, "U98LYIn.png", "inv_ar_bloodsphere"},
        {1, "qXIOxEO.png", "inv_ar_bloodsphere1"},
        {1, "xzPyEtH.png", "i_energy_stone"},
        
        {1, "CCAUhPB.png", "o_silverdoor"},
        {1, "OD8uRVO.png", "o_backpack"},
        {1, "lGgwJzi.png", "o_mission"},
        {1, "xyYVMRX.png", "o_empty_inv"},
        
        {1, "uYzQ6I6.png", "ui_exit1"},
        {1, "2HJMRx3.png", "ui_exit2"},
        {1, "upqiY7c.png", "ui_window"},
        
        -- Weapon
        {1, "fKXcMtF.png", "wpn_level_1"},
        {1, "x2wLCGu.png", "wpn_level_2"},
        {1, "6r5Ekyc.png", "wpn_level_3"},
        
        {1, "YW8Nmn9.png", "wpn_galactic"},
        {1, "FTTgPbH.png", "wpn_knife"},
        {1, "XKyidHB.png", "wpn_knifeG"}, -- Golden knife
        {1, "Ihj83F8.png", "wpn_darkblade"},
        {1, "oHBC0nC.png", "wpn_darkblade1"},
        {1, "P8rMCWx.png", "wpn_rocket"},
        {1, "9Lz9SOv.png", "ar_bsphere"},
        
        -- Maps, Textures, BG
        {1, "TAAskpk.png", "map_m_lava"},
        
        {1, "6anRuHC.png", "map_t_lava"},
        
        {1, "mQZObpF.png", "bg_thunder"},
    
        -- Levels
        {1, "dbl45Zn.png", "level_001"},
        {1, "vV5CqQD.png", "level_002"},
        {1, "cc7fEAX.png", "level_003"},
        {1, "QWTqdEk.png", "level_004"},
        {1, "fpZrmUb.png", "level_005"},
        {1, "PapWDtO.png", "level_006"},
        {1, "FXGMu1f.png", "level_007"},
        {1, "xxIt7dx.png", "level_008"},
        {1, "MmG6vuB.png", "level_009"},
        {1, "hNihxSH.png", "level_010"},
        
        -- Auras
        {1, "iCUFYJY.png", "aura_1"},
        {1, "LefyBpO.png", "aura_2a"},
        {1, "9QDJcuq.png", "aura_2b"},
        {1, "HEy8nid.png", "aura_3a"},
        {1, "wuMsFor.png", "aura_3b"}
    }
    
    local local_hosts = {
        [1] = "i.imgur.com"
    }
    
    -- Get them all
    for a, b in ipairs(local_items) do
        Client.Data.Uploads = Client.Data.Uploads + 1
        Client.Data.UploadsTotal = Client.Data.UploadsTotal + 1 or 1
        local link = "http://" .. local_hosts[b[1]] .. "/" .. b[2]
        http.request(link,
        -- Success
        function(data, status, headers)
            Client.Data.Items[b[3]] = data
            Client.Data.Uploads = Client.Data.Uploads - 1
            if Client.Data.Uploads < 1 then
                Client.isLoading = false
            end
            print("Connection.GetLobbyData()\n\nPackage '" .. b[3] .. "'\n" .. link .. "\nInstalled!")
        end,
        -- Failure
        function(err)
            print("Connection.GetLobbyData()\n\nPackage '" .. b[3] .. "'\n" .. link .. "\nFailed to upload!")
        end)
    end
end

function Connection.ConnectWith(user, password)
    user = string.lower(user)
    if (user == "anatoly") and (password == "abc123") then
        -- LoggedIn?, UserId, Data[]
        return {true, 1, {
            level = 1,
            levelExperience = 0,
            money = 450000
        }}
    else
        -- LoggedIn?, Error
        return {false, "Wrong username or password!"}
    end
end

function Connection.GetInv()
    local v = {}
    
    local w = 12
    local h = 13
    
    for y = 1, h do
        v[y] = {}
        for x = 1, w do
            v[y][x] = {"empty"}
        end
    end
    
    v[1][1] = {"p", 2, 1}
    v[1][1].stat = {}
    v[1][1].stat.rad_dmg = 100
    v[1][1].stat.pow = 100
    v[1][1].stat.life = 1000
    v[1][1].stat.nrg = 10 
    v[1][1].upgrade = 3
    v[1][2] = {"p", 3, 100}
    
    return v
end

function Connection.ItemList()
    --[[
    ********** FORMATTING **********
    [id] = {type, name, data}
    
    ********** WEAPON STATISTICS **********
    rad_dmg [Map-Damage radius] (UPD: 5, 10, 15, 20, 25)
    pow [Default Power] (UPD: 10, 25, 50, 100, 250)
    life [Adds to default lifes] (UPD: 500, 1000, 2500, 5000, 10000)
    nrg [Adds to energy, which is required to move and use powerups] (UPD: 2, 5, 7, 10, 12)
    
    ********** TYPES & DATA **********
    col [Maximal to collect per INV item]
    
    wp [Weapon]
        look_inv_A [Inventar Mini-icon Level 00-02]
        look_obj_A [Game icon A]
        obj_A_states [Statistics A]
        look_inv_B [Inventar Mini-icon Level 03]
        look_obj_B [Game icon B]
        obj_B_states [Statistics B]
    
    arti [Weapon, Artifact]
        look_inv [Permament look]
        look_obj [Permament Object]
        states [Optional states]
        reg [Points, healing effect]
    
    i [Item]
        type [TYPES]
        
        1 [Addition to Weapon Upgrades]
            pnt [Points, how much will be added to the weapon upgrade]
            look []
    ]]
    
    Client.Data.ListItems = {
        [1] = {"wp", "Knife", {
            col = 1,
            --*--
            look_inv_A = "inv_w_knife",
            look_obj_A = "wpn_knife",
            obj_A_states = {
                rad_dmg = 100,
                pow = 100,
                life = 1000,
                nrg = 15
            },
            --*--
            look_inv_B = "inv_w_knife",
            look_obj_B = "wpn_knifeG",
            obj_B_states = {
                rad_dmg = 150,
                pow = 250,
                life = 1500,
                nrg = 20
            }
        }},
        [2] = {"wp", "☆ Darkblade", {
            col = 1,
            --*--
            look_inv_A = "inv_w_darkblade",
            look_obj_A = "wpn_darkblade",
            obj_A_states = {
                rad_dmg = 350,
                pow = 1000,
                life = 15000,
                nrg = 35
            },
            --*--
            look_inv_B = "inv_w_darkblade1",
            look_obj_B = "wpn_darkblade1",
            obj_B_states = {
                rad_dmg = 500,
                pow = 1500,
                life = 25000,
                nrg = 50
            }
        }},
        [3] = {"i", "Energy Stone", {
            col = 999,
            look = "i_energy_stone",
            --*--
            type = 1,
            pnt = 1
        }},
        [4] = {"wp", "☆ Rocket", {
            col = 1,
            --*--
            look_inv_A = "inv_w_rocket",
            look_obj_A = "wpn_rocket",
            obj_A_states = {
                rad_dmg = 150,
                pow = 250,
                life = 1500,
                nrg = 20
            },
            --*--
            look_inv_B = "inv_w_rocket",
            look_obj_B = "wpn_rocket",
            obj_B_states = {
                rad_dmg = 200,
                pow = 500,
                life = 2500,
                nrg = 25
            }
        }},
        [5] = {"arti", "Blood Sphere", {
            look_inv = "inv_ar_bloodsphere",
            look_obj = "ar_bsphere",
            reg = 500,
            states = {
                life = 500,
                nrg = 5
            }
        }},
        [6] = {"arti", "☆ Blood Sphere", {
            look_inv = "inv_ar_bloodsphere1",
            look_obj = "ar_bsphere",
            reg = 1000,
            states = {
                life = 1000,
                nrg = 10,
                rad_dmg = 5
            }
        }}
    }
end

--[[ Fun fact: Was create before GetInv, but was forgotten.
function Connection.GetInventar()
    local t = {}
    return {}
end]]

--# Main


function setup()
    displayMode(OVERLAY)
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_ANY)
    NULL = image(1, 1)
    
    -- Client Operations
    Client.Init()
    Client.isLoading = true
    
    Connection.GetLobbyData()
    Connection.ItemList()
    Client.Data.Inv = Connection.GetInv()
    Lobby.Init()
    
    RetryButton = UI.NavButton({x = WIDTH/2, y = HEIGHT*.66-150, img = readImage("Cargo Bot:Dialogue Box"), txt = "Reload", w = 250, h = 70, act = function() restart() end})
    
    -- Connect
    local a = Connection.ConnectWith("anatoly", "abc123")
    local b = a[2]
    if a[1] then
        print("Connection.ConnectWith()\n\nBecame user '" .. b --[[User Id]] .. "'")
        Client.Data.UserId = b
        Client.Data.User = a[3]
    else
        print("Connection.ConnectWith()\n\nCannot get User:\n" .. b --[[Error]])
    end
end

function draw()
    background(0, 0, 0, 255)
    if Client.Data.Uploads > 0 then
        sprite(Client.Data.Items["bg_thunder"] or NULL, WIDTH*.5, HEIGHT*.5, WIDTH, HEIGHT)
        font("Arial-BoldMT")
        fontSize(50)
        fill(255, 255, 255, 255)
        text("Loading!", WIDTH*.5, HEIGHT*.60)
        fontSize(35)
        text("Please, wait!", WIDTH*.5, HEIGHT*.60 - 50)
        fontSize(20)
        text("Operation " .. (Client.Data.UploadsTotal-Client.Data.Uploads) .. "/" ..
                                                            Client.Data.UploadsTotal, WIDTH/2, HEIGHT*.4)
        
        Client.Data.LoadTime = Client.Data.LoadTime + 1
        
        if Client.Data.LoadTime >= 100 then
            RetryButton:draw()
        end
    else
        if Client.Data.Page == Lobby.Page then
            Lobby.Update()
        end
    end
end

function touched(t)
    if (Client.Data.LoadTime >= 100) and (Client.Data.Uploads > 0) then
        RetryButton:touched(t)
    end
    if Client.Data.Page == Lobby.Page then
        Lobby.Touch(t)
    end
end

--# P_Lobby
Lobby = {}

function Lobby.Init()
    -- General
    Lobby.Page = 1
    Lobby.Version = "v0.0.01"
    
    -- Optional
    Lobby.Data = {}
    Lobby.Data.NavButtons = {
        UI.NavButton({x = WIDTH-50, y = 50, img = "o_silverdoor", action = function() close() end}),
        UI.NavButton({x = WIDTH-100, y = 50, img = "o_backpack", action = function() Lobby.BackPack:visible(true) end}),
        UI.NavButton({x = WIDTH-150, y = 50, img = "o_mission", action = function() end})
    }
    
    Lobby.BackPack = UI.Window()
    Lobby.BackPack:visible(false)
    Lobby.BackPack:setName("Backpack")
    Lobby.BackPack.d = function(r)
        Lobby.UserProfile(70, 80)
        for y, tab in ipairs(Client.Data.Inv) do
            for x, val in ipairs(tab) do
                sprite(Client.Data.Items["o_empty_inv"], WIDTH-55-45*x, HEIGHT-80-45*y)
                
                if val[1] == "p" and Client.Data.ListItems[val[2]] then
                    if Client.Data.ListItems[val[2]][1] == "wp" then -- Weapons
                        local i = ""
                        
                        if val.upgrade >= 0 and val.upgrade <= 2 then
                            i = Client.Data.ListItems[val[2]][3].look_inv_A
                        elseif val.upgrade == 3 then
                            i = Client.Data.ListItems[val[2]][3].look_inv_B
                        end
                        
                        if Client.Data.Items[i] then
                            sprite(Client.Data.Items[i], WIDTH-54-45*x, HEIGHT-80-45*y, 41, 41)
                        end
                    elseif Client.Data.ListItems[val[2]][1] == "i" then -- Items
                        local i = Client.Data.ListItems[val[2]][3].look
                        if Client.Data.Items[i] then
                            sprite(Client.Data.Items[i], WIDTH-54-45*x, HEIGHT-80-45*y, 41, 41)
                        end
                        
                        if val[3] >= 2 and Client.Data.ListItems[val[2]][3].col >= 2 then
                            fill(500)
                            font("Arial-BoldMT")
                            fontSize(12)
                            local str = val[3] .. ""
                            local o,p = textSize(str)
                            text(str, WIDTH-35-45*x-o/2, HEIGHT-95-45*y)
                        end
                    end
                end
            end
        end
        
        -- Update
        return r
    end Lobby.BackPack.t = function(t, r)
        
        -- Update
        return r
    end
    
    Lobby.Time = 0
end

function Lobby.Update()
    Lobby.Time = Lobby.Time + 1
    Lobby.BG()
    
    resetStyle()
    for a, b in ipairs(Lobby.Data.NavButtons) do
        b:draw()
    end
    
    Lobby.UserProfile(20, 20)
    ------------------------------- Windows -------------------------------
    Lobby.BackPack:draw()
end

function Lobby.Touch(t)
    if Lobby.BackPack:visible() then
        Lobby.BackPack:touched(t)
    else
        for a, b in ipairs(Lobby.Data.NavButtons) do
            b:touched(t)
        end
    end
end

function Lobby.UserProfile(x, y)
    translate(x or 0, y or 0)
    ------------------------------- User -------------------------------
    resetStyle()
    fill(255, 255, 255, 255)
    strokeWidth(2)
    stroke(127, 127, 127, 255)
    rect(0, 0, 300, 430)
    
    -- Level
    sprite(UI.GetLevel(), 280, 410, 35)
    
    -- Aura
    translate(150, 215)
    rotate(Lobby.Time)
    sprite(Client.Data.Items["aura_1"], 0, 0, 200)
    resetMatrix()
end

function Lobby.BG()
    fill(53, 53, 53, 255)
    strokeWidth(0)
    rect(-1, -1, WIDTH, HEIGHT)
end
