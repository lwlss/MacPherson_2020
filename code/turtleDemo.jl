#using Pkg
#Pkg.add("Luxor")
#Pkg.add("Color")

using Luxor, Colors
Drawing(1000,1000,"turtle.png")
origin()
background("midnightblue")

turtle = Turtle()
Pencolor(turtle, "cyan")
Penwidth(turtle, 1.5)
n = 5
for i in 1:4000
    global n
    Forward(turtle, n)
    Turn(turtle, 89.5)
    HueShift(turtle)
    n += 0.75
end
fontsize(20)
#Message(turtle, "finished")
finish()
