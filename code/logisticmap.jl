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

function logisticmap(x0,r)
    results = [(x0,logistic(r,x0))];
    # We've already seen arrays: [1,2,3,4]
    # Here I'm using tuples: (1,2,3,4)
    # Results is an array filled with tuples!
    N = 100; # or any big number
    for i in 1:(N-1)
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xnew)])
      print(results)
  end
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
    xaxis_title="Iterations (n)"
    yaxis_title="Value of x (xn+1)"
    font_family = "Arial",
    font_size = 12
)

plot(randomwalks,layout)
