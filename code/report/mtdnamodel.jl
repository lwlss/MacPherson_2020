using Random
using Colors
using Plots
theme(:ggplot2)

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

# The below code is used to plot multiple iterations of the model on each graph.

nsims=150
transparency = 0.6
thick = 0.25
solutions =[sim_gillespie(;b = 0.001875*365,d = 0.001875*365*0.86,bmut = 0.001875*365*1.1,dmut = 0.001875*365*0.86,m = (5e-7)*365, target = 100.0,vals0 = [30, 70],tmax = 100.0) for i in 1:nsims]
panelA = plot(solutions[1].t,[solutions[1].u[i][1]+solutions[1].u[i][2] for i in 1:length(solutions[1].t)], labels="mtDNA copy number", color=RGBA(0,0,0,transparency), lw=thick, title_location=:left)
for j in 2:nsims
    plot!(solutions[j].t,[solutions[j].u[i][1]+solutions[j].u[i][2] for i in 1:length(solutions[j].t)], labels="", color=RGBA(0,0,0,transparency), lw=thick, legend=:bottomleft, xaxis="Time (Years)", yaxis="Population Size", title="High initial pathogenic variant load where b<bmut")
end
panelB = plot(solutions[1].t,[solutions[1].u[i][2]/(solutions[1].u[i][1]+solutions[1].u[i][2]) for i in 1:length(solutions[1].t)], labels="Pathogenic variant load", color=RGBA(1,0,0,transparency), lw=thick)
for j in 2:nsims
    plot!(solutions[j].t,[solutions[j].u[i][2]/(solutions[j].u[i][1]+solutions[j].u[i][2]) for i in 1:length(solutions[j].t)], labels="", color=RGBA(1,0,0,transparency), lw=thick, legend=:bottomright, xaxis="Time (Years)", yaxis="Pathogenic variant over mtDNA copy number")
end

plot(panelA,panelB,layout=(1,2))

# The below code is used to plot only a single iteration of the model on each graph.

nsims=1
transparency = 1.0
thick = 0.8
solutions =[sim_gillespie(;b = 0.001875*365,d = 0.001875*365*0.86,bmut = 0.001875*365*1.1,dmut = 0.001875*365*0.86,m = (5e-7)*365, target = 100.0,vals0 = [30, 70],tmax = 100.0) for i in 1:nsims]
panelA = plot(solutions[1].t,[solutions[1].u[i][1]+solutions[1].u[i][2] for i in 1:length(solutions[1].t)], labels="mtDNA copy number", color=RGBA(0,0,0,transparency), lw=thick, legend=:bottomleft,  xaxis="Time (Years)", yaxis="Population Size", title="High initial pathogenic variant load where b<bmut", title_location=:left)
panelB = plot(solutions[1].t,[solutions[1].u[i][2]/(solutions[1].u[i][1]+solutions[1].u[i][2]) for i in 1:length(solutions[1].t)], labels="Pathogenic variant load", color=RGBA(1,0,0,transparency), lw=thick, legend=:bottomright, xaxis="Time (Years)", yaxis="Pathogenic variant over mtDNA copy number")

plot(panelA,panelB,layout=(1,2))
