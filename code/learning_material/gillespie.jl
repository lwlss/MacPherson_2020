 #mtdna_model = @reaction_network mtdna begin
 # b, wildtype --> 2wildtype
 # d, wildtype  --> null
 # bmut, mut --> 2mut
 # dmut, mut --> null
 # m, wildtype --> wildtype + mut
 # # can we have wildtype --> 2mut
#end b d bmut dmut m

using Random
using Colors
using Plots
theme(:ggplot2)


function update(t, vals)
  wt = vals[1];
  mut = vals[2];
  haz = [ifelse(sum(vals)<target,b*wt,0.0), d*wt, ifelse(sum(vals)<target,bmut*mut,0.0), dmut*mut, m*wt];
  # ^ specifying the reactions. 1st = wt replication,  b, wildtype --> 2wildtype
  # 2nd = wt degredation, d, wildtype  --> null
  # 3rd = mut replication, bmut, mut --> 2mut
  # 4th = mut degredation, dmut, mut --> null
  # 5th = mutaion, m, wildtype --> wildtype + mut
  hazfrac = cumsum(haz/sum(haz));
  index = minimum(findall(hazfrac .- Random.rand() .> 0));
  tnew = t + (1.0/sum(haz))*(Random.randexp());
  valsnew = [wt + delta_wt[index], mut + delta_mut[index]]
  return((tnew,valsnew));
end

b = 0.001875*365
d = 0.001875*365*0.86 # Note, slightly lower than b, so that when total is low, population grows
bmut = 0.001875*365
dmut = 0.001875*365*0.86 # Note, slightly lower than b, so that when total is low, population grows
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

plot(sol.t, [sol.u[i][1] for i in 1:length(sol.t)], labels="Wildtype", color= "blue", lw=1.0)
plot!(sol.t, [sol.u[i][2] for i in 1:length(sol.t)], labels="Mutant", color="red", lw=1.0)
plot!(sol.t, [sol.u[i][1]+sol.u[i][2] for i in 1:length(sol.t)], legend=:left, labels="Total", color="white", lw=0.2, title="Low Initial Mutation Load Where b<bmut", xaxis="Time (Years)", yaxis="Population Size")

plot!(sol.t, [sol.u[i][1] for i in 1:length(sol.t)], labels="", color= "blue",lw=0.4)
plot!(sol.t, [sol.u[i][2] for i in 1:length(sol.t)], labels="", color="red", lw=0.4)
plot!(sol.t, [sol.u[i][1]+sol.u[i][2] for i in 1:length(sol.t)], legend=:left,layout=4, labels="", color="white", lw=0.2)

function sim_gillespie(;b,d,bmut,dmut,m,target,vals0,tmax)
    function update(t, vals)
      wt = vals[1];
      mut = vals[2];
      haz = [ifelse(sum(vals)<target,b*wt,0.0), d*wt, ifelse(sum(vals)<target,bmut*mut,0.0), dmut*mut, m*wt];
      # ^ specifying the reactions. 1st = wt replication,  b, wildtype --> 2wildtype
      # 2nd = wt degredation, d, wildtype  --> null
      # 3rd = mut replication, bmut, mut --> 2mut
      # 4th = mut degredation, dmut, mut --> null
      # 5th = mutaion, m, wildtype --> wildtype + mut
      hazfrac = cumsum(haz/sum(haz));
      index = minimum(findall(hazfrac .- Random.rand() .> 0));
      tnew = t + (1.0/sum(haz))*(Random.randexp());
      valsnew = [wt + delta_wt[index], mut + delta_mut[index]]
      return((tnew,valsnew));
    end
    delta_wt = [1,-1,0,0,0];
    delta_mut = [0,0,1,-1,1];

    simres = [vals0]
    times = [0.0]

    while (times[end] < tmax) & (sum(simres[end]) > 0)
     (tnew, valsnew) = update(times[end],simres[end])
     push!(simres,valsnew)
     push!(times,tnew)
    end
    sol = (t = times, u = simres)
    return(sol)
