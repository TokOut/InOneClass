
--# Main
--------------------------------------------------------------
--Project: Codea Community
--Version: Beta 1.1.1.3
--Author: Toffer, Ignats, Andrew_Stacey and Briarfox


--The MIT License (MIT)
--
--Copyright (c) 2014 Toffer, Ignats, Andrew_Stacey and Briarfox
--
--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:
--
--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.
--
--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.



--Codea community

Community = {}
function setup()
    saveProjectInfo("Project","Codea Community")
    saveProjectInfo("Author","Ignatz, Toffer, Andrew_Stacey & Briarfox")
    saveProjectInfo("Description","Community for Codea")
    saveGlobalData("CC_Version",string.match(readProjectTab("Main"), "%-%-%s?Version:%s?(.-)\n") )
    CCLoopTime = tonumber(os.date("%S"))
    CCLOGO = readImage("Documents:CodeaCommunityLogo")
    saveImage("Project:Icon", CCLOGO)
    
    if not Community.vars.BtnImg then
        http.request(Community.vars.BtnImgUrl, 
            function(d) saveImage("Documents:CodeaCommunityClientBtn",d) 
                Community.vars.BtnImg = d end)
    end
    if not CCLOGO then
        print("Downloading Logo")
        http.request(Community.vars.logo,
            function(d) saveImage("Documents:CodeaCommunityLogo",d) 
            CCLOGO = d 
            saveImage("Project:Icon", CCLOGO) end)
    end
    touches = {}
    
    CC_EditBtnParam()
    if Community.vars.opts["ResetUserOption"] == "1" or Community.vars.opts["ResetUserOption"] == "true" then 
        parameter.action("CC_RESET_USER",function() print("User Reset.") Community.resetUser() end) 
        if Community.vars.User then print("Logged in as: "..Community.vars.User) end
    end
end
 
 
function draw()
    --Making sure draw hook is handed back
    background(255, 255, 255, 255)
    if CCLOGO then
    sprite(CCLOGO,WIDTH/2,HEIGHT/2)
    end
    Community.pendingLoop()
    
end

function touched(t)
    if CC_Unlock_Button == true then
        local x = math.floor(WIDTH*(Community.vars.ccBtn.x/100))
    local y = math.floor(HEIGHT*(Community.vars.ccBtn.y/100))

        local top = y+ Community.vars.ccBtn.w/2
        local bottom = y - Community.vars.ccBtn.w/2
        local right = x + Community.vars.ccBtn.w/2
        local left = x - Community.vars.ccBtn.w/2
        
        if t.x <= right and t.x >= left then
            if t.y <= top and t.y>= bottom then
                if t.state == MOVING then 
                
                    Community.vars.ccBtn.x = (t.x/ WIDTH)*100
                    Community.vars.ccBtn.y = (t.y / HEIGHT)*100
            
                end
            end
        end

        
    
    end
end

function orientationChanged()
    
end

function CC_EditBtnParam()
    parameter.action("Edit_CC_Options",function () editCCbtn() end)
end
 
---------------------------------
-----Updates CC
---------------------------------
Community.updateCC = function(current,comment)
 
    --local Community.vars = Community.GetVars()
    local success = function(data)
        local str = parseComments(comment)
        local code = loadstring(data)()
        for i=1, #code.buffers do 
            if code.buffers[i].name ~= "ccConfig" then
                saveProjectTab(code.buffers[i].name,code.buffers[i].code) 
            end
        end
        print("Update Successful!")
        alert("Update Successful!\nPlease restart Codea Community to complete the update.\n"..str..
"\n\nPlease view the ChangeLog for more info.",
            "Version: "..current)
        Community.vars.userVersion = current
        saveGlobalData("CC_Version",current)
        sound(SOUND_PICKUP, 32903)
        
    end
    http.request(Community.vars.host.url..Community.vars.host["dir"]..
    Community.vars.host.download,success)
end
-----------------------------------

function parseComments(comment)
    local str = ""
    comment = string.gsub(comment,"%*","\n*")
    comment = string.gsub(comment,"%+","\n+")
    comment = string.gsub(comment,"%-","\n-")
    
    return comment
end

--------------------
---Token to check if CC is running
--------------------
Community.CCFoundToken = "true"
--------------------

--------------------
----Pending Loop
-------------------
Community.pendingLoop = function()
   local t = tonumber(os.date("%S"))
            if t - CCLoopTime > 1 then
                Community.checkPending()
            end
            CCLoopTime = t
 
end

function editCCbtn()
    local clr = Community.vars.ccBtn.clr
    local colr = color(clr.r or 0,clr.g or 0,clr.b or 0,clr.a or 150)
    
   parameter.clear() 
    parameter.boolean("CC_AutoUpdate",Community.vars.autoUpdate,function(s) 
        saveGlobalData("CC_AutoUpdate",s)
        if s == true then 
            print("AutoUpdate is turned on")
        else
            print("AutoUpdate is turned off")
        end
         end)
    parameter.boolean("CC_Unlock_Button")
    parameter.integer("CC_Button_Size",30,100,50,function(c)
        Community.vars.ccBtn.w = c
        end)
    parameter.color("CC_Button_Color",colr,function(c) 
        Community.vars.ccBtn.clr.r = c.r
        Community.vars.ccBtn.clr.g = c.g
        Community.vars.ccBtn.clr.b = c.b
        Community.vars.ccBtn.clr.a = c.a
        
         end )
    parameter.action("CC_Reset_Button",function() 
        local loc = {x = 95,y = 95,w = 50,clr = {r=30,g=125,b=165,a=180}}
        Community.vars.ccBtn = loc
        loc = Community.table.tostring(Community.vars.ccBtn)
        saveGlobalData("CC_Button_Loc",loc)
        CC_Unlock_Button = false
        print("Button Reset")
        end)
    parameter.action("CC_Save_Button",function() 
        local loc = Community.table.tostring(Community.vars.ccBtn)
        saveGlobalData("CC_Button_Loc",loc) 
        CC_Unlock_Button = false
        print("Button Saved")
        parameter.clear()
        parameter.action("Edit_CC_Options",function () editCCbtn() end)
        end)
end


 
 
 
 
 
 
 
 
 
 
 
 
 
 
 




















