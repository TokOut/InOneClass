
--# Server
Client = {}
Client.D = {}
Client.LoggedIn = {}

function Client.Login(_id, _name, _error)
    if _error then
        
    else
        Client.D.Id = _id
        Client.D.Name = _name
        
        -- Color
        for a, b in ipairs(Staff) do
            if b[1] == _id then
                if b[2] == "admin" then
                    Client.D.Col = UI.Colors.Admin
                elseif b[2] == "mod" then
                    Client.D.Col = UI.Colors.Mod
                else
                    Client.D.Col = UI.Colors.Member
                end
            end
        end
    end
end

Connection = {}

function Connection.Send(con, ...)
    print("Connection '" .. con .. "' send.")
    local arg = {...}
    if con == "clear" then
        -- "clear"
        Game.Handle("clear")
    elseif con == "god" then
        -- "god", on?
        Game.Handle("god", 0, arg[1])
    elseif con == "init" then
        if arg[1] == "Alpha" then
            -- "init", RoomHost, JoinedAs, MyPublicId, LayerFG, LayerBG, WorldTitle
            Game.Handle("init", "anatoly", "anatoly", "admin",
            {
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,87,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,87,0,0,0,0,0,0,0,1},
            {1,0,0,139,0,0,0,0,0,87,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,87,0,0,139,0,0,0,139,1},
            {1,32,32,33,31,31,33,31,33,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,42,
                    42,42,42,42,42,42,33,32,31,31,32,33,32,1},
            {1,31,31,32,33,31,31,31,31,32,31,32,33,33,31,32,31,33,31,31,31,33,31,32,32,31,
                    31,33,32,31,31,32,31,33,31,33,31,32,31,1},
            {1,33,32,31,31,31,31,31,33,31,31,32,32,33,31,31,32,33,31,31,31,33,32,31,31,32,
                    31,33,32,33,31,31,32,31,31,31,31,33,32,1}
            },
            {},
            "Alpha World"
            )
        end
    elseif con == "load" then
        -- "load"
        Game.Handle("load")
    elseif con == "s" then
        -- "s", playerId, smileyId
        Game.Handle("s", arg[1], arg[2])
    elseif con == "save" then
        
    elseif con == "say" then
        -- "say", playerId, message
        if string.sub(arg[1], 1, 1) == "/" then
            -- {command, function, receiveMessage or nil}
            local Args = {
                {"help", function(a,b) end, "Help:\n/help [Gives you all commands.]"},
                {"close", function(a,b) Game.Handle("kick", "System Kick", "The Room has been closed.") end, nil},
                {"clear", function(a,b) Game.Handle("clear") end, nil}
            }
            
            for a, b in ipairs(Args) do
                if string.sub(arg[1], 1, 1 + #b[1]) == "/" .. b[1] then
                    b[2](0, arg[1])
                    if not (b[3] == nil) then
                        Game.Handle("say", -1, b[3])
                    end
                end
            end
        else
            Game.Handle("say", arg[1], arg[2])
        end
    end
end

function Connection.LoginAs(email, password, error)
    local DataBase = {
        --Id: admin, beta_, simple_
        -- {id, email, password, username}
        {"admin", "weinstein.anatoly@gmail.com", "BE_2003@anatoly", "anatoly"},
        {"beta_fiIgUZ1d", "brick.edits.official@gmail.com", "batonas", "exco"},
        {"beta_q7FAuzp5", "doomester02@gmail.com", "nil", "doomester"},
        {"beta_PAq29m00", "", "", "orko"},
        {"beta_pQpWER17", "", "", "keken"}
    }
    
    local logged = false
    for a, b in ipairs(DataBase) do
        if (b[2] == email) and (b[3] == password) then
            Client.Login(b[1], b[4], nil)
            logged = true
        end
    end
    
    if not logged then
        Client.Login(nil, nil, "Can't login. User not existing. Email or password wrong.")
    end
end


--# Items

BlocksEmpty = {
    {-1, readImage("Project:b-0-empty"), 0},
    {0, readImage("Project:b-0-empty"), 1, "gravity", 0, -0.5}
}

-- Blocks
Blocks = {
    --{id, readImage(), layer, optional}
    -- Additional Data
    --[[
    "fixed"
            Solid Block.
    
    "fixed-colorize"
            Solid Block. But you can chose its hex-generated colorize
    
    "deco"
            Empty.
    
    "gravity", xSpeedModf, ySpeedModf
            Modify gravitation.
    
    "gravity-move", speedModificer
            Modify your speed of player.
    
    "key-block", classId, becameFixedBlock, Graphic
            Blocks, which switch layer on button click.
    
    "key-button", classId, time
            Buttons for "key-block".
            "time" are seconds till deactivation.
            Activation multiply times possible
    ]]
    
    -- Blocks

    {1, readImage("Project:b-1"), 1, "fixed"},
    {2, readImage("Project:b-2"), 1, "fixed"},
    {3, readImage("Project:b-3"), 1, "fixed"},
    {4, readImage("Project:b-4"), 1, "fixed"},
    {5, readImage("Project:b-5"), 1, "fixed"},
    {6, readImage("Project:b-6"), 1, "fixed"},
    {7, readImage("Project:b-7"), 1, "fixed"},
    {8, readImage("Project:b-8"), 1, "fixed"},
    {9, readImage("Project:b-9"), 1, "fixed"},
    {10, readImage("Project:b-10"), 1, "fixed"},
    {11, readImage("Project:b-11"), 1, "fixed"},
    {12, readImage("Project:b-12"), 1, "fixed"},
    {13, readImage("Project:b-13"), 1, "fixed"},
    {14, readImage("Project:b-14"), 1, "fixed"},
    {15, readImage("Project:b-15"), 1, "fixed"},
    {16, readImage("Project:b-16"), 1, "fixed"},
    {17, readImage("Project:b-17"), 1, "fixed"},
    {18, readImage("Project:b-18"), 1, "fixed"},
    {19, readImage("Project:b-19"), 1, "fixed"},
    {20, readImage("Project:b-20"), 1, "fixed"},
    {21, readImage("Project:b-21"), 1, "fixed"},
    {22, readImage("Project:b-22"), 1, "fixed"},
    {23, readImage("Project:b-23"), 1, "fixed"},
    {24, readImage("Project:b-24"), 1, "fixed"},
    {25, readImage("Project:b-25"), 1, "fixed"},
    {26, readImage("Project:b-26"), 1, "fixed"},
    {27, readImage("Project:b-27"), 1, "fixed"},
    {28, readImage("Project:b-28"), 1, "fixed"},
    {29, readImage("Project:b-29"), 1, "fixed"},
    {30, readImage("Project:b-30"), 1, "fixed"},
    {31, readImage("Project:b-31"), 1, "fixed"},
    {32, readImage("Project:b-32"), 1, "fixed"},
    {33, readImage("Project:b-33"), 1, "fixed"},
    {34, readImage("Project:b-34"), 1, "fixed"},
    {35, readImage("Project:b-35"), 1, "fixed"},
    {36, readImage("Project:b-36"), 1, "fixed"},
    {37, readImage("Project:b-37"), 1, "fixed"},
    {38, readImage("Project:b-38"), 1, "fixed"},
    {39, readImage("Project:b-39"), 1, "fixed"},
    {40, readImage("Project:b-40"), 1, "fixed"},
    {41, readImage("Project:b-41"), 1, "fixed"},
    {42, readImage("Project:b-42"), 1, "fixed"},
    {43, readImage("Project:b-43"), 1, "fixed"},
    {44, readImage("Project:b-44"), 1, "fixed"},
    {45, readImage("Project:b-45"), 1, "fixed"},
    {46, readImage("Project:b-46"), 1, "fixed"},
    {47, readImage("Project:b-47"), 1, "fixed"},
    {48, readImage("Project:b-48"), 0},
    {49, readImage("Project:b-49"), 0},
    {50, readImage("Project:b-50"), 0},
    {51, readImage("Project:b-51"), 0},
    {52, readImage("Project:b-52"), 0},
    {53, readImage("Project:b-53"), 0},
    {54, readImage("Project:b-54"), 0},
    {55, readImage("Project:b-55"), 0},
    {56, readImage("Project:b-56"), 1, "gravity", 0, 0.5},
    {57, readImage("Project:b-57"), 1, "gravity", 0, -0.5},
    {58, readImage("Project:b-58"), 1, "gravity", -0.5, 0},
    {59, readImage("Project:b-59"), 1, "gravity", 0.5, 0},
    {60, readImage("Project:b-60"), 1, "gravity", 0, 0},
    {61, readImage("Project:b-61"), 0},
    {62, readImage("Project:b-62"), 0},
    {63, readImage("Project:b-63"), 0},
    {64, readImage("Project:b-64"), 0},
    {65, readImage("Project:b-65"), 0},
    {66, readImage("Project:b-66"), 0},
    {67, readImage("Project:b-67"), 1, "fixed"},
    {68, readImage("Project:b-68"), 1, "fixed"},
    {69, readImage("Project:b-69"), 1, "fixed"},
    {70, readImage("Project:b-70"), 1, "fixed"},
    {71, readImage("Project:b-71"), 1, "fixed"},
    {72, readImage("Project:b-72"), 1, "fixed"},
    {73, readImage("Project:b-73"), 1, "fixed"},
    {74, readImage("Project:b-74"), 1, "fixed"},
    {75, readImage("Project:b-75"), 1, "fixed"},
    {76, readImage("Project:b-76"), 1, "fixed"},
    {77, readImage("Project:b-77"), 1, "fixed"},
    {78, readImage("Project:b-78"), 1, "fixed"},
    {79, readImage("Project:b-79"), 1, "fixed"},
    {80, readImage("Project:b-80"), 1, "fixed"},
    {81, readImage("Project:b-81"), 0},
    {82, readImage("Project:b-82"), 1, "fixed"},
    {83, readImage("Project:b-83"), 0},
    {84, readImage("Project:b-84"), 0},
    {85, readImage("Project:b-85"), 0},
    {86, readImage("Project:b-86"), 0},
    {87, readImage("Project:b-87"), 1, "key-block", 1, false, readImage("Project:b-87-1")},
    {88, readImage("Project:b-88"), 1, "key-block", 2, false, readImage("Project:b-88-1")},
    {89, readImage("Project:b-89"), 1, "key-block", 3, false, readImage("Project:b-89-1")},
    {90, readImage("Project:b-90"), 1, "key-button", 1, 6},
    {91, readImage("Project:b-91"), 1, "key-button", 2, 6},
    {92, readImage("Project:b-92"), 1, "key-button", 3, 6},
    {93, readImage("Project:b-93"), 1, "key-block", 1, true, readImage("Project:b-93-1")},
    {94, readImage("Project:b-94"), 1, "key-block", 2, true, readImage("Project:b-94-1")},
    {95, readImage("Project:b-95"), 1, "key-block", 3, true, readImage("Project:b-95-1")},
    {96, readImage("Project:b-96"), 1, "gravity"},
    {97, readImage("Project:b-97"), 1, "gravity"},
    {98, readImage("Project:b-98"), 1, "gravity"},
    {99, readImage("Project:b-99"), 1, "gravity"},
    {100, readImage("Project:b-100"), 0},
    {101, readImage("Project:b-101"), 0},
    {102, readImage("Project:b-102"), 0},
    {103, readImage("Project:b-103"), 1, "fixed"},
    {104, readImage("Project:b-104"), 1, "fixed"},
    {105, readImage("Project:b-105"), 1, "fixed"},
    {106, readImage("Project:b-106"), 1, "fixed"},
    {107, readImage("Project:b-107"), 1, "fixed"},
    {108, readImage("Project:b-108"), 0},
    {109, readImage("Project:b-109"), 0},
    {110, readImage("Project:b-110"), 0},
    {111, readImage("Project:b-111"), 0},
    {112, readImage("Project:b-112"), 0},
    {113, readImage("Project:b-113"), 0},
    {114, readImage("Project:b-114"), 0},
    {115, readImage("Project:b-115"), 1, "fixed"},
    {116, readImage("Project:b-116"), 1, "fixed"},
    {117, readImage("Project:b-117"), 0},
    {118, readImage("Project:b-118"), 0},
    {119, readImage("Project:b-119"), 0},
    {120, readImage("Project:b-120"), 0},
    {121, readImage("Project:b-121"), 0},
    {122, readImage("Project:b-122"), 0},
    {123, readImage("Project:b-123"), 0},
    {124, readImage("Project:b-124"), 0},
    {125, readImage("Project:b-125"), 0},
    {126, readImage("Project:b-126"), 1, "fixed"},
    {127, readImage("Project:b-127"), 1, "fixed"},
    {128, readImage("Project:b-128"), 1, "fixed"},
    {129, readImage("Project:b-129"), 1, "fixed"},
    {130, readImage("Project:b-130"), 1, "fixed"},
    {131, readImage("Project:b-131"), 1, "fixed"},
    {132, readImage("Project:b-132"), 1, "fixed"},
    {133, readImage("Project:b-133"), 1, "fixed"},
    {134, readImage("Project:b-134"), 1, "fixed"},
    {135, readImage("Project:b-135"), 1, "fixed"},
    {136, readImage("Project:b-136"), 1, "fixed"},
    {137, readImage("Project:b-137"), 1, "fixed"},
    {138, readImage("Project:b-138"), 1, "fixed"},
    {139, readImage("Project:b-139"), 1, "deco"},
    {140, readImage("Project:b-140"), 1, "fixed"},
    {141, readImage("Project:b-141"), 1, "fixed"},
    {142, readImage("Project:b-142"), 0},
    {143, readImage("Project:b-143"), 0},
    {144, readImage("Project:b-144"), 0},
    {145, readImage("Project:b-145"), 1, "fixed"},
    {146, readImage("Project:b-146"), 0},
    {147, readImage("Project:b-147"), 1, "fixed"},
    {148, readImage("Project:b-148"), 0},
    {149, readImage("Project:b-149"), 1, "fixed"},
    {150, readImage("Project:b-150"), 0},
    {151, readImage("Project:b-151"), 1, "fixed"},
    {152, readImage("Project:b-152"), 1, "fixed"},
    {153, readImage("Project:b-153"), 1, "fixed"},
    {154, readImage("Project:b-154"), 0},
    {155, readImage("Project:b-155"), 0},
    {156, readImage("Project:b-156"), 0},
    {157, readImage("Project:b-157"), 1, "gravity-move", -1},
    {158, readImage("Project:b-158"), 1, "fixed"},
    {159, readImage("Project:b-159"), 1, "fixed"},
    {160, readImage("Project:b-160"), 1, "fixed"},
    {161, readImage("Project:b-161"), 1, "fixed"},
    {162, readImage("Project:b-162"), 1, "fixed"},
    {163, readImage("Project:b-163"), 1, "fixed"},
    {164, readImage("Project:b-164"), 1, "fixed"},
    {165, readImage("Project:b-165"), 1, "fixed"},
    {166, readImage("Project:b-166"), 0},
    {167, readImage("Project:b-167"), 0},
    {168, readImage("Project:b-168"), 0},
    {169, readImage("Project:b-169"), 0},
    {170, readImage("Project:b-170"), 1, "fixed"}
}

Smiley_Skins = {
    -- {id, image, chatSmybols, name}
    --[[
        --#-- Staff Only
    ]]
    {1, readImage("Project:a-1"), ":)", "Smile"},
    {2, readImage("Project:a-2"), ":D", "Laugh"},
    {3, readImage("Project:a-3"), ":(", "Sad"},
    {4, readImage("Project:a-4"), ":/", "Annoyed"},
    {5, readImage("Project:a-5"), "o_O", "Surprised"},
    {6, readImage("Project:a-6"), ":P", "Showing Tongue"},
    {7, readImage("Project:a-7"), "^^", "[--]"},
    {8, readImage("Project:a-8"), ">3", "[--]"},
    {9, readImage("Project:a-9"), "8)", "Sunglases"},
    {10, readImage("Project:a-10"), "I)", "Ninja"},
    {11, readImage("Project:a-11"), "(8)", "Tourist"},
    {12, readImage("Project:a-12"), "D3", "Angry"},
    {13, readImage("Project:a-13"), nil, "Dark Sadness"}, --#--
    {14, readImage("Project:a-14"), nil, "Hero"}, --#--
    {15, readImage("Project:a-15"), nil, "Pirate"} --#--
}

Smiley_Borders = {
    -- {id, image}
    {1, readImage("Project:c-1")}, -- White
    {2, readImage("Project:c-2")}, -- Red
    {3, readImage("Project:c-3")}, -- Green
    {4, readImage("Project:c-4")}, -- Blue
    {5, readImage("Project:c-5")}, -- Cyan
    {6, readImage("Project:c-6")}, -- Magenta
    {7, readImage("Project:c-7")}, -- Yellow
    {8, readImage("Project:c-8")}, -- Gray
    {9, readImage("Project:c-9")} -- Black
}

Aura_List = {
    -- {id, Default, ...}
    -- d-1 removed: Too small.
    -- d-22 removed: Fog, Too Small.
    -- {0, x, y, z, ..} Mod Aura
    {0, {readImage("Project:d-4"), 0}, {readImage("Project:d-5"), 0}, {readImage("Project:d-6"), 0},
        {readImage("Project:d-7"), 0}, {readImage("Project:d-9"), 0}, {readImage("Project:d-10"), 0},
        {readImage("Project:d-11"), 0}, {readImage("Project:d-12"), 0}, {readImage("Project:d-13"), 0},
        {readImage("Project:d-15"), 15}, {readImage("Project:d-16"), 15}, {readImage("Project:d-19"), 1},
        {readImage("Project:d-20"), 0}, {readImage("Project:d-23"), 0}
    }, -- Moderator Mode
    
    -- {ID, Default, Halo, Spikey}
    {1, {readImage("Project:d-2"), 0}, {readImage("Project:d-21"), 0}, {readImage("Project:d-27"), 5}}, -- White
    {2, {readImage("Project:d-3"), 0}, {readImage("Project:d-24"), 0}, {readImage("Project:d-28"), 5}}, -- Red
    {3, {readImage("Project:d-8"), 0}, {readImage("Project:d-25"), 0}, {readImage("Project:d-29"), 5}}, -- Green
    {4, {readImage("Project:d-14"), 0}, {readImage("Project:d-26"), 0}, {readImage("Project:d-30"), 5}}, -- Blue
    {5, {readImage("Project:d-17"), 5}, {readImage("Project:d-18"), 20}} -- Universe
}

-- Shop Packages Content (client side)
PacksContent = {
    -- {pack id, blocks id, smiley id, border smiley id}
    {1, {-1, 0, 1, 2, 3, 4, 64, 65, 66}, {1, 2, 3}, {1}}, -- Basic Pack [FREE]
    {2, {5, 6, 7, 8, 61, 62, 63}, {}, {}}, -- Bricks Pack
    {3, {9, 10, 11, 12, 100, 101, 102}, {}, {}}, -- Checker Pack
    {4, {17, 13, 18, 14, 15, 16, 19, 20, 115, 117, 118, 119, 120, 121, 122, 123, 124, 125}
            , {}, {}}, -- VIP Pack [PRO]
    {5, {26, 22, 23, 24, 25, 27}, {}, {}}, -- Jungle
    {6, {28, 29, 30, 31, 32, 33, 34, 40, 35, 36, 37, 38, 39, 139}, {}, {}}, -- Desert
    {7, {41, 42, 43, 44, 45, 46, 47, 80, 82, 67, 68, 69, 48, 49, 50, 51, 52, 53, 54, 55, 81, 83}
            , {}, {}}, -- Ancients
    {8, {60, 58, 56, 57, 59, 96, 98, 99, 97}, {}, {}}, -- Gravity
    {9, {70, 71, 72, 73}, {}, {}}, -- Volcano
    {10, {74, 75, 76, 77, 78, 79, 140, 116, 134, 141}, {}, {}}, -- Arctic
    {11, {85, 86, 84}, {}, {}}, -- Wood
    {12, {90, 91, 92, 87, 88, 89, 93, 94, 95}, {}, {}}, -- Key Blocks & Bricks
    {13, {103, 104, 105, 106, 21, 107, 108, 109, 110, 111, 112, 113, 114}}, -- GM
    {14, {}, {}, {2}}, -- Smiley Red Border
    {15, {126, 127, 128, 129}, {}, {}}, -- Metal Plate
    {16, {130, 132, 133, 131}, {}, {}}, -- Shingles,
    {17, {135, 136, 137, 138}, {}, {}}, -- Stone
    {18, {142, 143, 144}, {}, {}}, -- Stripe
    {19, {145, 147, 149, 151, 152, 153, 170, 146, 148, 150, 154, 155, 156, 157}, {11}, {}}, -- City
    {20, {158, 159, 160, 161}, {}, {}}, -- Wall
    --{21, {162, 163, 164, 165, 166, 167, 168, 169}, {}, {}} REMOVED ON REQUEST
}

-- Shop Packages Data (Server)
ShopPackages = {
    -- {pack name, pack id, pack dsc, payVaultEnergy, payVaultGems, displaySections}
    {"Basic", 1, "This Items are free. If you see them in the shop, don't buy them.", "free", "free", nil},
    {"Bricks", 2, "A beatiful bricks package could be used for castles.", 1500, 15, {1, 2}},
    {"Checkers", 3, "Checkers are 4/4 blocks, right?", 1500, 15, {1, 2}},
    {"Special Membership", 4, "Get a Special Membership permament!", nil, 500, {1, 6}},
    {"Jungle", 5, "If you see a temple – you know how it was build!", 2000, 20, {1, 2}},
    {"Desert", 6, "A Landscape full of different Sand Blocks!", 7500, 75, {1, 2}},
    {"Ancient", 7, "When Egypt build temples, they were really ancient.", 3500, 35, {1, 2}},
    {"Gravity", 8, "With future technology, you can create gravity fields.", 1000, 10, {1, 2}},
    {"Volcano", 9, "You here explosions! Everything became quiet...", 1500, 15, {1, 2}},
    {"Arctic", 10, "A hot summer day? Feel the winter!", 2000, 20, {1, 2}},
    {"Wood", 11, "Pals! Best wood! Buy wood! We come from WoodProductions®!", 1000, 10, {1, 2}},
    {"Key Blocks", 12, "These technology was used from past till present.", 1000, 15, {1, 2}},
    {"Gold Membership (6 Months)", 13, "Get unique features temporary!", nil, 200, {1, 6}},
    {"Smiley Red Border", 14, "A border for your smiley!", 2500, 25, {1, 4}},
    {"Metal Plate", 15, "An extended version of the basic pack!", 1000, 10, {1, 2}},
    {"Shingles Pack", 16, "Build colorful walls!", 2000, 20, {1, 2}},
    {"Stone Pack", 17, "Stone is a very useful material.", 500, 5, {1, 2}},
    {"Stripes Background", 18, "Nothing, but striped backgrounds.", 100, 1, {1, 2}},
    {"City Pack", 19, "Why do you build villages, when you can build big cities!", 2500, 25, {1, 2}},
    {"Wall", 20, "Isolate your enemies!", 250, 2, {1, 2}},
    --{"Evolution", 21, "Booking party rooms became easier!", 1000, 10, {1, 2}} REMOVED ON REQUEST
}

Staff = {
    -- "admin", "mod", "dev"
    {"admin", "admin"},
    {"beta_fiIgUZ1d", "mod"}, -- Exco
    {"beta_q7FAuzp5", "mod"} -- Doomester
}
--# UI
UI = {}

function UI.Setup()
    UI.NextObject = 1
    
    UI.FontList = {} -- Use Simple Fonts; improvment: SimpleFont .. "Bold"
    UI.FontList.Library = "ArialMT"
    UI.FontList.VIPLibrary = "Baskerville"
    UI.FontList.Help = "AmericanTypewriter"
    
    UI.Colors = {} -- Use Colors
    UI.Colors.Admin = color(255, 191, 0, 255)
    UI.Colors.Mod = color(156, 25, 128, 255)
    UI.Colors.Member = color(95, 115, 184, 255)
end

function GetId()
    local n = UI.NextObject
    UI.NextObject = UI.NextObject + 1
    return n 
end

-- Here is the code for the user interface


-- CLASS; Official Alert Design

UI.Alert = class()

function UI.Alert:init()
    self.content = "This Alert contains a title and content. No default text has been specified here."
    self.title = "Empty Alert"
    self.show = false
end

function UI.Alert:draw()
    resetStyle()
    fill(255, 255) -- Same color as border
    stroke(255, 255) -- Same color as box
    local alertLength = 450 -- Height of Alert
    
    local x, y, w, h = 125, HEIGHT/2 - alertLength/2, WIDTH-250, alertLength
    rect(x, y, w, h)
    
    strokeWidth(20)
    line(x, y, x, h + y)
    line(x, y, w + x, y)
    line(w + x, y, w + x, h + y)
    line(x, h + y, w + x, h + y)
    
    strokeWidth(0)
    fill(50, 60, 85, 255)
    ellipse(x + w + 5, y + h + 5, 50)
    fill(0, 255)
    fontSize(50)
    font("Futura-Medium")
    text("X", x + w + 5,  y + h + 5)
    
    fill(0, 0, 0, 255)
    font(UI.FontList.Help)
    fontSize(25)
    local a,_ = textSize(self.title)
    text(self.title, x + 25 + a/2, y + w - 25)
end

function UI.Alert:touched(t)
    
end

function UI.Alert:open(title, content)
    if content == nil or title == nil then
        content = "The Alert is missing 'content' or 'title'. Please report this."
        title = "System Message"
    end
    self.content = content
    self.title = title
    -- Show Alert when everything is prepared
    self.show = true
end

-- CLASS; Buttons

UI.Button = class()

function UI.Button:init(array)
    self.id = GetId()
    self.x = array.x or 0
    self.y = array.y or 0
    self.w = array.w or 0
    self.h = array.h or 0
    self.canTouch = true
    self.input = array.msg or "Button " .. self.id
    
    -- Functions
    self.strHelp = array.helpText or ""
    self.OnClick = array.action or function() end
    
    -- Touch Design
    self.touch = {}
    self.touch.hold = false
    self.touch.holdTime = 0
    
    -- Sub-data
    self.design = array.style or "default"
    --[[
    "default" - Default, simple
    "selected" - Permament selected type for Default. Usually without 'action'
    ]]
end

function UI.Button:draw()
    resetStyle()
    if self.design == "default" then
        fill(255, 255)
        if self.touch.hold then
            fill(200, 255)
        end
        if not self.canTouch then
            fill(150, 255)
        end
        stroke(0, 255)
        strokeWidth(5)
    elseif self.design == "selected" then
        fill(200, 255)
        if not self.canTouch then
            fill(150, 255)
        end
        stroke(0, 0, 0, 255)
        strokeWidth(5)
    elseif self.design == "small_1" then
        fill(255, 255)
        if self.touch.hold then
            fill(200, 255)
        end
        if not self.canTouch then
            fill(150, 255)
        end
        stroke(0, 0, 0, 255)
        strokeWidth(2)
    elseif self.design == "buy_vip_small" then
        fill(200, 160, 60, 255)
        if self.touch.hold then
            fill(225, 185, 75, 255)
        end
        if not self.canTouch then
            fill(175, 110, 10, 255)
        end
        stroke(200, 255)
        strokeWidth(2)
        
    -- Design does not exist
    else
        self.design = "default"
    end
    rect(self.x, self.y, self.w, self.h)
    clip(self.x, self.y, self.w, self.h)
    if self.design == "default" then
        fill(0, 255)
        if not self.canTouch then
            fill(200, 255)
        end
        font(UI.FontList.Library)
        textWrapWidth(self.w)
        fontSize(35)
    elseif self.design == "selected" then
        fill(0, 255)
        if not self.canTouch then
            fill(200, 255)
        end
        font(UI.FontList.Library)
        textWrapWidth(self.w)
        fontSize(35)
    elseif self.design == "small_1" then
        fill(0, 255)
        if not self.canTouch then
            fill(200, 255)
        end
        font(UI.FontList.Library)
        textWrapWidth(self.w)
        fontSize(20)
    elseif self.design == "buy_vip_small" then
        fill(255, 255)
        font(UI.FontList.VIPLibrary)
        textWrapWidth(self.w)
        fontSize(20)
        
    -- No "else" needed, because in above cycle everything is fixed.
    end
    text(self.input, self.x + self.w/2, self.y + self.h/2)
    clip()
    
    if self.touch.hold then
        self.touch.holdTime = self.touch.holdTime + 1
        if self.touch.holdTime > 50 and (#self.strHelp > 0) and self.canTouch then
            resetStyle()
            textWrapWidth(200)
            font(UI.FontList.Help)
            textAlign(LEFT)
            fontSize(20)
            local o, p = textSize(self.strHelp)
            
            zLevel(1)
            fill(150, 255)
            stroke(255, 255)
            strokeWidth(1)
            if CurrentTouch.y < HEIGHT-350 then
                if CurrentTouch.x < WIDTH/2 then
                    rect(CurrentTouch.x, CurrentTouch.y+50, 200, p)
                    fill(255, 255)
                    text(self.strHelp, CurrentTouch.x + o/2, CurrentTouch.y + 50 + p/2)
                else
                    rect(CurrentTouch.x-200, CurrentTouch.y+50, 200, p)
                    fill(255, 255)
                    text(self.strHelp, CurrentTouch.x + o/2 - 200, CurrentTouch.y + 50 + p/2)
                end
            else
                if CurrentTouch.x < WIDTH/2 then
                    rect(CurrentTouch.x, CurrentTouch.y-50-p, 200, p)
                    fill(255, 255)
                    text(self.strHelp, CurrentTouch.x + o/2, CurrentTouch.y - 50 - p/2)
                else
                    rect(CurrentTouch.x - 200, CurrentTouch.y-50-p, 200, p)
                    fill(255, 255)
                    text(self.strHelp, CurrentTouch.x + o/2 - 200, CurrentTouch.y - 50 - p/2)
                end
            end
            resetMatrix()
        end
    end
end

function UI.Button:touched(t)
    if t.x > self.x and t.x < self.x + self.w and t.y > self.y and t.y < self.y + self.h then
        if t.state == ENDED then
            if self.touch.hold and self.touch.holdTime < 50 then
                self.OnClick(t)
            end
            self.touch.hold = false
        elseif t.state == BEGAN then
            self.touch.hold = true
            self.touch.holdTime = 0
        end
    else
        self.touch.hold = false
    end
end

function UI.Button:enableTouch()
    self.canTouch = true
end

function UI.Button:disableTouch()
    self.canTouch = false
end

--# Lobby
Lobby = {}

-- Function 'Init'

function Lobby.Run()
    --- Room Data ---
    Lobby.GameVersion = "0.0.0.1"
    Lobby.GameName = "Brick Editor"
    Lobby.RoomId = 1
    Lobby.RoomVersion = 1
    
    -- Room Name generated by Version
    Lobby.RoomName = "BrickEditorLobby" .. Lobby.RoomVersion
    
    -- Heading
    Lobby.HeadingButtons = {
    UI.Button({
        x = 20, w = 150, h = 60, msg = "Lobby",
        style = "selected"
    }),
    UI.Button({
        x = 180, w = 150, h = 60, msg = "Shop",
        action = function() CurrentPageId = Shop.RoomId end,
        helpText = "In the Shop you can buy items!"
    }),
    UI.Button({
        x = 340, w = 150, h = 60, msg = "GAME",
        action = function() Connection.Send("init", "Alpha") end,
        helpText = "Temporary: Enter a game."
    })
    }
    
    -- Room List
    Lobby.RoomList = {
        --[[
            public_
            beta_
        ]]
        Lobby.Room("public_alpha")
    }
end

-- Function 'Draw'

function Lobby.GetUI()
    -- Body
    resetStyle()
    -- Head Panel
    fill(255, 255)
    rect(10, HEIGHT-100, WIDTH-20, 80)
    for a, b in ipairs(Lobby.HeadingButtons) do
        b.y = HEIGHT-90
        b:draw()
    end
        
    -- Container 1
    resetStyle()
    fill(255, 255)
    rect(10, 10, WIDTH-500, HEIGHT-120)
        
    -- Content
    fill(215, 150, 70, 255)
    font(UI.FontList.Library)
    fontSize(45)
    text(Lobby.GameName, 10 + (WIDTH-500)/2, HEIGHT-130)
        
    fill(225, 225)
    rect(12, 12, WIDTH-504, HEIGHT-162)
        
    for a, b in ipairs(Lobby.RoomList) do
        -- Remember! b - is a function!
            
        resetStyle()
        fill(100, 255)
        rect(14, HEIGHT - 150 - a * 72, WIDTH-506, 70)
            
        fill(0, 0, 0, 255)
        font(UI.FontList.Library)
        local a,_ = textSize(b.name)
        text(b.name, 16 + a/2, HEIGHT - 115 - a * 72)
    end
        
    -- Container 2
    fill(255, 255)
    rect(WIDTH-490, 10, 480, HEIGHT-120)
    
    
end

-- Function 'Touched'

function Lobby.GetUITouch(t)
    for a, b in ipairs(Lobby.HeadingButtons) do
        b:touched(t)
    end
end

-- Object 'Room'

function Lobby.Room(id)
    arg = {}
    arg.name = "Null"
    
    return arg
end

--# Shop
Shop = {}

-- Function 'Init'

function Shop.Run()
    --- Room Data ---
    Shop.RoomId = 2
    Shop.RoomVersion = 1
    
    Shop.SectionId = 1 -- Section Id
    Shop.ScrollPosition = 0 -- Scroll Button
    Shop.SectionTotalItems = 0 -- This value gets changed in draw.
    
    Shop.KeyBlocksTimer = 0 -- This value gets changed in draw.
    Shop.KeyBlocksDisplayInUse = false -- This value gets changed in draw.
    
    -- Room Name generated by Version
    Shop.RoomName = "BrickEditorShop" .. Shop.RoomVersion
    
    -- Heading
    Shop.HeadingButtons = {
    UI.Button({
        x = 20, w = 150, h = 60, msg = "Lobby",
        helpText = "Enter the Lobby Room. In the Lobby you can find all rooms listed.",
        action = function() CurrentPageId = Lobby.RoomId end
    }),
    UI.Button({
        x = 180, w = 150, h = 60, msg = "Shop",
        style = "selected"
    }),
    UI.Button({
        x = 340, w = 150, h = 60, msg = "GAME",
        action = function() Connection.Send("init", "Alpha") end,
        helpText = "Temporary: Enter a game."
    })
    }
    
    -- Categories
    Shop.Categories = {
    UI.Button({
        x = 20, w = 70, h = 30, msg = "New",
        helpText = "Everything newly added to the game can be found here...",
        action = function() Shop.SectionId = 1 Shop.ScrollPosition = 0 end,
        style = "small_1"
    }),
    UI.Button({
        x = 95, w = 70, h = 30, msg = "Packs",
        helpText = "Stuff to build in public worlds!",
        action = function() Shop.SectionId = 2 Shop.ScrollPosition = 0 end,
        style = "small_1"
    }),
    UI.Button({
        x = 170, w = 70, h = 30, msg = "Power",
        helpText = "Effects that give you temporary abilities!",
        action = function() Shop.SectionId = 3 Shop.ScrollPosition = 0 end,
        style = "small_1"
    }),
    UI.Button({
        x = 245, w = 70, h = 30, msg = "Skin",
        helpText = "Other smiley graphics or types to wear!",
        action = function() Shop.SectionId = 4 Shop.ScrollPosition = 0 end,
        style = "small_1"
    }),
    UI.Button({
        x = 320, w = 70, h = 30, msg = "Rooms",
        helpText = "Buy Rooms to play, and save your creations!",
        action = function() Shop.SectionId = 5 Shop.ScrollPosition = 0 end,
        style = "small_1"
    }),
    
    -- Special: VIP
    UI.Button({
        x = WIDTH-90, w = 70, h = 30, msg = "VIP",
        helpText = "Show your support and get special rights!",
        action = function() Shop.SectionId = 6 Shop.ScrollPosition = 0 end,
        style = "buy_vip_small"
    })
    }
end

-- Function 'Draw'

function Shop.GetUI()
    Shop.KeyBlocksTimer = Shop.KeyBlocksTimer + 1
    if Shop.KeyBlocksTimer >= 300 then
        if Shop.KeyBlocksDisplayInUse then
            Shop.KeyBlocksDisplayInUse = false
        else
            Shop.KeyBlocksDisplayInUse = true
        end
    end
    
    resetStyle()
    -- Head Panel
    fill(255, 255)
    rect(10, HEIGHT-100, WIDTH-20, 80)
    for a, b in ipairs(Shop.HeadingButtons) do
        b.y = HEIGHT-90
        b:draw()
    end
        
    -- Categories
    resetStyle()
    fill(255, 255)
    rect(10, HEIGHT-160, WIDTH-20, 50)
    for a, b in ipairs(Shop.Categories) do
        b.y = HEIGHT-150
        b:draw()
    end
        
    -- Content
    resetStyle()
    fill(255, 255)
    rect(10, 10, WIDTH-20, HEIGHT-170)
    if Shop.SectionTotalItems > 5 then
        fill(75, 255)
        rect(WIDTH-70, 15, 45, HEIGHT-200)
        clip(10, 10, WIDTH-20, HEIGHT-170)
    end
        
    -- Display Items
    local all = {} -- All displayed sections go here.
    for a, b in ipairs(ShopPackages) do
        local img = {}
        local name = b[1] or "Unknown"
        local desc = b[3] or "A random description. :)"
        local TYPE = 0
            
        for c, d in ipairs(PacksContent) do
            if b[2] == d[1] then
                img = d[2]
                TYPE = 1
            end
        end
        if not (TYPE == 1) then
            for c, d in ipairs(Smiley_Skins) do
                if b[2] == d[1] then
                    img = d[2]
                    TYPE = 2
                end
            end
        end
        if not (TYPE == 2) and not (TYPE == 1) then
            for c, d in ipairs(Smiley_Borders) do
                if b[2] == d[1] then
                    img = d[2]
                    TYPE = 3
                end
            end
        end
        if b[6] then -- They are existing.
            for c, d in ipairs(b[6]) --[[Shop Sections]] do
                if d == Shop.SectionId then
                    table.insert(all, {name, img, desc, TYPE})
                end
            end
        end
    end
        
    --clip(10, 10, WIDTH-20, HEIGHT-170)
    Shop.SectionTotalItems = #all
    for a, b in ipairs(all) do
        fill(75, 255)
        if Shop.SectionTotalItems > 5 then
            rect(15, HEIGHT-185-(a * 100) + Shop.ScrollPosition, WIDTH-90, 90)
        else
            rect(15, HEIGHT-185-(a * 100), WIDTH-50, 90)
        end
            
        -- TITLE --
        fill(255, 255)
        fontSize(25)
        font("ArialMT")
        local c,_ = textSize(b[1]) -- Title
        text(b[1], 25 + c/2, HEIGHT-120-(a * 100) + Shop.ScrollPosition)
            
        -- DESCRIPTION --
        fill(200, 255)
        fontSize(15)
        local d,_ = textSize(b[3]) -- Description
        text(b[3], 50 + c + d/2, HEIGHT-120-(a * 100) + Shop.ScrollPosition)
            
        -- GEMS --
        fill(150, 255)
        rect(WIDTH-175, HEIGHT-175-(a * 100) + Shop.ScrollPosition, 90, 70)
        if b[5] == nil then
            fill(235, 85, 85, 255)
            fontSize(35)
            font(UI.FontList.Library)
            line("X", WIDTH-125, HEIGHT-150-(a * 100) + Shop.ScrollPosition)
        else
            fill(255, 255)
            fontSize(35)
            font(UI.FontList.Library)
            text(b[5], WIDTH-125, HEIGHT-150-(a * 100) + Shop.ScrollPosition)
        end
            
        -- BLOCKS --
        for c, d in ipairs(b[2]) do
            for e, f in ipairs(Blocks) do
                if d == f[1] then
                    if (b[4] == 1) then
                        local g = 2
                        if f[4] == "key-block" and Shop.KeyBlocksDisplayInUse then
                            g = 7
                        end
                        sprite(f[g], 25 + c * 17, HEIGHT-170-(a * 100) + Shop.ScrollPosition, 16, 16)
                    elseif (b[4] == 2) then
                        local g = 2
                        sprite(f[g], 25 + c * 17, HEIGHT-170-(a * 100) + Shop.ScrollPosition, 16, 16)
                    elseif (b[4] == 3) then
                        local g = 2
                        sprite(f[g], 25 + c * 17, HEIGHT-170-(a * 100) + Shop.ScrollPosition, 16, 16)
                    end
                end
            end
        end
    end
    clip()
end

-- Function 'Touched'

function Shop.GetUITouch(t)
    for a, b in ipairs(Shop.HeadingButtons) do
        b:touched(t)
    end
    for a, b in ipairs(Shop.Categories) do
        b:touched(t)
    end
    if t.x > WIDTH-70 and t.x < WIDTH-25 and t.y > 15 and t.y < HEIGHT-185 then
        if Shop.SectionTotalItems > 5 then
            Shop.ScrollPosition = Shop.ScrollPosition + t.deltaY
            if (Shop.SectionTotalItems-5) * 100 < Shop.ScrollPosition then
                Shop.ScrollPosition = (Shop.SectionTotalItems-5) * 100
            elseif Shop.ScrollPosition < 0 then
                Shop.ScrollPosition = 0
            end
        else
            Shop.ScrollPosition = 0
        end
    end
end

--# Game
Game = {}

-- Function 'Init'

function Game.Run()
    --- Room Data ---
    Game.RoomId = 3
    Game.RoomVersion = 1
    
    -- Room Name generated by Version
    Game.RoomName = "BrickEditorGame" .. Game.RoomVersion
    
    Game.Buttons = {
    --[[UI.Button({
        x = 840, y = 600, w = 150, h = 60, msg = "Clear",
        action = function() Connection.Send("clear") end,
        helpText = "Temporary: Clear the World"
    }),
    UI.Button({
        x = 840, y = 540, w = 150, h = 60, msg = "Load",
        action = function() Connection.Send("load") end,
        helpText = "Temporary: Load saved content"
    }),
    UI.Button({
        x = 840, y = 480, w = 150, h = 60, msg = "Save",
        action = function() Connection.Send("save") end,
        helpText = "Temporary: Save Content"
    }),
    UI.Button({
        x = 840, y = 420, w = 150, h = 60, msg = "God",
        action = function()
            if player.auraOn then
                Connection.Send("god", false)
            else
                Connection.Send("god", true)
            end
        end,
        helpText = "Temporary: Change Aura Enabled"
    })]]
    }
    
    -- 'Game' Data
    Game.BlockSelected = 0
    Game.LayerSelected = 1
    Game.MyName = Client.D.Name or "null"
    Game.Title = "Untitled World"
    Game.CreatedBy = "UNKNOWN USER"
    Game.Chat = {
        --[[
            0: My Id
            -1: System Message
        ]]
        {-1, "Welcome to Brick Edits!"}
    }
    
    -- Temporary: Player
    player = Game.Player() -- MyId: 0
    player.name = Game.MyName -- Name
    player.textCol = Client.D.Col or UI.Colors.Member -- My Color
    
    -- Current Game (Server & )
    Game.Server = {}
    Game.Server.RoomSize = vec2(40, 30)
    
    Game.Server.RoomLayer = {}
    Game.Server.RoomBGLayer = {}
    Game.Server.RoomLayerData = {}
    Game.Server.Saved = {}
    for x = 1, Game.Server.RoomSize.x do
        Game.Server.RoomLayer[x] = {}
        Game.Server.RoomBGLayer[x] = {}
        Game.Server.RoomLayerData[x] = {}
        Game.Server.Saved[x] = {}
        for y = 1, Game.Server.RoomSize.y do
            Game.Server.RoomBGLayer[x][y] = 0
            Game.Server.RoomLayer[x][y] = 0
            Game.Server.RoomLayerData[x][y] = {}
            Game.Server.Saved[x][y] = 0
        end
    end
end

-- Function 'Draw'

function Game.GetUI()
    resetStyle()
    spriteMode(CORNER)
    fill(0, 0, 0, 255)
    rect(0, 0, WIDTH, HEIGHT)
    stroke(BGColor)
    strokeWidth(1)
    line(WIDTH-220, 0, WIDTH-220, HEIGHT)
    
    fill(255, 255, 255, 255)
    font(UI.FontList.Library)
    fontSize(25)
    local len,_ = textSize(string.upper(Game.Title))
    text(string.upper(Game.Title), WIDTH-210 + len/2, HEIGHT-25)
    
    fontSize(15)
    local len,_ = textSize(string.upper("BY: " .. Game.CreatedBy))
    text(string.upper("BY: " .. Game.CreatedBy), WIDTH-200 + len/2, HEIGHT-50)
    
    --[[for a, b in ipairs(Game.Chat) do
        
    end]]
        
    for a, b in ipairs(Game.Buttons) do
        b:draw()
    end
    resetStyle()
    
    -- GAME PANEL
        
    -- Both Layers
    for x = 1, Game.Server.RoomSize.x do
        for y = 1, Game.Server.RoomSize.y do
            -- BG
            local i = nil
            local vvv = Game.Server.RoomBGLayer[x][y]
            if vvv > 0 then
                i = Blocks[vvv][2]
            else
                for a, b in ipairs(BlocksEmpty) do
                    if Game.Server.RoomBGLayer[x][y] == b[1] then
                        i = b[2]
                        break
                    end
                end
            end
            
            
            sprite(i, 25 + x * 16, HEIGHT - 25 - y * 16)
            
            -- FG
            local vvv = Game.Server.RoomLayer[x][y] or 0
            if vvv > 0 then
                i = Blocks[vvv][2]
            else
                for a, b in ipairs(BlocksEmpty) do
                    if Game.Server.RoomLayer[x][y] == b[1] then
                        i = b[2]
                        break
                    end
                end
            end
            
            if not ( i == nil ) then
                sprite(i, 25 + x * 16, HEIGHT - 25 - y * 16)
            end
        end
    end
        
    --[[ Shadow of Blocks
    tint(100, 255)
    local shadowX = 1
    local shadowY = -1
    for x = 1, Game.Server.RoomSize.x do
        for y = 1, Game.Server.RoomSize.y do
            local i = nil
            local vvv = Game.Server.RoomLayer[x][y] or 0
            if vvv > 0 then
                i = Blocks[vvv][2]
            else
                for a, b in ipairs(BlocksEmpty) do
                    if Game.Server.RoomLayer[x][y] == b[1] then
                        i = b[2]
                        break
                    end
                end
            end
            
            
            sprite(i, 25 + x * 16 + shadowX, HEIGHT - 25 - y * 16 + shadowY)
        end
    end]]
        
    --[[ FG (LAYER-1)
    tint(255, 255, 255, 255)
    for x = 1, Game.Server.RoomSize.x do
        for y = 1, Game.Server.RoomSize.y do
            local i = nil
            local vvv = Game.Server.RoomLayer[x][y] or 0
            if vvv > 0 then
                i = Blocks[vvv][2]
            else
                for a, b in ipairs(BlocksEmpty) do
                    if Game.Server.RoomLayer[x][y] == b[1] then
                        i = b[2]
                        break
                    end
                end
            end
            
            
            sprite(i, 25 + x * 16, HEIGHT - 25 - y * 16)
        end
    end]]
        
        
    --[[ What I got
    local allPacks = {}
    local allBlocks = {}
    local n = 0
    local m = 0
    for a, b in ipairs(ShopPackages) do
        --if (b[4] == "free") and (b[5] == "free") and (b[6] == nil) then
            table.insert(allPacks, b[2])
        --end
    end for a, b in ipairs(allPacks) do
        for c, d in ipairs(PacksContent) do
            if b == d[1] then
                for e, f in ipairs(d[2]) do
                    table.insert(allBlocks, f)
                end
            end
        end
    end
    for a, b in ipairs(allBlocks) do
        for c, d in ipairs(Blocks) do
            if b == d[1] then
                n = n + 1
                if n >= 40 then
                    n = 0
                    m = m + 1
                end
                if d[1] == Game.BlockSelected then
                    tint(86, 86, 86, 255)
                end
                sprite(d[2], 25 + n * 16, 150 - m * 16)
                resetStyle()
            end
        end
    end]]
    
    -- Player
    player:draw(25 + 16, HEIGHT - 25 - 16)
    if player.auraOn then
        player:speed(Gravity.x, Gravity.y+.45)
    else
        player:speed(Gravity.x, Gravity.y+.85)
    end
    --print(Gravity.x, Gravity.y)
    spriteMode(CENTER)
end

-- Function 'Touched'

function Game.GetUITouch(t)
    for a, b in ipairs(Game.Buttons) do
        b:touched(t)
    end
    
    -- World
    for x = 1, Game.Server.RoomSize.x do
        for y = 1, Game.Server.RoomSize.y do
            if t.x > 25+x*16 and t.x < 25+(x+1)*16 and t.y < HEIGHT-25-(y-1)*16 and t.y > HEIGHT-25-y*16 then
                if Game.LayerSelected == 1 then
                    if Game.BlockSelected == 0 then
                        Game.Server.RoomLayer[x][y] = nil
                    else
                        Game.Server.RoomLayer[x][y] = Game.BlockSelected
                    end
                elseif Game.LayerSelected == 0 then
                    Game.Server.RoomBGLayer[x][y] = Game.BlockSelected
                end
            end
        end
    end
end

-- Object 'Player'

Game.Player = class()

function Game.Player:init()
    -- Look
    self.auraId = 0
    self.auraShapeId = 1
    self.auraOn = true
    self.auraRot = 0
    self.id = 0 -- It's me
    self.smileyId = 2
    self.smileyBorderId = 3
    self.name = "null"
    self.textCol = nil
    
    -- Position
    self.x, self.y = 0, 0
    self.speedX, self.speedY = 0, 0
end

function Game.Player:draw(x, y)
    -- Aura Layer
    if self.auraOn then
        for a, b in ipairs(Aura_List) do
            if b[1] == self.auraId and (b[1 + self.auraShapeId]) then
                local n = 1 + self.auraShapeId
                translate(x + self.x, y + self.y)
                if not ( b[n][2] == 0 ) then
                    rotate(self.auraRot)
                end
                sprite(b[n][1] or image(1,1), 0, 0)
                self.auraRot = self.auraRot + (b[n][2] or 0)
                resetMatrix()
            end
        end
    end
    
    -- Border Layer
    for a, b in ipairs(Smiley_Borders) do
        if b[1] == self.smileyBorderId then
            sprite(b[2], x + self.x, y + self.y)
        end
    end
    
    -- Smiley Layer
    for a, b in ipairs(Smiley_Skins) do
        if b[1] == self.smileyId then
            sprite(b[2], x + self.x, y + self.y)
        end
    end
    
    -- Usernames
    resetStyle()
    fill(self.textCol or UI.Colors.Member)
    fontSize(10)
    font(UI.FontList.Library)
    text(string.upper(self.name), x + self.x, y + self.y - 15)
    
    -- Update Position
    self.x, self.y = self.x + self.speedX * 2, self.y + self.speedY * 2
    
    -- Don't drift.
    local drift = 0.05
    if self.speedX > 0 then
        self.speedX = self.speedX - drift
    end
    if self.speedY > 0 then
        self.speedY = self.speedY - drift
    end
    if self.speedX < 0 then
        self.speedX = self.speedX + drift
    end
    if self.speedY < 0 then
        self.speedY = self.speedY + drift
    end
    
    -- Can't escape border
    if self.x <= 0 then
        self.x = 0
        self.speedX = 0
    end if -self.y <= 0 then -- Y goes down, not to top
        self.y = 0
        self.speedY = 0
    end if self.x >= (Game.Server.RoomSize.x-1) * 16 then
        self.x = (Game.Server.RoomSize.x-1) * 16
        self.speedX = 0
    end if -self.y >= (Game.Server.RoomSize.y-1) * 16 then
        self.y = -(Game.Server.RoomSize.y-1) * 16
        self.speedY = 0
    end
    
    -- Physics
    if self.auraOn == false then
        local x, y = math.floor(self.x/16), -math.floor(self.y/16)
        local xRight, xLeft = math.floor(self.x/16+16), math.floor(self.x/16-16)
        local yTop, yBottom = -math.floor(self.y/16-16), -math.floor(self.y/16+16) -- Minus
        --print(x, y, yTop, yBottom, xLeft, xRight)
        --[[local x3 = {
        {Game.Server.RoomLayer[xLeft][yTop],Game.Server.RoomLayer[x][yTop],Game.Server.RoomLayer[xRight][yTop]},
        {Game.Server.RoomLayer[xLeft][y],Game.Server.RoomLayer[x][y], Game.Server.RoomLayer[xRight][y]},
        {Game.Server.RoomLayer[xLeft][yBottom],Game.Server.RoomLayer[x][yBottom],Game.Server.RoomLayer[x][yBottom]}
        }]]
        if Game.Server.RoomLayer[x+1][y+1] == 0 then
            player:speed(0, -0.5)
        elseif Blocks[Game.Server.RoomLayer[x+1][y+1]][4] == "gravity" then
            player:speed(Blocks[Game.Server.RoomLayer[x][y]][5]/5, Blocks[x3[2][2]][6]/5)
            
            -- Gravity DOWN; blocks there
            if Game.Server.RoomLayer[x+1][y+2] then
                if Blocks[Game.Server.RoomLayer[x+1][y+2]][4] == "fixed" then
                    self.speedY = 0
                    self.y = (y+2) * 16
                end
            end
        elseif Blocks[Game.Server.RoomLayer[x+1][y+1]][4] == "fixed" then
            self.speedX = 0
            self.speedY = 0
        elseif Blocks[Game.Server.RoomLayer[x+1][y+1]][4] == "deco" then
            player:speed(0, -0.5)
        end
    end
end

function Game.Player:speed(x, y)
    if self.auraOn then
        self.speedX = self.speedX + x
        self.speedY = self.speedY + y
        if self.speedX >= 5 then
            self.speedX = 5
        end if self.speedY >= 5 then
            self.speedY = 5
        end if self.speedX <= -5 then
            self.speedX = -5
        end if self.speedY <= -5 then
            self.speedY = -5
        end
    else
        self.speedX = self.speedX + x
        self.speedY = self.speedY + y
        if self.speedX >= 3 then
            self.speedX = 3
        end if self.speedY >= 3 then
            self.speedY = 3
        end if self.speedX <= -3 then
            self.speedX = -3
        end if self.speedY <= -3 then
            self.speedY = -3
        end
    end
end

-- Function 'GetData'

function Game.Handle(con, ...)
    print("Connection '" .. con .. "' received.")
    arg = {...}
    if con == "clear" then
        for x = 1, Game.Server.RoomSize.x do
            Game.Server.RoomLayer[x] = {}
            Game.Server.RoomBGLayer[x] = {}
            Game.Server.RoomLayerData[x] = {}
            for y = 1, Game.Server.RoomSize.y do
                Game.Server.RoomBGLayer[x][y] = 0
                if (x == 1) or (y == 1) or (x == Game.Server.RoomSize.x) or (y == Game.Server.RoomSize.y) then
                    Game.Server.RoomLayer[x][y] = 1
                else
                    Game.Server.RoomLayer[x][y] = 0
                end
                Game.Server.RoomLayerData[x][y] = {} 
            end
        end
    elseif con == "close" then
        -- Information if kicked from room.
        CurrentPageId = Lobby.RoomId
        alert(arg[2], arg[1])
    elseif con == "god" then
        if arg[1] == 0 then
            player.auraOn = arg[2]
        end
    elseif con == "init" then
        -- Get all Blocks
        local fg = arg[4]
        for x = 1, Game.Server.RoomSize.x do
            for y = 1, Game.Server.RoomSize.y do
                Game.Server.RoomLayer[x][y] = fg[y][x]
                Game.Server.Saved[x][y] = fg[y][x]
            end
        end
        -- Get BG
        local bg = arg[5]
        
        -- Get Username
        Game.MyName = arg[2]
        Game.Title = arg[6]
        Game.CreatedBy = arg[1]
        
        -- Open Game
        CurrentPageId = Game.RoomId
    elseif con == "load" then
        for x = 1, Game.Server.RoomSize.x do
            for y = 1, Game.Server.RoomSize.y do
                Game.Server.RoomLayer[x][y] = Game.Server.Saved[x][y]
                Game.Server.RoomBGLayer[x][y] = 0
            end
        end
    elseif con == "s" then -- Smiley Change
        if arg[1] == 0 then -- MyId
            player.smileyId = arg[2]
        end
    elseif con == "say" then
        Game.Say(arg[1], arg[2])
    end
end

-- Function 'Say'

function Game.Say(a, b)
    if a == 0 then -- Message was made by me
        if #Game.Chat > 15 then -- Limit Messages
            table.remove(Game.Chat, 1)
        end
        table.insert(Game.Chat, #Game.Chat + 1, b)
    end
end

--# Main
-- Brick Editor

function setup()
    displayMode(FULLSCREEN)
    supportedOrientations(LANDSCAPE_RIGHT)
    --supportedOrientations(CurrentOrientation)
    UI.Setup()
    CurrentPageId = 1
    BGColor = color(50, 155, 200, 255)
    --[[
    1 * Lobby
    2 * Shop
    3 * Game
    ]]
    
    -- All Rooms
    Connection.LoginAs("weinstein.anatoly@gmail.com", "BE_2003@anatoly")
    Lobby.Run()
    Shop.Run()
    Game.Run()
    
    -- All Objects
    Alert = UI.Alert()
    --Alert:open("Test Alert", "Test Messages, Noobs, beat it, you won't ahahaha.")
    
    parameter.text("MessageContent42")
    parameter.action("Send", function() Connection.Send("say", "MessageContent42") end)
end

function draw()
    background(BGColor)
    backingMode(STANDARD)
    -- Content
    if Lobby.RoomId == CurrentPageId then
        Lobby.GetUI()
    elseif Shop.RoomId == CurrentPageId then
        Shop.GetUI()
    elseif Game.RoomId == CurrentPageId then
        Game.GetUI()
    end
    -- Alert
    if Alert.show then
        fill(0, 150)
        rect(-5, -5, WIDTH + 10, HEIGHT + 10)
        Alert:draw()
    end
end

function touched(t)
    if Alert.show then
        Alert:touched(t)
    else
        -- Content
        if Lobby.RoomId == CurrentPageId then
            Lobby.GetUITouch(t)
        elseif Shop.RoomId == CurrentPageId then
            Shop.GetUITouch(t)
        elseif Game.RoomId == CurrentPageId then
            Game.GetUITouch(t)
        end
    end
end


