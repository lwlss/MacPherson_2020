using Luxor, Colors

function logistic(r,x)
    r*x*(1.0-x)
end

function logisticmap(;x0=0.2,r=4,n=10)
    results = [(x0,logistic(r,x0))];
    #N = 100; Note this line should not be here
    for i in 1:(n-1) # Note change of case N -> n.  Why?
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xold)])
      append!(results,[(xold,xnew)])
  end
  results
end

simres = logisticmap(x0=0.2,r=4,n=100)

xvals = []
yvals = []

for (x, y) in simres
    append!(xvals, x)
    append!(yvals, y)
end


function cross(turtle)
    Forward(turtle, 5)
    Turn(turtle, 180)
    Forward(turtle, 10)
    Turn(turtle, 180)
    Forward(turtle, 5)
    Turn(turtle, 90)
    Forward(turtle, 5)
    Turn(turtle, 180)
    Forward(turtle, 10)
end


Drawing(1000,1000,"turtlegraph.png")
origin()
background("white")

turtle = Turtle()
Pencolor(turtle, "black")
Penwidth(turtle, 1.5)
for (x, y) in simres
    Reposition(turtle, x, y)
    Pendown(turtle)
    cross(turtle)
end
finish()
