-- ART
displayMode(OVERLAY)
displayMode(FULLSCREEN)

function setup()
    x = 500
    y = 450
    v = 1
    z = 255
    -- Set here the parameters! R = red; B = blue, G = green;
    r = 75
    g = 50
    b = 250
    name = "TokOut" -- This is my forum nickname
    size = 25
    txt = "Hello"
    
    parameter.watch("v")
    parameter.watch("z")
end

function draw()
    background(z + v, 0, z, 255)
    -- This is the basic example
    v = v + .5
    z = z - .5
    
    if v == 255 then
        v = 1
    end
    
    if z == 0 then
        z = 255
    end
    
    fill(z/v/5/z/z/2, v/19*20/3 * z/7*10/5/2, b + z, 255)
    ellipse(x, y, 400)
    
    fill((z/3)*(v/6), (z/2.75)/(v/5.5), 100, 255)
    ellipse(x, y, 375)
    
    fill(v, z, (z - 25)*(v + 50), 255)
    ellipse(x, y, 350)
    
    fill(v, 150, 220, 255)
    ellipse(x, y, 325)
    
    fill(r * z, g * 2, b * v, 255)
    ellipse(x, y, 300)
    
    fill(v, g, z * v, 255)
    ellipse(x, y, 280)
    
    fill(z, z, v, 255)
    ellipse(x, y, 260)
    
    fill(v, z, v, 255)
    ellipse(x, y, 240)
    
    fill(0, g * 2, b - 10 + z/3.5, 255)
    ellipse(x, y, 220)
    
    fill(r*1.75, g*2.25, z * 0.01, 255)
    ellipse(x, y, 200)
    
    fill(x, x/2 - v, r*g*b / z / 2, 255)
    ellipse(x, y, 175)
    
    fill(r, r * 2, b, 255)
    ellipse(x, y, 155)
    
    fill(r * 2, r, g + 100 / 3 - 5, 255)
    ellipse(x, y, 140)
    
    fill(r, z, r, 255)
    ellipse(x, y, 127.5)
    
    fill(b, r, v, 255)
    ellipse(x, y, 115)
    
    fill(v, b, g, 255)
    ellipse(x, y, 105)
    
    fill(b, v, g, 255)
    ellipse(x, y, 95)
    
    fill(g, b, z, 255)
    ellipse(x, y, 85)
    
    fill(r - 10, g * 1.75, b - 100, 255)
    ellipse(x, y, 75)
    
    fill(r + 0.5 * g - b, g + 0.5 * r, b + r * g, 255)
    ellipse(x, y, 70)
    
    fill(r / 2.5 / 3 * 5.889, g - b, b - g, 255)
    ellipse(x, y, 65)
    
    fill(r * 0.15, g * 1.75, b - 25, 255)
    ellipse(x, y, 60)
    
    fill(r * 2.105, g, 200, 255)
    ellipse(x, y, 55)
    
    fill(125, 145, r * g / b)
    ellipse(x, y, 50)
    
    fill(r/b * g, b/g * r, g/b * r, 255)
    ellipse(x, y, 45)
    
    fill(r / g, g / b, b / r, 255)
    ellipse(x, y, 40)
    
    fill(r * g / 2, g * b / 2, b * 20 / 19 * 50 / 49 * 2, 255)
    ellipse(x, y, 35)
    
    fill(r / 50 * 45, g + 50, b * 0.2 - 45, 250)
    ellipse(x, y, 30)
    
    fill(z * 100 / 99, g * 50 / 3 + 50 / 1.75, v * 0.9, 255)
    ellipse(x, y, 25)
    
    fill(r/2 * 1.75, g/3 * 2.75/4 * 5, b - 50, 255)
    ellipse(x, y, 20)
    
    fill(z, g, b, 255)
    ellipse(x, y, 15)
    
    fill(r * v - g * v + b * v, (r * g * b)+(z/3 - v/4), b, 255)
    fontSize(size)
    font("AmericanTypewriter")
    text(txt .. ", " .. name .. "!", x, y - 300)
end
