

function setup()
    displayMode(OVERLAY)
    displayMode(FULLSCREEN)
    world = {}
    buttons = {}
    touch = false
    move = vec2(350, 350)
    value = ""
    smiley = readImage("Planet Cute:Character Horn Girl")
    movedirection = "nil"
    gravity = 10
end

function draw()
    background(0, 0, 0, 255)
    for x = 1, 25 do world[x] = {} for y = 1, 25 do world[x][y] = {}
        fill(0, 0, 0, 255)
        stroke(127, 127, 127, 255)
        strokeWidth(2.5)
        rect(x * 25, y * 25, 25, 25)
    end end
    for x = 1, 3 do buttons[x] = {} for y = 1, 2 do
        buttons[x][y] = {}
        fill(255, 255, 255, 255)
        strokeWidth(0)
        rect(x * 75 + 650, y * 75 + 15, 75, 75)
        end end
    if touch then
        if movedirection == "Right" then
            move.x = move.x + 5
        elseif movedirection == "Left" then
            move.x = move.x - 5
        elseif movedirection == "Up" then
            move.y = move.y + 100
        elseif movedirection == "Down" then
            move.y = move.y - 5
        end
    end
    sprite(smiley, move.x, move.y, 45, 100)
    if move.y > 50 then move.y = move.y - gravity end
end

function touched(t)
    if t.state == ENDED then
        touch = false
        movedirection = "nil"
    else
        touch = true
        if t.x>725 and t.x<800 and t.y>90 and t.y<165 then
            print("Left")
            movedirection = "Left"
        elseif t.x>800 and t.x<875 and t.y>90 and t.y<165 then
            print("Down")
            movedirection = "Down"
        elseif t.x>875 and t.x<950 and t.y>90 and t.y<165 then
            print("Right")
            movedirection = "Right"
        elseif t.x>800 and t.x<875 and t.y>165 and t.y<240 then
            print("Up")
            movedirection = "Up"
        end
    end
end
