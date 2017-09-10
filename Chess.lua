
function setup()
    displayMode(OVERLAY)
    IMAGE_NULL = image(1, 1)
    tab = {}
    for x = 1, 8 do
        tab[x] = {}
        for y = 1, 8 do
            tab[x][y] = {}
            -- Table
            tab[x][y].color = 0
            --[[
            1 – White
            2 – Black
            ]]
            tab[x][y].type = 0
            --[[
            0 – Empty
            1 – "Пешка"
            2 – King
            3 – Queen
            4 – Bishop
            5 – Horse
            6 - Tower
            ]]
            
            -- 1
            if (y == 8) or (y == 1) then
                tab[x][y].color = 1
                if y == 1 then
                    tab[x][y].color = 2
                end
                if (x == 1) or (x == 8) then
                    tab[x][y].type = 6
                elseif (x == 2) or (x == 7) then
                    tab[x][y].type = 5
                elseif (x == 3) or (x == 6) then
                    tab[x][y].type = 4
                elseif (x == 4) then
                    tab[x][y].type = 2
                elseif (x == 5) then
                    tab[x][y].type = 3
                end
            elseif y == 7 then
                tab[x][y].color = 1
                tab[x][y].type = 1
            elseif y == 2 then
                tab[x][y].color = 2
                tab[x][y].type = 1
            end
        end
    end
    
    --ori = CurrentOrientation
    
    fig = {}
    fig[1] = {}
    fig[2] = {}
    SpriteAssets()
    
    SELECTED = vec2(5, 4)
    ROUND_ = 1 -- White : 1; Black : 2
end

function draw()
    local w = math.min(WIDTH, HEIGHT)/8
    
    -- Chess Field
    resetStyle()
    local n = 0
    for x = 1, 8 do
        for y = 1, 8 do
            n = n + 1
            if n%2 == 1 then
                fill(120, 70, 70)
            else
                fill(160, 130, 110)
            end
            rect(WIDTH/2-(x-4)*w, HEIGHT/2-(y-4)*w, w, w)
            
            local c = tab[x][y].color
            local t = tab[x][y].type
            if t > 0 and c > 0 then
                sprite(fig[c][t] or IMAGE_NULL, WIDTH/2-(x-4)*w+w*.5, HEIGHT/2-(y-4)*w+w*.5)
            end
            
            if findWays(x, y) then
                fill(255, 200, 0)
                ellipse(WIDTH/2-(x-4.5)*w, HEIGHT/2-(y-4.5)*w, w/2)
            end
        end
        n = n + 1
    end
            
    fill(0, 0)
    strokeWidth(5)
    stroke(150, 175, 255)
    rect(WIDTH/2-(SELECTED.x-4)*w, HEIGHT/2-(SELECTED.y-4)*w, w, w)
end

function touched(t)
    for x = 1, 8 do
        for y = 1, 8 do
            local w = math.min(WIDTH, HEIGHT)/8
            --rect(WIDTH/2-(x-4)*w, HEIGHT/2-(y-4)*w, w, w)
            if t.x>WIDTH/2-(x-4)*w and t.y>HEIGHT/2-(y-4)*w and t.x<WIDTH/2-(x-5)*w and t.y<HEIGHT/2-(y-5)*w then
                if t.state == ENDED then
                    if SELECTED.x == x and SELECTED.y == y then
                        SELECTED = vec2(0, 0)
                    elseif findWays(x, y) then
                        move(SELECTED.x, SELECTED.y, x, y)
                    end
                    SELECTED.x, SELECTED.y = x, y
                end
            end
        end
    end
end

function move(fromX, fromY, toX, toY)
    tab[toX][toY].type = tab[fromX][fromY].type
    tab[toX][toY].color = tab[fromX][fromY].color
    tab[fromX][fromY].type = 0
    tab[fromX][fromY].color = 0
    
    if ROUND_ == 1 then -- White
        ROUND_ = 2
    else -- Black
        ROUND_ = 1
    end
end

function findWays(x, y)
    -- Nothing selected
    if SELECTED.x == 0 and SELECTED.y == 0 then
        return false
    end
    
    -- Find ways
    if tab[SELECTED.x][SELECTED.y].type == 0 then -- Not empty
        return false
    elseif not ( tab[SELECTED.x][SELECTED.y].color == ROUND_ ) then -- Your color
        return false
    elseif (not tab[SELECTED.x][SELECTED.y].type == 0) and tab[SELECTED.x][SELECTED.y].color == ROUND_ then -- Not empty, your figure
        return false
    end
    
    if tab[SELECTED.x][SELECTED.y].color == 1 then -- Пешки, White
        if tab[SELECTED.x][SELECTED.y].type == 1 then
            if y == SELECTED.y - 1 and SELECTED.x == x and tab[SELECTED.x][SELECTED.y-1].type == 0 then
                return true
            elseif y == 5 and SELECTED.y == 7 and SELECTED.x == x and tab[SELECTED.x][SELECTED.y-1].type == 0 then
                return true
            end
        end
    else
        if tab[SELECTED.x][SELECTED.y].type == 1 then -- Black
            if y == SELECTED.y + 1 and SELECTED.x == x and tab[SELECTED.x][SELECTED.y+1].type == 0 then
                return true
            elseif y == 4 and SELECTED.y == 2 and SELECTED.x == x and tab[SELECTED.x][SELECTED.y+1].type == 0 then
                return true
            end
        end
    end
    
    return false
