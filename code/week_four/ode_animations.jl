using DifferentialEquations
using Plots; gr()
using Formatting

function graph(dname;u=[],p=[],t=[])
    du[1] = p[p]*u
    if !isdir(dname)
     mkdir(dname)
end
fno = 1
tspan = (0.0,t)
for u in u
    for p in p
        for t in tspan
            fname = format(dname*"/frame{:05d}.png",fno)
            fno = fno + 1
            sol = solve(du[1],reltol=1e-7,abstol=1e-7)
            plot(sol,linewidth=5,title="Exponential Growth",
                 xaxis="Time",yaxis="Population size",label="Numerical solution")
             end
         end
     end
 end
