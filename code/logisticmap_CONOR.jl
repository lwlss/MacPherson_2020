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

xvals = # What goes in here?
yvals = # What goes in here?

using PlotlyJS
trace = scatter(;x=xvals, y=yvals, mode="markers")
plot(trace)

# How could you convert xvals and yvals into a list of instructions for a turtle?
# You would need to move turtle to starting position (xvals[1],yvals[1])
# Then get turtle to start drawing (pen down) and move to next position (xvals[2],yvals[2])
# Then continue until the end of xvals and yvals

xvals = []
yvals = []

for (x, y) in simres
    append!(xvals, x)
    append!(yvals, y)
end

xvals
yvals