--# ChangeLog
--[[
TODO:

Idea: add a unique string at the end of Main in CC and then look for it when examining dependencies.
 
-----------------------------Update Notes----------------------------
Beta 1.1.1
------------------
+ParamButton added to config file. This allows the user to toggle a parameter button.

Andrew's Additions
------------------
+Restored reading header as fall-back (useful for small projects, and for projects holding multiple sub-projects)
+Connect option to minimise http.request crashes
+Spelling corrections

Beta 1.1 rc builds
-------------------
+Header added to main on upload.
+Added License type to Config. Selected License will be added to main on upload.
+Added Config links to Images and video
+Added ccConfig that manages all settings, dependencies, tabs and assets. This will make it easier to add new settings options and allow users to use custom sounds and images. You will need to re add your project name and version info.
-Removed reading dependencies from the plist
-Removed Reading of the header in main including tabs, dependencies and options.

Beta 1.0.3
--------------
* Add "Options" field for true/false option handling (Andrew_Stacey)
* Added "Button" option to disable the CC button in a project.(Andrew_Stacey)
* Added "NotifyCCUpdate" option to disable the update check in a project (this also means that CC clones like this one don't get clobbered)(Andrew_Stacey)

Beta 1.0.2.3
------------
*Fixed orientation being locked in Run Code.
*Moved CC to it's own account.

------------
Beta 1.0.2.2
-----------
*Fixed error when trying to download into a project that does not exist.
*Touch and draw now work properly if multiple setups are in the project. (Contributed by Andrew_Stacey)

-----------
Beta 1.0.2.1
-----------
*Updater fixed
*Disable auto updates from inside CC
*Alert shows new version changes.
------------
Beta 1.0.2
------------
+Added CC button on the main screen.
*CC button can be edited when running CC.
*Fixed garbage collection on RunCode.
*Added three more options for advanced users: 
*--Main: <tabname> (Contributed by Andrew_Stacey)
   This specifies a tab from which to read the rest of the configuration options.  There cannot be a space in "--Main" which makes it easy to switch this option on and off.
*--Tabs: <list of tabs> (Contributed by Andrew_Stacey)
   This specifies a list of tabs to upload when doing the backup.  The list should be separated by spaces.
*--Dependencies: <list of dependencies> (Contributed by Andrew_Stacey)
   This specifies a list of dependencies to consider when uploading dependencies.  The list should be separated by commas.
*Fixed bug where an empty option gets the next line. (Contributed by Andrew_Stacey)
*Fixed bug where two tabs specifying "setup" uninstalls CC (Contributed by Andrew_Stacey)
*Fixed bug if Info.plist has no dependency field (bit obscure!) (Contributed by Andrew_Stacey)

Beta 1.0.1
----------
*Fixed issue with CC being uploaded as a dependency

----------
Beta 1.0
-----------
*Open Beta test has begun!
*Separated the Community tab into separate tabs
+Codea Community project no longer opens to backup screen
+When Codea Community is ran, it will check pending after leaving and reentering CC when running.
+Implemented code sharing via link. To get your projects link, long press the version number and hit copy.

-----------

Alpha 1.2.2
------------
*Fixed dependencies loading blank tabs
*Run code now allows fullscreen
------------

Alpha 1.2.1
------------
+fix to the updater
+Projects with dependencies download the dependency into a tab. (Temporary)

Alpha 1.2
--------------
+Dependencies uploaded if Upload Project name matches Codea Project name.
+Load dependencies for run code
+Filter out Codea Community from dependencies
+Selective Sharing. Long press on share to select what users to share with.
*Community now shows your own projects.
*Sandboxed sensitive code used in Run Code:
    debug.setlocal
    debug.setupvalue
    debug.setregistry
    io 
    dofile
    The functions below are overwritten to store into a table and not on disk
    *save/read*
    GlobalData
    ProjectData
    ProjectInfo
    LocalInfo 

----------------------
Alpha 1.1 
--------------

*Fixed backup disabled notification on Comment,keyword and description edit.
*Reworked run code
+Server side download location added.
+Share Projects Enabled
+Search Enabled
+Edit comments added (Swipe to edit/save)
+Ability to delete projects added. (swipe)
+Added the ability to disable the update of specified project versions.
+Project, Version, Comments now accept all punctuation characters as well as *
+Reworked the updater. When running CC as a dependency, CC will notify you of an update and ask you to run your Codea Community project to update.
*Fixed Comments
+Update Checker added
+Print messages added from backup toggle and share toggle.
--------------
 
Alpha 1.0.5
--------------
*Pending check for share project and share version
*Comments will no longer read the next line.
*Fixed a blank comment deleted the following line
--------------
 
Alpha 1.0.4.1
--------------
+Attempted Backup of a previous version will now store the version as current.
+Deleteing the current version from WebUI removes the version number from local data.
+Header Info is added when you run a new project with CC as a dependency.
--------------
 
Alpha 1.0.4
--------------
*Moved Community functions from a class to a table
*Pending Function now uses tables over if/then
*Fixed days since last backup print location
 
+Added a print to let the user know if draw has stopped working.
+Backup delete implemented.
+Keywords and Description added to web UI
 
-Removed obsolete methods
--------------
 
Alpha 1.0.3
--------------
*Initial Alpha Release
 
 
 
--]]





















--# Bootstrap
-- bootstrap
local o_setup
local o_draw = function() end
local o_touched = function() end
local s_setup, s_draw, s_touched

s_setup = function()
    debug.sethook()

        Community.init()
        Community.compareDates()
        Community.setupButtonLoc()
        if Community.vars.backupToggle then
            Community.checkBackup()
        end
                
        -- start session
        if Community.vars.opts.Connect == "1" or Community.vars.opts.Connect == "true" then
        local failConnect = Community.connect(function() 
        --Community.CreateCCBtn() 
                    
            Community.checkPending() 
            Community.updater()
            end)
                
        if failConnect then
     
            print("***Please Create a Username & Password***")
            parameter.text("Username")
            parameter.text("Password")
            parameter.action("Submit",function() output.clear() Community.setUser(Username,Password)
                       -- Community.CCBtnCallback()
                        
                end)
        end
        else
            Community.vars.opts["Button"] = "0"
        end

    setup = o_setup
    setup()
    

    
    if Community.vars.opts["Button"] == "1" or Community.vars.opts["Button"] == "true" then
        if draw and draw ~= s_draw then
            o_draw = draw
        end
        draw = s_draw
        if touched and touched ~= s_touched then
            o_touched = touched
        end
        touched = s_touched
    end
    
    if Community.vars.opts["ParamButton"] == "1" then
        parameter.action("CC_Button",function() Community.CCBtnCallback() end)
    end
end

s_draw = function()
    o_draw()
            
    pushStyle()
    pushMatrix()
    resetMatrix()
    viewMatrix(matrix())
    ortho()
    Community.drawButton()
    popMatrix()
    popStyle()

    
end


s_touched = function(t)
    if not CC_Unlock_Button then
        local btnTouch = Community.touchedBtn(t)
        if btnTouch then
            if btnTouch.state == ENDED then 
                Community.CCBtnCallback() print("Clicked") 
            end
        else
            o_touched(t)
        end
    else
        o_touched(t)
    end
end
 
------------------------
--Create Bootstrap
-------------------------
debug.sethook(function(e)

    if setup and setup ~= s_setup then
        o_setup = setup
        setup = s_setup
    end

end, "r")  

 
 
 
 
 
 
 
 
 
 
 
 
 
 

















--# ccVars
--Community.vars
if not Community then Community = {} end

------------
---Local variables for Community
-------------
 
 Community.vars = {}
                                    
    Community.vars.userVersion = readGlobalData("CC_Version")
    Community.vars.User = readGlobalData("CC_User")
    Community.vars.Pass = readGlobalData("CC_Pass")
    Community.vars.ccBtn = nil
    Community.vars.BtnImg = readImage("Documents:CodeaCommunityClientBtn")
    Community.vars.Code = ""
    Community.vars.backupToggle = false
    Community.vars.autoUpdate = readGlobalData("CC_AutoUpdate")
    Community.vars.project = ""
    Community.vars.version = ""
    Community.vars.comments = ""
    Community.vars.author = ""
    Community.vars.license = ""
    Community.vars.assets = {} --Store assets
    Community.vars.dependencies = {} --Store dependencies
    Community.vars.tabs = {} -- Store selected tabs or all
    Community.vars.header = ""
    --Standard options for CC
    Community.vars.opts = {}
    Community.vars.opts.Button = "1"
    Community.vars.opts.NotifyCCUpdate = "1"
    Community.vars.opts.ResetUserOption = "0"
    Community.vars.opts.AddHeaderInfo = "1"
    Community.vars.opts.Connect = "1"
    -----------------------------------
    Community.vars.screenshots = {}
    Community.vars.video = {}
    Community.vars.copyright = ""
    Community.vars.CC_Info = ""
    Community.vars.successSound = 7203
    --http headers
    Community.vars.headers = {}
    Community.vars.headers["Accept"]="text/plain"
    Community.vars.headers["Content-Type"]="application/x-www-form-urlencoded"
    Community.vars.headers["Accept-Charset"]="utf-8"
    --Host
    Community.vars.host = {}
    Community.vars.host["url"] = "http://codea.io/cc/"
    Community.vars.host["dir"] = "alpha/"
    Community.vars.host["connect"] = "connect.php"
    Community.vars.host["ccIndex"] = "dashboard.php"
    Community.vars.host["pending"] = "pending.php"
    Community.vars.host["backup"] = "backup.php"
    Community.vars.host["addUser"] = "AddUser.php"
    Community.vars.host["download"]= "download.php?owner=CodeaCommunity&project=Codea%20Community&version=_latest"
    Community.vars.host["updateCheck"] = "project.php?owner=CodeaCommunity&project=Codea%20Community"..
                                    "&version[]=_latest"
    Community.vars.logo = "http://twolivesleft.com/Codea/CC/CCmainLogo.png"
     Community.vars.BtnImgUrl = "http://twolivesleft.com/Codea/CC/CC_icon.png"
    
    Community.vars.License = {}
    
    Community.vars.License.GPL = [[
--License: GPL V3
--Copyright (c) %d  %s

--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see [http://www.gnu.org/licenses/].
]]

    Community.vars.License.MIT = [[
--The MIT License (MIT)
--
--Copyright (c) %d %s
--
--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:
--
--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.
--
--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.
]]

    Community.vars.License.Apache = [[
--Copyright (c) %d %s
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.
]]    
    Community.vars.License.NoLicense = [[--Copyright (c) %d %s]]
    
    Community.vars.License.PublicDomain = [[--Copyright (c) %d %s
-- Licensed under Creative Commons Zero.
--
-- To the extent possible under law, the person who associated CC0 with
-- this work has waived all copyright and related or neighboring rights
-- to this work.
]]
-------------------------------------

---------------------------
--Get Community.vars
---------------------------
 
Community.GetVars = function()
    return Community.vars
end



















--# Community
--Community
-----------------------------------------------
----------Codea Community Function Table-------
-----------------------------------------------
if not Community then Community = {} end


 
--------------------------
---Set inital Community Variables
-------------------------

--[[Document
--Community.init()
--Description: Sets up CC and loads the config file
--@Param: nil
--Return: nil
--]]
Community.init = function()       
    
    --read ccConfig
    local tabs = listProjectTabs()
    local config = false
    for i=1, #tabs do
        if tabs[i] == "ccConfig" then 
            config = readProjectTab("ccConfig") 
        end
    end
    Community.Config.load(config)
   --if not Community.CCFoundToken then  Community.Config.load(config) end
    if Community.vars.opts["CCFOLDER"] then 
        Community.vars.host["dir"] = Community.vars.opts["CCFOLDER"].."/" 
        print("Folder overwrite: "..Community.vars.host["dir"])
    end

        if readGlobalData("CC_Info") then
            Community.vars.CC_Info = Community.readCC()
        else
            local tbl = {}
            tbl[1] = {}
            tbl[1][1] = Community.vars.project
            tbl[1][2] = "0.0.0"
            tbl[1][3] = os.date("%m/%d/%Y %X")
            Community.saveCC(tbl)
            Community.vars.CC_Info = Community.readCC()
        end      
        
        if Community.vars.autoUpdate == nil then Community.vars.autoUpdate = true end
end
-------------------------
 
------------------------------
------Connect to Server
-----------------------------
--[[Document
--Community.connect(callback)
--Description: Authenticates with the server
--@Param: callback (function)
--Return: nil
--204 conn ok
--406 Incorrect use pass
--403 Forbidden user
--]]
Community.connect = function(CallBack)
    print("connecting...")
    --Community.init()
    local callback = CallBack
    if Community.vars.User == nil or Community.vars.Pass ==nil then return true end
    
    local data = "user="..Community.vars.User.."&password="..Community.vars.Pass
    
--Stop backup of CC
    if not Community.CCFoundToken or readLocalData("CodeaCommunityAdmin") ~= nil then
    if Community.vars.project then data = data.."&project="..Community.vars.project end
    if Community.vars.version then data = data.."&version="..Community.vars.version end
    end
    
    --Is the current project CC
    --if Community.CCFoundToken then data = data..Community.CCFoundToken end
        
    
    http.request(Community.vars.host["url"]..Community.vars.host["dir"]..Community.vars.host["connect"],
        function(data,code,d)
        
            if string.find(code,"204") then print("You are connected.") callback()
            elseif string.find(code,"200") then 
                print("You are connected.")
                
                data = loadstring(data)()
            
                if data["backup"] == 1 then
                    Community.vars.backupToggle = true
                    if Community.vars.backupToggle then
                    Community.checkBackup()
                    end
                end
                callback()
            elseif string.find(code,"406") then print("Invalid Username/Password")
            elseif string.find(code,"403") then print("Forbidden User") 
            else print("Error "..code) print(data)
            end
        end,
        function(res,d)
            print(res)
            print(d)
        end,
        { method="POST", headers=Community.vars.headers, data=data }
    )
end
----------------------------
 
----------------------------
----CC Button
---------------------------
--[[Document
--Community.setupButtonLoc()
--Description: Reads the last saved CC button location
--@Param:
--Return: nil
--]]
--Get location
Community.setupButtonLoc = function()
    
   local loc = readGlobalData("CC_Button_Loc")
    if not loc then 
        loc = {x = 95,y = 95,w = 50,clr = {r=30,g=125,b=165,a=180}}
        Community.vars.ccBtn = loc
        local str = Community.table.tostring(loc)
        saveGlobalData("CC_Button_Loc",str)
    else
        Community.vars.ccBtn = Community.table.totable(loc)
    end
    
     
end
---------------------------
--CC window button
---------------------------
--[[Document
--Community.drawButton()
--Description: Draws the CC button onto the screen
--@Param: nil
--Return: nil
--]]
Community.drawButton = function()
    -- print("draw hooked")

    if Community.vars.User then
        ortho()
        viewMatrix(matrix())
    local img = readImage("Documents:CodeaCommunityClientBtn")
    if img then
    local clr = Community.vars.ccBtn.clr
        
    local x = math.floor(WIDTH*(Community.vars.ccBtn.x/100))
    local y = math.floor(HEIGHT*(Community.vars.ccBtn.y/100))
    --if x + WIDTH < 0 then x = math.fmod(x) print(x) end
    tint(clr.r,clr.g,clr.b,clr.a)
   sprite(img,x,y,Community.vars.ccBtn.w)
        
    end
    end
end
 

--[[Document
--Community.touchedBtn(t)
--Description: Passes touch to the button
--@Param: t (touch)
--Return: nil
--]]
Community.touchedBtn = function(t)
    if t.state == ENDED then
        local x = math.floor(WIDTH*(Community.vars.ccBtn.x/100))
        local y = math.floor(HEIGHT*(Community.vars.ccBtn.y/100))
       local top = y + (Community.vars.ccBtn.w/2)
        local bottom = y - (Community.vars.ccBtn.w/2)
        local right = x + Community.vars.ccBtn.w/2
        local left = x - Community.vars.ccBtn.w/2
    
        if t.x <= right and t.x >= left then
            if t.y <= top and t.y>= bottom then
                Community.CCBtnCallback()
            end
        end
    end
    
    
end
----------------------------
--Create CC Button
----------------------------

--[[Document
--Community.CCBtnCallback()
--Description: Callback to open the Web UI
--@Param: nil
--Return: nil
--]]
Community.CCBtnCallback = function()
   
        
            local o_draw,time = draw,os.clock()
                   -- o_draw = draw
            local CCopen = true
                
                    draw = function()
                        if CCopen then
                            CCopen = false
                            if not Community.CCFoundToken or readLocalData("CodeaCommunityAdmin") ~= nil then
                                if Community.vars.project and Community.vars.version then
                                    openURL(Community.vars.host.url..Community.vars.host["dir"]..
                                    Community.vars.host.ccIndex.."?project="..
                                    Community.url_encode(Community.vars.project)..
                                    "&version="..Community.url_encode(Community.vars.version)..
                                    "&token="..os.date("%H%M%S"),true)
                                else
                                    openURL(Community.vars.host.url..Community.vars.host["dir"]..
                                        Community.vars.host.ccIndex.."?token="..
                                        os.date("%H%M%S"),true)
                                end
                            else
                                openURL(Community.vars.host.url..Community.vars.host["dir"]..
                                        Community.vars.host.ccIndex.."?token="..
                                        os.date("%H%M%S"),true)
                            end
                    output.clear()
        
                    print("******************")
                    print("The draw function has broken! This is a bug with Codea. Please restart this project.")
                    print("******************")
                        else
                            -------------------------
                            ----Check Pending here
                            -------------------------
                            output.clear()
                            Community.checkPending()
                            --------------------------
                            draw = o_draw
                        end
                    
                    end
    
                
                --------
                --Backup Toggle
                ---------
               -- if Community.vars.backupToggle then
                 --   Community.checkBackup()
                --end
                
end
 
------------------------------
---Share
-----------------------------

--[[Document
--Community.share(p)
--Description: Prints share state of a project
--@Param: p (pending)
--Return: print
--]]
Community.share = function(p)
    p.close(function()end)
    if p.data.shared == 1 then print("Sharing of Project/Version enabled") end
    if p.data.shared == 0 then print("Sharing of Project/Version disabled.") end
 
end
 
 
-----------------------------
 
-----------------------------
---------Create New User
----------------------------
--[[Document
--Community.setUser(name,password)
--Description: Sets the user name and password with the server. 
--@Param: name (string)
--@Param: password (string)
--Return: nil
--]]
Community.setUser = function(name,password)
    --Community.init()
    
    http.request(Community.vars.host.url..Community.vars.host["dir"]..
    Community.vars.host.addUser.."?user="..name.."&pass="..password,
        function(data) 
            print(data)
            if data == "ERROR: Name already exists" then
                print("You have already registered this name, saving global data. Please restart Codea")
                saveGlobalData("CC_User",name)
                saveGlobalData("CC_Pass",password)
                parameter.clear()
                if CC_EditBtnParam then CC_EditBtnParam() end
            elseif string.sub(data,1,5) ~= "ERROR" then
                print("User: "..name.." Pass: "..password.." Created! Please Reload Codea Community")
                saveGlobalData("CC_User",name)
                saveGlobalData("CC_Pass",password)
                parameter.clear()
                if CC_EditBtnParam then CC_EditBtnParam() end
            end
        end,
        function(data)
            print("Failed")
            print(data)
        end)
end
--------------------------------------
 























--# Pending
--Pending
if not Community then Community = {} end



--------------------------------------------
---------------Check Pending--------------
--------------------------------------------
--[[Document
--pending.version (table)
--Description: Handles all pendings for version
--pending.version.delete = function(p) Community.deleteVersion(p) end
--pending.version.download = function(p)Community.download(p) end
--pending.version.run = function(p) Community.runCode(p) end
--pending.version.restore = function(p) Community.restore(p) end
--pending.version.share = function(p) Community.share(p) end
--pending.version.update = function(p) p.close(function() end) end
--]]
---Pending Table   
local pending = {}
--Version
pending.version = {}   
pending.version.delete = function(p) Community.deleteVersion(p) end
pending.version.download = function(p)Community.download(p) end
pending.version.run = function(p) Community.runCode(p) end
pending.version.restore = function(p) Community.restore(p) end
pending.version.share = function(p) Community.share(p) end
pending.version.update = function(p) p.close(function() end) end
 
--project
pending.project = {}

 
pending.project.delete = function(p) Community.deleteProject(p) end
pending.project.share = function(p) Community.share(p) end
pending.project.update = function(p) if p.data.backup == 1 then
                                        Community.checkBackup()
                                        print("Backup Enabled.")
                                        p.close(function() end)
                                    else
                                        if p.data.backup == 0 then
                                        print("Backup Disabled")
                                        end
                                        p.close(function() end)
                                    end
                        end
 
 
--check Pending

--[[Document
--Community.checkPending()
--Description: Checks for any unhandled pending requests.
--@Param: nil
--Return: nil
--]]
Community.checkPending = function()

  local success = function(data,rCode)
    
        if string.find(rCode,"200") then
            local res = loadstring(data)
            local pendings = res()   
            ---Reslove Pendings
            for i=1, #pendings do
                local pendProj = pendings[i]
                
                
               if pendProj.action ~= "" then
                pending[pendProj.scope][pendProj.action](pendProj)
                
                else
                pendProj.close()
                print("Error with pending request")
                end
                
            end
        end
        
   end
    
http.request(Community.vars.host.url..Community.vars.host["dir"]..
    Community.vars.host.pending,success ,function(d,c)
         print("Unable to check pending:",d,c)
    Community.checkPending()
    end)
    
end
------------------------------------------



















--# Delete
--Delete

if not Community then Community = {} end


---------------------
--Handle Pending Delete
-----------------------
--[[Document
--Community.deleteVersion(p)
--Description: Handles pending and deletes version info from local data.
--@Param: p (pending)
--Return: nil
--]]
Community.deleteVersion = function(p)
    p.close(function() end) 
 
    print("Backup "..Community.vars.project.." "..p.data.name.." deleted.")
    for i,j in pairs(Community.vars.CC_Info) do    
        if j[1] == Community.vars.project then
            if p.data.name == j[2] then 
                j[2] = "0.0.0"
                Community.saveCC(Community.vars.CC_Info) 
                print("Current version removed from local data.")
            end
                    
        end
    end
 
end
 
--[[Document
--Community.deleteProject(p)
--Description: Notifies user that their project was removed from CC.
--@Param: p (pending)
--Return: nil
--]]
--Project Delete
Community.deleteProject = function(p)
    p.close(function() end) 
    print("Backup "..p.project.name.." deleted.")
end
--------------------



















--# DownloadRestore
--DownloadRestore

if not Community then Community = {} end



----------------------
-----Download
----------------------
--[[Document
--Community.download(pending)
--Description: Downloads the pending download to the project specified in the pending
--@Param: pending (table)
--Return: nil
--]]
Community.download = function(pending)
    pending.close(function(d) print(d) end)
    local projName = pending.project_target
    local exists = listProjectTabs(projName)    
            if #exists >= 1 then
                        Community.deleteTabs(projName)
                        local depNames,depCode = Community.getDependency(pending)
                
                        if depNames then 
                            for i=1, #depNames do
                            saveProjectTab(projName..":".."Dependency"..depNames[i],depCode[i])
                            print("Imported dependency: "..depNames[i])
                            end
                        end
                        
                        
                        for k,l in pairs(pending.data.buffers) do
                            local tab = pending.data.buffers[k].name
                            print(tab)                      
                            local code = pending.data.buffers[k].code
                            if tab == "ccConfig" then
                                Community.Config.load(code)
                                Community.Config.downloadAssets()
                            else
                                saveProjectTab(projName..":"..tab,code)
                            end
                            
                        end
                        
                        print("Project Saved as "..projName)
                        
                else
            print("Invalid save location. Please select the project download again and use a valid project name.")
                end
        
end
-------------------------------
 
 
------------------------
------Restore
------------------------
--[[Document
--Community.restore(pending)
--Description: Similar to download but will restore the current project
--@Param: pending (table)
--Return: nil
--]]
Community.restore = function(pending)
    if pending.data.project == Community.vars.project then
        Community.deleteTabs("self")
                        
            for k,l in pairs(pending.data.buffers) do
                local tab = pending.data.buffers[k].name            
                local code = pending.data.buffers[k].code
                saveProjectTab(tab,code)
            end
        pending.close(function(d) print(d) end)
        print("Project Restored.")
                        
    end
end
-----------------------------



















--# RunCode
--Run Code

if not Community then Community = {} end



------------------------------
---runCode
------------------------------
--[[Document
--Community.runCode(pending)
--Description: Runs the code found in the pending request
--@Param: pending (table)
--Return: nil
--]]
Community.runCode = function(pending)
    
    pending.close(function() end)
    --output.clear()
    
    print("Attempting to run "..pending.data.project)
    new_env = nil
    --Setup Sandbox
    
    local sandboxDisable = function()
        local name = debug.getinfo(1)
        print("*"..name.name.."* has been disabled.")
    end
    local saveProjectTab1 = _G.saveProjectTab
    local _S = _G
    --Sandbox Functions
    
        --Overwrite Read/Save
        _S.CC_GlobalData = {}
        _S.CC_ProjectData = {}
        _S.CC_LocalData = {}
        _S.CC_ProjectInfo = {}
        _S.saveGlobalData = function(field,entry) _S.CC_GlobalData[field] = entry end
        _S.saveProjectData = function(field,entry) _S.CC_ProjectData[field] = entry end
        _S.saveLocalData = function(field,entry) _S.CC_LocalData[field] = entry end
        _S.saveProjectInfo = function(field,entry) _S.CC_ProjectInfo[field] = entry end
        _S.readProjectInfo = function(field) return _S.CC_ProjectInfo[field] end
        _S.readGlobalData = function(field) return _S.CC_GlobalData[field] end
        _S.readProjectData = function(field) return _S.CC_ProjectData[field] end
        _S.readLocalData = function(field) return _S.CC_LocalData[field] end
        
        --saveProjectTab
        _S.saveProjectTab = function(name,code) 
            if string.find(name,":") then 
            saveProjectTab1(name,code) 
            else print("Cannot save tab to current project.\n Contents: ",code) 
            end 
        end
        
        --Debug Disables
        _S.debug.debug = sandboxDisable
        --_S.debug.getfenv = sandboxDisable
        --_S.debug.gethook = sandboxDisable
        _S.debug.getlocal = sandboxDisable
        --_S.debug.getmetatable = sandboxDisable
        _S.debug.getregistry = sandboxDisable
        --_S.debug.getupvalue = sandboxDisable
        --_S.debug.setfenv = sandboxDisable
        --_S.debug.sethook = sandboxDisable
        _S.debug.setlocal = sandboxDisable
        --_S.debug.setmetatable = sandboxDisable
        --_S.debug.setupvalue = sandboxDisable
        --_S.debug.traceback = sandboxDisable
        --_S.setfenv = sandboxDisable
        --_S.loadfile = sandboxDisable
        _S.io = sandboxDisable
        _S.dofile = sandboxDisable
        --_S.saveImage = sandboxDisable
        --_S.spriteList = sandboxDisable
    
        
    local new_env = {}
    setmetatable(new_env,{__index = _S})
    
    local onames,ocode = Community.getDependency(pending)
    local names = " "
    local code = " "
    
    if onames then 
        for i,j in pairs(onames) do
           names = names..", "..onames[i] 
        end
        for i,j in pairs(ocode) do
            code = code.." "..ocode[i]
        end
        print("Dependencies loaded: "..names)
    end
    
        for k=1, #pending.data.buffers do
            code = code..pending.data.buffers[k].code.."\n"   
        end
        
  --  local dispMode = string.gmatch(code,"displayMode(FULLSCREEN)")
   -- if dispMode then print("Fullscreen") displayMode(FULLSCREEN) end

    
    setup,draw,touched,collide,keyboard, orientationChanged = nil,nil,nil,nil,nil,nil
    code = code..[[
     _G.setup = setup
     parameter.clear() Community.CCBtnCallback()
     setup()
    supportedOrientations(ANY)
     CC_draw = draw 
        draw = function() if Community.pendingLoop ~= nil then Community.pendingLoop() end
    pushStyle() pushMatrix() CC_draw() popMatrix() popStyle() 
    pushStyle() pushMatrix() Community.drawButton() popMatrix() popStyle()
    end
     _G.draw = draw
    if touched then
        CC_touched = touched
    else
        CC_touched = function() end
    end
    touched = function(t) CC_touched(t) Community.touchedBtn(t) end
     _G.touched = touched
     _G.keyboard = keyboard
     _G.collide = collide
     _G.orientationChanged = orientationChanged
    ]]

   chunk = loadstring(code)
    setfenv(chunk,new_env)
    
    
    local err,msg = pcall(chunk,"Error loaidng code")
    collectgarbage()
    if err == false then print("***ERROR loading code***\n**Possible external library**") print(msg)end
    
    
end
-----------------------------



















--# Backup
--Backup

if not Community then Community = {} end


----------------------
-----Check Backup
---------------------
--[[Document
--Community.checkBackup()
--Description: Checks to see if the current version has been backed up.
--@Param: nil
--Return: nil
--]]
Community.checkBackup = function()
    local update = false
    local version = ""
 
    for i,j in pairs(Community.vars.CC_Info) do
        if j[1] == Community.vars.project then version = j[2]  end
    end
 
    if version then
        if version == Community.vars.version then
            update = false
        else
            update =  true
        end
            
    else
        Community.addCC(Community.vars.project,Community.vars.version)
        Community.vars.CC_Info = Community.readCC(readGlobalData("CC_Info")) 
    end
    
        
        if update == true then
            Community.getCode()
            Community.backup()
        --else
            --prints time since last backup
           -- Community.compareDates()
        end
end
------------------------------

---------------------
------Backup
---------------------
--[[Document
--Community.backup
--Description: Performes the backup on the current project and version
--@Param: nil
--Return: nil
--]]
Community.backup = function()
    
local SubmitSuccess = function(data,c)
 
            local projFound = false
    
            if string.find(c,"200") or string.find(c,"201") then 
                for i,j in pairs(Community.vars.CC_Info) do    
                    if j[1] == Community.vars.project then
                        projFound = true
                        j[2] = Community.vars.version
                        j[3] = os.date("%m/%d/%Y %X")
                    end
                end
                if not projFound then 
                Community.addCC(Community.vars.project,Community.vars.version) 
                Community.vars.CC_Info = Community.readCC()
                end
        
                Community.saveCC(Community.vars.CC_Info)
               if string.find(c,"201") then 
                --self:connect(function() end) 
                print("New Backup Created ") 
                Community.removeComment()
                sound(SOUND_PICKUP, Community.vars.successSound)
                else
                    print("Backup updated.")
                    Community.removeComment()
                    sound(SOUND_PICKUP, Community.vars.successSound)
                end
                
                -- Updated CC_Info version is previously saved
            elseif string.find(c,"403") then
 
                for i,j in pairs(Community.vars.CC_Info) do    
                    if j[1] == Community.vars.project then
                        j[2] = Community.vars.version
                        Community.saveCC(Community.vars.CC_Info)
                    end
                end
                print("Version already exists.")
                
            else
                print(data)
            
            end
    end
 
    local SubmitFailure = function(data)
    print("FAIL:"..data)
    end
    
     local depName,depCode = Community.getDependencies()
    --if not depName or not depCode then depName = "" depCode = "" end
        
       -- print(Community.url_encode(depCode))
    local data= "sourcecode="..Community.url_encode(Community.vars.Code)..
          "&project="..Community.url_encode(Community.vars.project)..
          "&version="..Community.url_encode(Community.vars.version)..
            depName..depCode
        
        if Community.vars.comments then data = data.."&comments="..Community.url_encode(Community.vars.comments) end
        
   if Community.vars.project and Community.vars.version then
    http.request(Community.vars.host.url..Community.vars.host["dir"]..
    Community.vars.host.backup,
        SubmitSuccess,SubmitFailure,{method="POST",
        headers=Community.vars.headers,data=data})
    end
end
-------------------------------



















--# Updater
--Updater

if not Community then Community = {} end



--------------------------------------
---Update Checker
--------------------------------------
 --[[Document
--Community.updater()
--Description: Checks if the current project is upto date
--@Param: nil
--Return: nil
--]]
Community.updater = function()
    if Community.vars.opts["NotifyCCUpdate"]  == "1" or Community.vars.opts["NotifyCCUpdate"] == "true" then
    local success = function(data,code)
        local res = loadstring(data)
        local CC
        if res then 
            
            CC = res()
        end
    
            --Test Code
        if CC then
            local currentVersion = CC[1].versions[1].name
            local comments = CC[1].versions[1].comments

            if currentVersion ~= Community.vars.userVersion then
                if Community.vars.autoUpdate == true then
                    if Community.updateCC then 
                        print("Updating Codea Community...")
                        Community.updateCC(currentVersion,comments)
                    else
                        alert("New CC version available. Please run your Codea Community project to update!",
                        "New Codea Community Update!")
                    end

                    
                    
                else
                    print("New versions of CC availiable. Please turn on auto updates to update.")
                end
            end
        end
        
    end 
    http.request(Community.vars.host["url"]..
    Community.vars.host["dir"]..
    Community.vars.host["updateCheck"],
        success,function(d)
        print("Unable to check for updates.")end,{method="GET",headers=Community.vars.headers})
    end
end



















--# HelperFunctions
--Helper Functions

if not Community then Community = {} end


----------------
---Load Config Dependencies
------------------
--[[Document
--Community.getDependencies()
--Description: Loads all listed dependencies up as a string to be passed to the server
--@Param: nil
--Return: nil
--]]
Community.getDependencies = function()
    local depName = ""
    local depCode = ""
    local ctr = 0
    local code = ""
    
   for i,j in pairs(Community.vars.dependencies) do
        local tabs = listProjectTabs(j)
        if tabs then
            for k,l in pairs(tabs) do
                if l ~= "Main" then
                local tab = readProjectTab(j..":"..l)
                code = code.."--# "..l.."\n"..tab.."\n"
                end
            end
            depCode = depCode.."&depCode["..ctr.."]="..Community.url_encode(code)
            depName = depName.."&depName["..ctr.."]="..Community.url_encode(j)
            ctr = ctr + 1
            
        else
            print("Invalid dependency listed.")
        end
    end 
    
    return depName,depCode
end


Community.getMain = function()
    return Community.vars.Main or "Main"
end

--[[Document
--Community.listProjectTabs(project)
--Description: Either returns the selective tab list from the config or all the tabs of the project
--@Param: project (string)
--Return: nil
--]]
Community.listProjectTabs = function(project)
        if #Community.vars.tabs >= 1 then
            return Community.vars.tabs
        else
            return listProjectTabs()
        end

end

-----------------------------------
 
--------------------
---Split Tabs
---------------------
--[[Document
--Community.splitTabs(str)
--Description: Splits --#Tab into separate tabs.
--@Param: str (string)
--Return: nil
--]]
Community.splitTabs = function(str)
   local tabs = {}
    local result = {}
    local pat = "(.-)(%w+)%s%#%-%-"
    local colNo = 1
    result[colNo] = {}
   
    if string.find(str,"--#") then
        for code, name in string.gmatch(string.reverse(str),pat) do
                result[colNo] = {}
                result[colNo][1]=string.reverse(name)
                result[colNo][2]=string.reverse(code)
        colNo = colNo + 1
        end
        colNo = 1
        for i=#result,1,-1 do
            tabs[colNo] = {}
            tabs[colNo][1] = result[i][1]
            tabs[colNo][2] = result[i][2]
            colNo = colNo + 1
        end
    else
        print("No tabs found")
        tabs[1] = {}
        tabs[1][1]="Main" 
        tabs[1][2] = str return tabs 
    end
    
    return tabs
end
-------------------------------
 
 
-------------------
----flagged for delete
------------------
Community.GetFilterDone = function(data)
   --after error trap
  tbl=Community.split(data,"|",7)
  --print as test
  for i,d in pairs(tbl) do
    print("ID",d[1])
    print("Name",d[2])
    print("Description",d[3])
    print("Version",d[4])
    print("Comments",d[5])
    print("User",d[6])
    print("Date",d[7])
    print("------------------")
  end
  return tbl
end
-----------------------------
 
 
---------------------
---Split Helper
-------------------
--[[Document
--Community.split(str,delim,cols)
--Description: Splits a string up into a table
--@Param: str (string) - String to split
--@Param: delim (char) - The deliminater to use for the split
--@Param: cols (number) - number of columns to split.
--Return: tbl (table)
--]]
 
Community.split = function(str, delim, cols)
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local lastPos = 1
    local colNo,rowNo=1,1
    result[rowNo]={}
    for part, pos in string.gmatch(str, pat) do
        if colNo>cols then
            rowNo=rowNo+1
            colNo=1
            result[rowNo]={}
        end
        result[rowNo][colNo]= part
        lastPos = pos
        colNo=colNo+1
    end
    -- Handle the last field
 --   colNo=colNo+1
    result[rowNo][colNo]= string.sub(str, lastPos)
    return result
end

local splitString = function(str, delim)
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local lastPos = 1
    local colNo=1
    for part, pos in string.gfind(str, pat) do
        result[colNo]= part
        lastPos = pos
        colNo=colNo+1
    end
    -- Handle the last field
 --   colNo=colNo+1
    result[colNo]= string.sub(str, lastPos)
    return result
end
------------------------------
 
 
---------------
----URL Encode
----------------
--[[Document
--Community.url_encode(str)
--Description: Encodes a string for passing to the server
--@Param: str (string)
--Return: str (string)
--]]
Community.url_encode = function(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w %-%_%.%~])",
        function (c) return string.format ("%%%02X", string.byte(c)) end)
    str = string.gsub (str, " ", "+")
  end
  return str    
