# Interactive plot arrays: random walks as examples

using PlotlyJS
using Distributions

# Simulate some random walks
labs = ["J","U","L","I","A"];
N = 10000;
x = 1:N;
y = cumsum(rand(Normal(0,1), N, length(labs)),dims=1);
randomwalks = [scatter(;x=x,y=y[:,i],mode="lines",name=labs[i]) for i in 1:length(labs)];

layout = Layout(
  title = "Intracellular population dynamics",
  xaxis_title="time (d)",
  yaxis_title="Change in # molecules",
  font_family = "Arial",
  font_size = 14
)

# Plot all walks together
plot(randomwalks,layout)

# Plot walks in an array
layout["title"]=""
plots = [plot(randomwalks[i],layout) for i in 1:length(labs)];
[plots[1] plots[2]]
[plots[1] plots[2]  plots[3]
plots[4] plots[5] plot()]



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

layout = Layout(
    title = "Logistical Map",
    xaxis_title="Iterations (n)",
    yaxis_title="Value of x (xn+1)",
    font_family = "Arial",
    font_size = 12
)

plot(randomwalks,layout)
