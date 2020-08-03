using DifferentialEquations
using Plots; gr()
using Formatting

function popsize(n0,r,t)
    n0*exp(r*t)
end

function graph(dname;u0vals=[],rvals=[],tmax=10,deltat=0.1)
    if !isdir(dname)
     mkdir(dname)
end
fno = 1
tspan = 0.0:deltat:tmax
for u in u0vals
    for r in rvals
        psize = [popsize(u,r,t) for t in tspan]
            fname = format(dname*"/frame{:05d}.png",fno)
            fno = fno + 1
            plot(tspan,psize, linewidth=5,title="Exponential Growth",
                 xaxis="Time",yaxis="Population size",legend=false)
            savefig(fname)
        end
    end
end
    

graph("test";u0vals=[0:0.01:1], rvals=[1.1], tmax=10.0, deltat=0.1)
