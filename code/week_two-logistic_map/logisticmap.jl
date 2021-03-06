function logistic(r,x)
    r*x*(1.0-x)
end


x0 = 0.2
r = 3.7
results = [(x0,logistic(r,x0))];
# We've already seen arrays: [1,2,3,4]
# Here I'm using tuples: (1,2,3,4)
# Results is an array filled with tuples!
N = 100; # or any big number
for i in 1:(N-1)
  xold = results[end][2]
  xnew = logistic(r,xold)
  append!(results,[(xold,xnew)])
end

print(results)

function logisticmap(x0=0.2,r=4,n=10)
    results = [(x0,logistic(r,x0))];
    N = 100;
    for i in 1:(N-1)
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xnew)])
      print(results)
  end
  results
end




using PlotlyJS
using Distributions

labs=["1","2","3","4","5"]
N=100;
x=1:N;
y = for i in 1:(N-1)
  xold = results[end][2]
  xnew = logistic(r,xold)
  append!(results,[(xold,xnew)])
end

layout = layout(
    title = "Logistical Map"
    xaxis_title="Xn"
    yaxis_title="Xn+1"
    font_family = "Arial",
    font_size = 12
)

plot()



labs=["1"]
function logisticmap(x0,r=4,n=10)
    results = [(x0,logistic(r,x0))];
    N = 100;
    for i in 1:(N-1)
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xnew)])
      print(results)
  end
  results
end
x = xold
y = xnew

layout = layout(
    title = "Logistical Map"
    xaxis_title="Xn"
    yaxis_title="Xn+1"
    font_family ="Arial",
    font_size = 12
)

plot()


function logisticmaping()
    trace1 = scatter(;x=xold, y=xnew, mode="lines+markers")
    plot([trace1])
end

function logisticmaping()
    function logisticmap(x0=0.2,r=4,n=10)
        results = [(x0,logistic(r,x0))];
        N = 100;
        for i in 1:(N-1)
          xold = results[end][2]
          xnew = logistic(r,xold)
          append!(results,[(xold,xnew)])
          print(results)
      end
      results
    end
    trace1 = scatter(;x=xold, y=xnew, mode="lines+markers")
    plot([trace1])
end
