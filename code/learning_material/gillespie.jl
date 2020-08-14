 #mtdna_model = @reaction_network mtdna begin
 # b, wildtype --> 2wildtype
 # d, wildtype  --> null
 # bmut, mut --> 2mut
 # dmut, mut --> null
 # m, wildtype --> wildtype + mut
 # # can we have wildtype --> 2mut
#end b d bmut dmut m

using Random
using Plots
using Colors

function update(t, vals)
  wt = vals[1];
  mut = vals[2];
  haz = [ifelse(sum(vals)<target,b*wt,0.0), d*wt, ifelse(sum(vals)<target,bmut*mut,0.0), dmut*mut, m*wt];
  hazfrac = cumsum(haz/sum(haz));
  index = minimum(findall(hazfrac .- Random.rand() .> 0));
  tnew = t + (1.0/sum(haz))*(Random.randexp());
  valsnew = [wt + delta_wt[index], mut + delta_mut[index]]
  return((tnew,valsnew));
end

b = 0.001875*365
d = 0.001875*365*0.9 # Note, slightly lower than b, so that when total is low, population grows
bmut = 0.001875*365
dmut = 0.001875*365*0.9 # Note, slightly lower than b, so that when total is low, population grows
m = (5e-6)*365
target = 100.0

vals0 = [100, 0]
tmax = 100.0

delta_wt = [1,-1,0,0,0];
delta_mut = [0,0,1,-1,1];

simres = [vals0]
times = [0.0]

while (times[end] < tmax) & (sum(simres[end]) > 0)
 global simres, times
 (tnew, valsnew) = update(times[end],simres[end])
 push!(simres,valsnew)
 push!(times,tnew)
end

sol = (t = times, u = simres)

plot(sol.t, [sol.u[i][1] for i in 1:length(sol.t)], labels="Wildtype", color= "blue")
plot!(sol.t, [sol.u[i][2] for i in 1:length(sol.t)], labels="Mutant", color="red")
plot!(sol.t, [sol.u[i][1]+sol.u[i][2] for i in 1:length(sol.t)], labels="Total", color="black")