end
--------------------------
 
 
---------------
---URL Decode
--------------
--[[Document
--Community.url(decode(str)
--Description: Decodes a string for use in Codea
--@Param: str (string)
--Return: str (string)
--]]
Community.url_decode = function(str)
  str = string.gsub (str, "+", " ")
  str = string.gsub (str, "%%(%x%x)",
      function(h) return string.char(tonumber(h,16)) end)
  str = string.gsub (str, "\r\n", "\n")
  return str
end
----------------------
 
 
-----------------------------
-----Read CC_Info
----------------------------
--[[Document
--Community.readCC()
--Description: Reads CC info from Global data.
--@Param: nil
--Return: tbl (table)
--]]
Community.readCC = function()
    local tbl = Community.split(readGlobalData("CC_Info"),"|",3)
    return tbl
end
----------------------------
 
 
------------------------------
-----------Save CC_Info
------------------------------
--[[Document
--Community.saveCC(tbl)
--Description: Takes a table and saves it into Global data
--@Param: tbl (table)
--Return: nil
--]]
Community.saveCC = function(tbl)
    local t = {}
 
   for i,j in pairs(tbl) do
        for k,l in pairs(j) do
        table.insert(t,l)
        end
    end
    
    --print(table.concat(t,"|"))
    saveGlobalData("CC_Info",table.concat(t,"|"))
end
------------------------------
 
 
------------------------------
-------CC_Info Add new
----------------------
--[[Document
--Community.addCC(proj,version)
--Description: Adds a project and version into CC_Info Global data
--@Param: proj (string) - name of the project
--@param: version (string)
--Return: nil
--]]
Community.addCC = function(proj,version)
    
    local str = readGlobalData("CC_Info")
    str = str.."|"..proj.."|"..version.."|"..os.date("%m/%d/%Y %X")
    saveGlobalData("CC_Info",str)
    
end
-------------------------------
 
 
-----------------------------
-----Delete Tabs
-----------------------------
--[[Document
--Community.deleteTabs(ProjName)
--Description: Removes all tabs in the project. Used for a clean Download.
--@Param: ProjName (string) - Name of the project
--Return: nil
--]]
Community.deleteTabs = function(ProjName)
    local delTabs
    if ProjName == "self" then
        delTabs = listProjectTabs()
        for _,del in pairs(delTabs) do
           if del ~= "Main" and del ~= "main" then saveProjectTab(del,nil) end
        end
    else
        delTabs = listProjectTabs(ProjName)
        for _,del in pairs(delTabs) do
           if del ~= "Main" and del ~= "main" then saveProjectTab(ProjName..":"..del,nil) end
        end
    end 
    
end
------------------------------
 
 
-----------------------------
----save current project
-----------------------------
Community.saveCurrent = function()
   local list = listProjectTabs()
     local projCode = " "
    for i,j in pairs(list) do
    projCode = projCode..readProjectTab(j) 
    
    end
   saveGlobalData("CC_ProjectCode",projCode)
--return projCode
end
----------------------------
 
 
-------------------------
------Remove Backup -- Flagged for delete
-------------------------
Community.removeBackup = function(code)
    code = string.gsub(code,"Backup%(.-%)","")
    return code
end
--------------------------
 
 
---------------------------
-----Compare Dates
--------------------------
--[[Document
--Community.compareDates()
--Description: Compared the last uploaded backup date with the current date.
--@Param: nil
--Return: nil
--]]
Community.compareDates = function()
    local prev = {}
    local oldDate
    
    local currentDate = os.time()
   for i,j in pairs(Community.vars.CC_Info) do
        for k,l in pairs(j) do
            if l == Community.vars.project then
            
                oldDate = j[3]
            end    
        end
    end
    if oldDate then
   prev.month = string.sub(oldDate,1,2)
    prev.day = string.sub(oldDate,4,5)
    prev.year = string.sub(oldDate,7,10)
    prev.hour = string.sub(oldDate,12,13)
    prev.min = string.sub(oldDate,15,16)
    prev.sec = string.sub(oldDate,18,19)
   oldDate = os.time({year=prev.year,month=prev.month,day=prev.day,hour=prev.hour,min=prev.min,sec=prev.sec})
 
 
    diff = math.floor((os.time() - oldDate)/60/60)
    if diff >= 24 then 
        diff = math.floor(diff/24)
        print("It has been "..diff.." day(s) since last backup.")
    elseif diff >= 1 then
        print("It has been "..diff.." hour(s) since last backup.")
    else
       print("You have recently backed up.") 
    end
end
end
----------------------------------------
 
 
------------------------
-----Get Code
------------------------
--[[Document
--Community.getCode()
--Description: Gets all the tabs and code from the project being backed up.
--@Param: nil
--Return: nil
--]]
Community.getCode = function()
    for i,j in pairs(Community.listProjectTabs()) do
        local tab = readProjectTab(j)
        if j == "Main" or j == "main" then
            if Community.vars.opts["AddHeaderInfo"] == "1" or Community.vars.opts["AddHeaderInfo"] == "true" then
               tab = Community.vars.header..tab 
            end
        end
        Community.vars.Code = Community.vars.Code.."\n--# "..j.."\n"..tab
    end
end
 
Community.resetGlobals = function()
   saveGlobalData("CC_User",nil)
    saveGlobalData("CC_Pass",nil)
    saveGlobalData("CC_Info",nil) 
end
---------------------------------
 
 
--Restored 
-----------------------------
-----Read info from main
-----------------------------
Community.readProjectInfo = function()
    local tab = readProjectTab("Main")
    local main = string.match(tab, "%-%-Main:[ \t]*([%w%s%p%*]-)\n") 
    local lmain = main or "Main"
    tab = readProjectTab(lmain)
    local project = string.match(tab, "%-%-%s?Project:[ \t]*([%w%s%p%*]-)\n") 
    local author = string.match(tab, "%-%-%s?Author:[ \t]*([%w%s%p%*]-)\n") 
    local version = string.match(tab, "%-%-%s?Version:[ \t]*([%w%s%p%*]-)\n") 
    local comments = string.match(tab, "%-%-%s?Comments:[ \t]*([%w%s%p%*]-)\n") 
    local options = string.match(tab, "%-%-%s?Options:[ \t]*([%w%s%p%*]-)\n") 
    if options then options = splitString(options,",?%s+") end
     local tabs = string.match(tab, "%-%-%s?Tabs:[ \t]*([%w%s%p%*]-)\n") 
    if tabs then tabs = splitString(tabs,"%s+") else tabs = {} end
     local deps = string.match(tab, "%-%-%s?Dependencies:[ \t]*([%w%s%p%*]-)\n") 
    if deps then deps = splitString(deps,",%s*") else deps = {} end
    if comments == "" or comments ==" " then comments = nil end
    return main,project,author,version,comments,tabs,deps,options
end
----------------------------

----------------------------
-----Remove Comment
----------------------------
Community.removeComment = function()
    if Community.vars.comments then
    local tab = readProjectTab(Community.getMain())
    tab = string.gsub(tab,"--%s?Comments:%s?[%w%s%p%*]-\n","--Comments:\n")
     saveProjectTab(Community.getMain(),tab)
    end
end
 
---------------------------
 

 
---------------------------

---------------------------
------Get Dependencies
----------------------------
Community.getDependency = function(p)
    local code = {}
    local names = {}
    local codestr  = ""

        for i=1, #p.data.dependency do
            table.insert(names,p.data.dependency[i].name)
            for j=1, #p.data.dependency[i].buffers do
                
                    codestr = codestr..p.data.dependency[i].buffers[j].code
            end
            table.insert(code,codestr)
        
        end
        
    if #code == 0 then
        return nil, nil
    else

    return names,code
    end
end
 
-------------------
--Clear User
-------------------
--[[Document
--Community.resetUser()
--Description: This will reset all Global user data. Used if accounts need to be switched
--@Param: nil
--Return: nil
--]]
Community.resetUser = function()
    saveGlobalData("CC_User",nil)
    saveGlobalData("CC_Pass",nil) 
end

-----------------------------
-----SAVE Table
-----------------------------
Community.table = {}
function Community.table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and Community.table.tostring( v ) or
      tostring( v )
  end
end

function Community.table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. Community.table.val_to_str( k ) .. "]"
  end
end

function Community.table.tostring( tbl )

  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, Community.table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        Community.table.key_to_str( k ) .. "=" .. Community.table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

function Community.table.totable(str)

local t = loadstring("return "..str)

return assert(t(),"Can not convert string to table.")
    
end

 
 
 
 
 
 
 
 
 



--# ConfigManager
if not Community then Community = {} end

Community.Config = {}

--[[Document
--Community.Config.load(config)
--Description: Loads the config files
--@Param: config (string)
--Return: nil
--]]
Community.Config.load = function(config)
    if config then
        config = Community.Config.removeComments(config)
        Community.Config.loadHeaders(config)
        Community.Config.loadSettings(config)
        Community.Config.loadDependencies(config)
        Community.Config.loadTabs(config)
        Community.Config.loadAssets(config)
        Community.Config.loadScreenshots(config)
        Community.Config.loadVideo(config)
        Community.Config.createHeader()
    else
        local main,opts,project
        main,
        project,
        Community.vars.author,
        Community.vars.version,
        Community.vars.comments,
        Community.vars.tabs,
        Community.vars.dependencies,
        opts = Community.readProjectInfo()
        if opts then
            local vopts = {}
            for k,v in ipairs(opts) do
                vopts[v] = true
            end
            for k,v in pairs(Community.vars.opts) do
                if vopts[k] then
                    Community.vars.opts[k] = "1"
                elseif vopts["No" .. k] then
                    Community.vars.opts[k] = "0"
                elseif vopts["no" .. k] then
                    Community.vars.opts[k] = "0"
                elseif vopts["NO" .. k] then
                    Community.vars.opts[k] = "0"
                end
            end
        end
        if not project then
            Community.vars.opts.Connect = "0"
            if  main and not Community.CCFoundToken then
                Community.Config.setHeader(main)
              --  Community.Config.createFile()
            else
                Community.Config.createFile()
            end
        end
        if project == "Place Project Name Here" then project = nil end
        Community.vars.project = project
    end
end

--[[Document
--Community.Config.removeComments(config)
--Description: Removed # comments from config
--@Param: config (string)
--Return: nil
--]]
Community.Config.removeComments = function(config)
    local tab = config
    tab = string.gsub(tab,"%#[ \t%w%p]*","")
return tab
end


--[[Document
--Community.Config.loadAssets(config)
--Description: Loads all assets with the [Assets] header
--@Param: config (string)
--Return: nil
--]]
Community.Config.loadAssets = function(config)


    local block = string.match(config,"%[Assets%](.*)%[/Assets%]")
    --print(block)
    
    for path,url in block:gmatch("\n([%w%p]*)[ \t=]([%w%p]*)") do
        
        local tbl = {}
        tbl.path = path
        tbl.url = url
        --local exists = readImage(tbl.path)
        --if exists then tbl.loaded = true else tbl.loaded = false end
        if tbl.path ~= "" then print(path,url) table.insert(Community.vars.assets,tbl) end
        --Community.Config.downloadAssets()
    
    end
    

end


--[[Document
--Community.Config.loadSettings(config)
--Description: Loads all CC settings in the tag [Settings]
--@Param: config (string)
--Return: nil
--]]
Community.Config.loadSettings = function(config)
    local block = string.match(config,"%[Settings%](.*)%[/Settings%]")

    for setting,state in string.gmatch(block,"\n([%w]*)[ \t%=]([%w]*)") do
       if setting ~= "" then Community.vars.opts[setting] = state end
    end
end

--[[Document
--Community.Config.loadDependencies(config)
--Description: Loads all dependencies with the header [Dependencies].
--@Param: config (string)
--Return: nil
--]]
Community.Config.loadDependencies = function(config)
    local block = string.match(config,"%[Dependencies%](.*)%[/Dependencies%]")

    for dep in string.gmatch(block,"\n([%w%p ]*)") do
        
        if dep ~= "" then
            dep = string.gsub(dep," ","_")
            table.insert(Community.vars.dependencies,dep) 
        end
    end
end


--[[Document
--Community.Config.loadScreenshots(config)
--Description: Loads screenshots in the header [Screenshots].
--@Param: config (string)
--Return: nil
--]]
Community.Config.loadScreenshots = function(config)
    local block = string.match(config,"%[Screenshots%](.*)%[/Screenshots%]")
    for screenshot in string.gmatch(block,"\n([%w%p]*)") do
       if screenshot ~= "" then
        table.insert(Community.vars.screenshots,screenshot)
        end 
    end
end

--[[Document
--Community.Config.loadVideo(config)
--Description: Loads video links in the header [Video].
--@Param: config (string)
--Return: nil
--]]
Community.Config.loadVideo = function(config)
    local block = string.match(config,"%[Video%](.*)%[/Video%]")
    for video in string.gmatch(block,"\n([%w%p]*)") do
       if video ~= "" then
        table.insert(Community.vars.video,video)
        end 
    end
    
end


--[[Document
--Community.Config.loadTabs(config)
--Description: Excludes tabs from backup *str is a front match, str* is a back match.
--@Param: config (string)
--Return: nil
--]]
Community.Config.loadTabs = function(config)
    local tabList = listProjectTabs()
    local block = string.match(config,"%[Tabs%](.*)%[/Tabs%]")

    for key,tab in string.gmatch(block,"\n(%w*)[ \t]*(%*?[%w]*%*?)") do
    
        if tab == nil then tab = "" end
           if tab == "*" then
            tabList = {}
        end
       if tab ~= "" then 
            --match front
            if string.match(tab,"^%*[%w]*") then
            
                local str = string.match(tab,"^%*(%w*)")
               for i,j in pairs(tabList) do
                    if string.match(j,str.."$") then
                        if key == "not" then
            
                        tabList[i] = nil
                        end
                    end
                end
            --match back
            elseif string.match(tab,"[%w]*%*$") then
                
                local str = tab
                for i,j in pairs(tabList) do
                    if string.match(j,"^"..str) then
                        if key == "not" then
                        tabList[i] = nil
                        end
                        --table.remove(tabList,i)
                    end
                end
            
            else
                
                local str = tab
                if key == "add" then
                table.insert(tabList,str)
                    
                else
                   for i,j in pairs(tabList) do
                        if j == tab then 
                            tabList[i] = nil
                        end
                    end
                end 

            end
        end
    end
    
    Community.vars.tabs = tabList
end



--[[Document
--Community.Config.loadHeaders(config)
--Description: Loads project headers from the config.
--ProjectName:
--Version:
--Author:
--License:
--@Param: config (string)
--Return: nil
--]]
Community.Config.loadHeaders = function(config)
    Community.vars.project = string.match(config,"\nProjectName:[ \t]*([%w %p%*]*)")
    if Community.vars.project == "Place Project Name Here" then Community.vars.project = "" end
    Community.vars.version = string.match(config,"\nVersion:[ \t]*([%w %p%*]*)")
    Community.vars.comments = string.match(config,"\nComments:[ \t]*([%w %p%*]*)")
    Community.vars.author = string.match(config,"\nAuthor:[ \t]*([%w %p%*]*)")
    local lic = string.match(config,"\nLicense:[ \t]*(%w*)")
    Community.vars.license = string.format(Community.vars.License[lic],os.date("%Y"),Community.vars.author)
    
end

--[[Document
--Community.Config.createHeader()
--Description: Creates the header files that is placed into Main.lua
--@Param: nil
--Return: nil
--]]
Community.Config.createHeader = function()

    local project = "Project: "..Community.vars.project
    local version = "Version: "..Community.vars.version
    local author = "Author: "..Community.vars.author
    local license = Community.vars.license
    Community.vars.header = string.format([[
--------------------------------------------------------------
--%s
--%s
--%s


%s
]],project,version,author,license)    
end

--[[Document
--Community.Config.addHeader(tab)
--Description: Adds the header into main
--@Param: tab (string)
--Return: nil
--]]
Community.Config.addHeader = function(tab)
    local output = Community.vars.header.."\n\n"..tab
return output
end



--[[Document
--Community.Config.downloadAssets()
--Description: Downloads any assets in the config with the provided link
--@Param: nil
--Return: nil
--]]
Community.Config.downloadAssets = function()
    for i=1, #Community.vars.assets do
       if not Community.vars.assets[i].loaded then
            Community.Config.download(i)
        end
    end
end

Community.Config.download = function(asset)
    
    local success = function(d)
        saveImage(Community.vars.assets[asset].path,d)
        Community.vars.assets[asset].loaded = true
        end
    local fail = function(d)
        print("Problem downloading asset\n"..d)
    end
        
    http.request(Community.vars.assets[asset].url,success,fail)
    
end

--[[Document
--Community.Config.createFile()
--Description: Creates a new config file
--@Param: nil
--Return: nil
--]]
Community.Config.createFile = function()
local str = [=[--[[
###########################################
##Codea Community Project Config Settings##
###########################################

##You can use # to comment out a line
##Use 1 for true and 0 for false


###########################################
#       Add project info below            #
#==========================================
ProjectName: Place Project Name Here
Version: Alpha 1.0
Comments:
Author:
##License Info: http://choosealicense.com
##Supported Licneses: MIT, GPL, Apache, NoLicense
License: MIT
#==========================================


###########################################
#                Settings                 #
[Settings]=================================
##Codea Community Configuration settings
##Format: Setting state

Button 1
ParamButton 0
NotifyCCUpdate 1
ResetUserOption 0
AddHeaderInfo 1
Connect 1

[/Settings]================================



###########################################
#              Screenshots                #
[Screenshots]==============================
##Screenshots from your project.
##Format: url
##Example: http://www.dropbox.com/screenshot.jpg


[/Screenshots]=============================



###########################################
#                   Video                 #
[Video]====================================
##Link to a YouTube.com video.
##Format: url
##Example: http://www.youtube.com/videolink


[/Video]===================================



###########################################
#              Dependencies               #
[Dependencies]=============================
##Include the names of any dependencies here
##Format: Dependency
##Example: Codea Community


[/Dependencies]============================



############################################
#                   Tabs                   #
[Tabs]======================================
##Select which tabs are to be uploaded.
##Keyword 'not' excludes a tab or tabs. Keyword 'add' includes a tab or tabs.
##not * will exclude all tabs to allow for individual selection
##not *tab1 will look for any tab with tab1 on the end.
##not tab1* will look for any tab with tab1 at the beginning.
##Format: (add/not)(*)tab(*)
##Example: not Main --this will remove main.
##Example: not *tab1 --this will remove any tab with "tab1" on the end.
##Example: add Main --This will add Main back in.



[/Tabs]=====================================



#############################################
#                  Assets                   #
[Assets]=====================================
##Directory, path and url info for any assets besides the standard Codea assets.
##Format: Folder:sprite URL
##Example: Documents:sprite1 http://www.somewebsite.com/img.jpg


[/Assets]====================================
--]]

]=]
    
        saveProjectTab("ccConfig",str)
        print("ccConfig created!")
    

end

--[[Document
--Community.Config.setHeader()
--Description: Creates a new config header
--@Param: Tab to create header in
--Return: nil
--]]
Community.Config.setHeader = function(lmain)
    lmain = lmain or "Main"
    print([[**********************************
    *Please edit header info in ]] .. lmain .. [[.*
    **********************************]])
    local str = "--The name of the project must match your Codea project name if dependencies are used. \n"..
                "--Project: Place Project Name Here\n"..
                "--Author:\n" ..
                "--Version: Alpha 1.0\n"..
                "--Comments:\n\n"..readProjectTab(lmain)
    saveProjectTab(lmain,str) 
end



--# ccConfig
--[[
###########################################
##Codea Community Project Config Settings##
###########################################

##You can use # to comment out a line
##Use 1 for true and 0 for false


###########################################
#       Add project info below            #
#==========================================
ProjectName: Codea Community
Version: Beta 1.1.1.3
Comments: Updated to codea.io
Author: Toffer, Ignats, Andrew_Stacey and Briarfox
##License Info: http://choosealicense.com
##Supported Licneses: MIT, GPL, Apache, NoLicense
License: MIT
#==========================================


###########################################
#                Settings                 #
[Settings]=================================
##Codea Community Configuration settings
##Format: Setting state

Button 1
ParamButton 1
NotifyCCUpdate 0
ResetUserOption 1
AddHeaderInfo 1
Connect 1

[/Settings]================================



###########################################
#              Screenshots                #
[Screenshots]==============================
##Screenshots from your project.
##Format: url
##Example: http://www.dropbox.com/screenshot.jpg


[/Screenshots]=============================



###########################################
#                   Video                 #
[Video]====================================
##Link to a YouTube.com video.
##Format: url
##Example: http://www.youtube.com/videolink


[/Video]===================================



###########################################
#              Dependencies               #
[Dependencies]=============================
##Include the names of any dependencies here
##Format: Dependency
##Example: Codea Community


[/Dependencies]============================



############################################
#                   Tabs                   #
[Tabs]======================================
##Select which tabs are to be uploaded.
##Keyword 'not' excludes a tab or tabs. Keyword 'add' includes a tab or tabs.
##not * will exclude all tabs to allow for individual selection
##not *tab1 will look for any tab with tab1 on the end.
##not tab1* will look for any tab with tab1 at the beginning.
##Format: (add/not)(*)tab(*)
##Example: not Main --this will remove main.
##Example: not *tab1 --this will remove any tab with "tab1" on the end.
##Example: add Main --This will add Main back in.



[/Tabs]=====================================



#############################################
#                  Assets                   #
[Assets]=====================================
##Directory, path and url info for any assets besides the standard Codea assets.
##Format: Folder:sprite URL
##Example: Documents:sprite1 http://www.somewebsite.com/img.jpg


[/Assets]====================================
--]]

