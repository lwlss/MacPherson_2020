#using Pkg
#Pkg.add("Luxor")
#Pkg.add("Colors")

using Luxor, Colors
Drawing(1000,1000,"turtletwo.png")
origin()
background("midnightblue")

turtle = Turtle()
Pencolor(turtle, "red")
Penwidth(turtle, 4)
n = 5
for i in 1:4000
    global n
    Forward(turtle, n)
    Turn(turtle, 75)
    HueShift(turtle)
    n += 0.85
end
fontsize(20)
#Message(turtle, "finished")
finish()


Drawing(1000,1000,"turtlethree.png")
origin()
background("orange")

turtle = Turtle()
Pencolor(turtle, "blue")
Penwidth(turtle, 0.5)
n = 5
for i in 1:8000
    global n
    Forward(turtle, n)
    Turn(turtle, 95)
    HueShift(turtle)
    n += 0.85
end
fontsize(20)
#Message(turtle, "finished")
finish()

function draw(w,t)
 Drawing(1000,1000,"turtlethree.png")
 origin()
 background("midnightblue")
 turtle = Turtle()
 Pencolor(turtle, "blue")
 Penwidth(turtle, w)
 n=5
 for i in 1:8000
  Forward(turtle, n)
  Turn(turtle, t)
  HueShift(turtle)
  n += 0.85
 end
 fontsize(20)
 #Message(turtle, "finished")
 finish()
end

# Need to use the function now it's defined
draw(2,33.333)

Drawing(1000,1000,"turtletest.png")
origin()
background("midnightblue")

turtle = Turtle()
Pencolor(turtle, "red")
Penwidth(turtle, 4)
n = 5
for i in 1:50
    global n
    Forward(turtle, n)
    HueShift(turtle)
    n += 5
end
fontsize(20)
#Message(turtle, "finished")
finish()
