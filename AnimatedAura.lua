-- ART
displayMode(OVERLAY)
displayMode(FULLSCREEN)

function setup()
    x = 500
    y = 425
    v = 1
    z = 255
    vmove = true
    zmove = true
    d = ((v%z)/(z%v)+(z*(2/3))/(v/3.5)*(45/3)/(54321/97984)+(-4)/(z - 3.897532)*(v%z -50))+4
    m = (d / 2.45 + v)/(z%(v*d)+(v+5)/(z*2.4)*(z+d)/(45/23))*(45/3.4)%(45+v)
    f = (2 / z)-(z - v * 1.582)+(2 * v)-(255 - z)+((200 % v * 2)-(v/19 + v))-(z/(23 - v))
    -- Set here the parameters! R = red; B = blue, G = green;
    r = 75
    g = 50
    b = 250
    name = "папа" -- Dad
    size = 25
    txt = "с днём рождение" -- Happy birthday
    
    parameter.watch("v")
    parameter.watch("z")
end

function draw()
    background(z + v, 0, z, 255)
    -- This is the basic example
    if vmove == true then
        v = v + .5
    else
        v = v - .5
    end
    
    if zmove == true then
        z = z - .5
    else
        z = z + .5
    end
    
    if v == 255 then
        vmove = false
    end
    
    if z == 1 then
        zmove = false
    end
    
    if v == 1 then
        vmove = true
    end
    
    if z == 255 then
        zmove = true
    end
    
    fill(0, 0, 0, 255)
    ellipse(z - 2, v + 2, 50)
    ellipse(WIDTH-z - 2, HEIGHT-v + 2, 50)
    ellipse(z - 2, HEIGHT-v + 2, 50)
    ellipse(WIDTH-z - 2, v + 2, 50)
    ellipse(v - 2, z + 2, 50)
    ellipse(WIDTH-v - 2, HEIGHT-z + 2, 50)
    ellipse(v - 2, HEIGHT-z + 2, 50)
    ellipse(WIDTH-v - 2, z + 2, 50)
    
    fill(g, b, r, 255)
    ellipse(v, z, 50)
    ellipse(WIDTH-v, HEIGHT-z, 50)
    ellipse(v, HEIGHT-z, 50)
    ellipse(WIDTH-v, z, 50)
    
    fill(r, g, b, 255)
    ellipse(z, v, 50)
    ellipse(WIDTH-z, HEIGHT-v, 50)
    ellipse(z, HEIGHT-v, 50)
    ellipse(WIDTH-z, v, 50)
    
    fill(m, d, f, 255)
    ellipse(x - 68, y + 68, 500)
    
    fill((255 - z)/(z - v), (z - 50)*(v + 50)/(5/z + 7.5/v), b + z, 255)
    ellipse(x - 66, y + 66, 490)
    
    fill(z, v, (v/579 * 578)+(z/179 * 180))
    ellipse(x - 64, y + 64, 450)
    
    fill(z/v/5/z/z/2, v/19*20/3 * z/7*10/5/2, b + z, 255)
    ellipse(x - 62, y + 62, 410)
    
    fill((z/3)*(v/6), (z/2.75)/(v/5.5), 100, 255)
    ellipse(x - 60, y + 60, 375)
    
    fill(v, z, (z - 25)*(v + 50), 255)
    ellipse(x - 58, y + 58, 350)
    
    fill(v, 150, 220, 255)
    ellipse(x - 56, y + 56, 325)
    
    fill(r * z, g * 2, b * v, 255)
    ellipse(x - 54, y + 54, 300)
    
    fill(v, g, z * v, 255)
    ellipse(x - 52, y + 52, 280)
    
    fill(z, z, v, 255)
    ellipse(x - 50, y + 50, 260)
    
    fill(v, z, v, 255)
    ellipse(x - 48, y + 48, 240)
    
    fill(0, g * 2, b - 10 + z/3.5, 255)
    ellipse(x - 46, y + 46, 220)
    
    fill(r*1.75, g*2.25, z * 0.01, 255)
    ellipse(x - 44, y + 44, 200)
    
    fill(x, x/2 - v, r*g*b / z / 2, 255)
    ellipse(x - 42, y + 42, 175)
    
    fill(r, r * 2, b, 255)
    ellipse(x - 40, y + 40, 155)
    
    fill(r * 2, r, g + 100 / 3 - 5, 255)
    ellipse(x - 38, y + 38, 140)
    
    fill(r, z, r, 255)
    ellipse(x - 36, y + 36, 127.5)
    
    fill(b, r, v, 255)
    ellipse(x - 34, y + 34, 115)
    
    fill(v, b, g, 255)
    ellipse(x - 32, y + 32, 105)
    
    fill(b, v, g, 255)
    ellipse(x - 30, y + 30, 95)
    
    fill(g, b, z, 255)
    ellipse(x - 28, y + 28, 85)
    
    fill(r - 10, g * 1.75, b - 100, 255)
    ellipse(x - 26, y + 26, 75)
    
    fill(r + 0.5 * g - b, g + 0.5 * r, b + r * g, 255)
    ellipse(x - 24, y + 24, 70)
    
    fill(r / 2.5 / 3 * 5.889, g - b, b - g, 255)
    ellipse(x - 22, y + 22, 65)
    
    fill(r * 0.15, g * 1.75, b - 25, 255)
    ellipse(x - 20, y + 20, 60)
    
    fill(r * 2.105, g, 200, 255)
    ellipse(x - 17.5, y + 18, 55)
    
    fill(125, 145, r * g / b)
    ellipse(x - 15, y + 16, 50)
    
    fill(r/b * g, b/g * r, g/b * r, 255)
    ellipse(x - 14, y + 14, 45)
    
    fill(r / g, g / b, b / r, 255)
    ellipse(x - 12.5, y + 12, 40)
    
    fill(r * g / 2, g * b / 2, b * 20 / 19 * 50 / 49 * 2, 255)
    ellipse(x - 10, y + 10, 35)
    
    fill(r / 50 * 45, g + 50, b * 0.2 - 45, 250)
    ellipse(x - 8.5, y + 8, 30)
    
    fill(z * 100 / 99, g * 50 / 3 + 50 / 1.75, v * 0.9, 255)
    ellipse(x - 6.5, y + 6, 25)
    
    fill(r/2 * 1.75, g/3 * 2.75/4 * 5, b - 50, 255)
    ellipse(x - 4, y + 4, 20)
    
    fill(z, g, b, 255)
    ellipse(x - 2, y + 2, 15)
    
    fill(r * v - g * v + b * v, (r * g * b)+(z/3 - v/4), b, 255)
    fontSize(size)
    font("AmericanTypewriter")
    text(txt .. ", " .. name .. "!", x, y - 300)
end