end

sol = sim_gillespie(;b = 0.001875*365,d = 0.001875*365*0.86,bmut = 0.001875*365,dmut = 0.001875*365*0.86,m = (5e-6)*365, target = 100.0,vals0 = [100, 0],tmax = 100.0)


nsims=150
transparency = 0.4
thick = 0.2
solutions =[sim_gillespie(;b = 0.001875*365,d = 0.001875*365*0.86,bmut = 0.001875*365*1.0,dmut = 0.001875*365*0.86,m = (5e-7)*365, target = 100.0,vals0 = [100, 0],tmax = 100.0) for i in 1:nsims]
panelA = plot(solutions[1].t,[solutions[1].u[i][1]+solutions[1].u[i][2] for i in 1:length(solutions[1].t)], labels="", color=RGBA(0,0,0,transparency), lw=thick)
for j in 2:nsims
    plot!(solutions[j].t,[solutions[j].u[i][1]+solutions[j].u[i][2] for i in 1:length(solutions[j].t)], labels="", color=RGBA(0,0,0,transparency), lw=thick, legend=false, xaxis="Time (Years)", yaxis="mtDNA copy number", title="High initial pathogenic variant load where b=bmut", title_location=:left)
end
panelB = plot(solutions[1].t,[solutions[1].u[i][2]/(solutions[1].u[i][1]+solutions[1].u[i][2]) for i in 1:length(solutions[1].t)], labels="", color=RGBA(1,0,0,transparency), lw=thick)
for j in 2:nsims
    plot!(solutions[j].t,[solutions[j].u[i][2]/(solutions[j].u[i][1]+solutions[j].u[i][2]) for i in 1:length(solutions[j].t)], labels="", color=RGBA(1,0,0,transparency), lw=thick, legend=false, xaxis="Time (Years)", yaxis="Pathogenic variant load")
    #plot!(rand(100), lw=0)
end

plot(panelA,panelB,layout=(1,2), fmt=:pdf)

savefig("D:\\himl.pdf")


nsims=1
transparency = 1.0
thick = 0.7
solutions =[sim_gillespie(;b = 0.001875*365,d = 0.001875*365*0.86,bmut = 0.001875*365*1.1,dmut = 0.001875*365*0.86,m = (5e-7)*365, target = 100.0,vals0 = [100, 0],tmax = 100.0) for i in 1:nsims]
panelC = plot(solutions[1].t,[solutions[1].u[i][1]+solutions[1].u[i][2] for i in 1:length(solutions[1].t)], labels="mtDNA copy number", color=RGBA(0,0,0,transparency), lw=thick, legend=false,  xaxis="Time (Years)", yaxis="Population Size", title="Copy Number of Cell")
panelB = plot(solutions[1].t,[solutions[1].u[i][2] for i in 1:length(solutions[1].t)], color=RGBA(0.5,0,0.5,transparency), lw=thick, legend=false,  xaxis="Time (Years)", yaxis="Population Size", title="Mutant mtDNA")
panelA = plot(solutions[1].t,[solutions[1].u[i][1] for i in 1:length(solutions[1].t)], color=RGBA(0,0,1,transparency), lw=thick, legend=false,  xaxis="Time (Years)", yaxis="Population Size", title="Wild-type mtDNA")
panelD = plot(solutions[1].t,[solutions[1].u[i][2]/(solutions[1].u[i][1]+solutions[1].u[i][2]) for i in 1:length(solutions[1].t)], title="Pathogenic variant load", color=RGBA(1,0,0,transparency), lw=thick, legend=false, xaxis="Time (Years)", yaxis="Fraction Value")

plot(panelA,panelB,panelC,panelD,layout=(2,2), fmt=:pdf)

savefig("D:\\4panel.pdf")


# What happens if a cells is born with no mutations?

# What happens if a cell inherits a lot of mutations?  70%?

# What happens in both of the scenarios above if bmut > b?
