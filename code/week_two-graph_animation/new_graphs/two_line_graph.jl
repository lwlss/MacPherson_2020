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

simres = logisticmap(x0=0.2,r=4,n=100)

simres2 = logisticmap(x0=0.3,r=4,n=100)

xvals = [x for (x, y) in simres]
yvals = [y for (x, y) in simres]

xvals2 = [x for (x, y) in simres2]
yvals2 = [y for (x, y) in simres2]


trace = scatter(;x=xvals, y=yvals, mode="lines", name = "x0=0.2")

trace2 = scatter(;x=xvals2, y=yvals2, mode="lines", name = "x0=0.3")

plot([ trace, trace2])
