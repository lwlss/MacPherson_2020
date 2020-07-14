using PlotlyJS

function logistic(r,x)
    r*x*(1.0-x)
end

function logisticmap(;x0=0.21,r=4,n=10)
    results = [(x0,logistic(r,x0))];
    for i in 1:(n-1)
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xold)])
      append!(results,[(xold,xnew)])
  end
  results
end

simres = logisticmap(x0=0.21,r=4,n=100)

xvals = [x for (x, y) in simres]
yvals = [y for (x, y) in simres]

trace = scatter(;x=xvals, y=yvals, mode="lines")
plot(trace)

#this part is for generating many different images for an animation

for x0 in 0:0.01:1.0
    simres = logisticmap(x0=x0,r=4,n=100)
    xvals = [x for (x, y) in simres]
    yvals = [y for (x, y) in simres]
    trace = scatter(;x=xvals, y=yvals, mode="lines")
    plot(trace)
end

#xvals = []
#yvals = []

#for (x, y) in simres
    #append!(xvals, x)
    #append!(yvals, y)
#end