end

--[[function orientationChanged(o)
    if not ( ori == CurrentOrientation ) then
        ori = CurrentOrientation
        -- Do your code when changing orientation here
        if (ori == 0) or (ori == 1) then -- PORTRAIT
            
        else -- LANDSCAPE
            
        end
    end
end]]

function SpriteAssets()
    local col = {}
    col[1] = {}
    col[1][1] = color(255)
    col[1][2] = color(150)
    col[1][3] = color(215, 150, 150)
    col[2] = {}
    col[2][1] = color(0)
    col[2][2] = color(100)
    col[2][3] = color(150, 0, 0)
    
    for n = 1, 2 do
        -- Пешка
        resetStyle()
        do
            local m = image(100, 100)
            local msh = mesh()
            msh.vertices = {vec2(15, 15), vec2(85, 15), vec2(50, 70)}
            msh.colors = {col[n][1], col[n][1], col[n][2]}
            setContext(m)
            msh:draw()
            fill(col[n][1])
            ellipse(50, 70, 40)
            fig[n][1] = m
        end
        
        -- King
        resetStyle()
        do
            local m = image(100, 100)
            local msh = mesh()
            msh.vertices = {vec2(30, 15), vec2(70, 15), vec2(50, 90)}
            msh.colors = {col[n][1], col[n][1], col[n][3]}
            setContext(m)
            msh:draw()
            fill(col[n][3])
            ellipse(50, 70, 40)
            stroke(col[n][1])
            strokeWidth(3)
            lineCapMode(SQUARE)
            line(50, 51, 50, 89)
            line(31, 70, 69, 70)
            fig[n][2] = m
        end
        
        -- Queen
        resetStyle()
        do
            local m = image(100, 100)
            local msh = mesh()
            msh.vertices = {vec2(30, 15), vec2(70, 15), vec2(50, 90)}
            msh.colors = {col[n][1], col[n][1], col[n][3]}
            setContext(m)
            msh:draw()
            fill(255 - col[n][1].r) -- col[n][1].r, col[n][1].g, col[n][1].b are same values; inverted
            ellipse(50, 85, 10)
            fill(col[n][3])
            ellipse(50, 70, 30)
            fig[n][3] = m
        end
        
        -- Bishop
        do
            local m = image(100, 100)
            local msh = mesh()
            msh.vertices = {vec2(30, 15), vec2(70, 15), vec2(50, 80)}
            msh.colors = {col[n][1], col[n][1], col[n][2]}
            setContext(m)
            msh:draw()
            fill(col[n][1])
            ellipse(50, 70, 30)
            fig[n][4] = m
        end
        
        --🐴🐎🎠
        -- Horse
        resetStyle()
        do
            local m = image(100, 100)
            local msh = mesh()
            msh.vertices = {vec2(15, 55), vec2(55, 65), vec2(75, 85)}
            msh.colors = {col[n][1], col[n][2], col[n][1]}
            local msh1 = mesh()
            msh1.vertices = {vec2(50, 15), vec2(55, 65), vec2(75, 85)}
            msh1.colors = {col[n][1], col[n][2], col[n][1]}
            setContext(m)
            msh:draw()
            msh1:draw()
            fill(col[n][2])
            strokeWidth(3)
            stroke(col[n][1])
            rect(15, 15, 70, 35)
            fig[n][5] = m
        end
        
        -- Tower
        resetStyle()
        do
            local m = image(100, 100)
            local msh = mesh()
            local msh1 = mesh()
            msh.vertices = {vec2(25, 15), vec2(75, 15), vec2(75, 85)}
            msh.colors = {col[n][1], col[n][1], col[n][3]}
            msh1.vertices = {vec2(25, 15), vec2(75, 85), vec2(25, 85)}
            msh1.colors = {col[n][1], col[n][3], col[n][3]}
            setContext(m)
            --[[
            fill(col[n][1])
            rect(25, 15, 50, 70)
              ]]
            msh:draw()
            msh1:draw()
            fill(col[n][2])
            rect(20, 70, 10, 20)
            rect(30, 70, 10, 20)
            rect(40, 70, 10, 20)
            rect(50, 70, 10, 20)
            rect(60, 70, 10, 20)
            rect(70, 70, 10, 20)
            fig[n][6] = m
        end
    end
    
    setContext()
end
