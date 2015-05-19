def setup():
    size(1024, 768)
    background(89, 91, 92)
    frameRate(10)

a = 100
b = 50
theta = 0
angle = 0
z = 100

def draw():
    triangleVersion()
        
def triangleVersion():
    global angle, z
    stroke(233, 240, 170)
    strokeWeight(0.1)
    noFill()
    translate(width/2, height/2)
    scale(4, -4)
    rotate(angle)
    triangle(-z, 0, z, 0, 1/2*z, z)
    z = sqrt(3)*z/2
    angle = angle + atan(1/sqrt(3))
   
def rectangleVersion():
    frameRate(5)
    global theta, a, b
    stroke(233, 240, 170)
    fill(233, 240, 170, 3)
    translate(width/2, height/2)
    scale(1, -1)
    rotate(theta)
    strokeWeight(4)
    point(a, 0)
    point(0, b)
    strokeWeight(1)
    rect(0, 0, a, b)
    a = sqrt(a**2 + b**2)
    theta = theta + atan(b/a)
    s = (b**2)/a
    b = sqrt(b**2 - s**2)
