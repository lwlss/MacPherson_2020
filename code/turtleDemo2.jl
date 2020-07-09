using Luxor, Colors
Drawing(6000,4000,"turtletwo.png")
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


using Pkg
Pkg.add("Luxor")
Pkg.add("Color")
