using DiffEqBiological
using DifferentialEquations
using Plots
using Colors

logistic_model = @reaction_network logistic begin
  r, cell + nutrient --> 2cell
end r

r = 1.5
cell0 = 1.0
nutrient0 = 2000.0

tspan = (0.0,0.008)
p =  (r)
u0 = [cell0, nutrient0]

oprob = ODEProblem(logistic_model, u0, tspan, p)
osol = solve(oprob, reltol=1e-8,abstol=1e-8)
Kbio = nutrient0+cell0
n = [((Kbio)*(cell0*exp(r*t)))/((Kbio)+(cell0*(exp(r*t)-1))) for t in osol.t]
#plot(osol)
plot(osol.t, [osol.u[i][1] for i in 1:length(osol.t)], labels="Cells", color= "blue", lw=2.0)
plot!(osol.t, [osol.u[i][2] for i in 1:length(osol.t)], labels="Nutrients", color="red", lw=2.0)


# https://nextjournal.com/sosiris-de/diffeqbiological
# What is the final value of cell(t)?  How does it relate to K?
# Can you overlay the analytical solution?

prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),logistic_model)
sol = solve(jump_prob,FunctionMap())
#plot(sol)
plot(sol.t, [sol.u[i][1] for i in 1:length(sol.t)], labels="", color="blue", lw=2)
plot!(sol.t, [sol.u[i][2] for i in 1:length(sol.t)], labels="", color="red", lw=2)
# Can you plot the stochastic solution (sol) on top of the deterministic solution (osol)?

plot(osol)
plot!(sol)

#or

p1=plot(osol)
p2=plot(sol)

plot(p1,p2, xaxis="Time", yaxis="Population Size")

# Can you see how step-like the results are?
# What happens if you increase nutrient0 to 2000.0?
# Do the stochastic results still look very different to the deterministic ones?
# If you run line 27 above several times, saving the results in a list comprehension,
# then drawing them all on the same plot, will they be the same?

nsins=100
prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),logistic_model)
solutions =[solve(jump_prob,FunctionMap()) for i in 1:nsins]
plot(solutions[1].t, [solutions[1].u[i][1] for i in 1:length(solutions[1].t)], labels="Cells", color= "blue", xaxis="Time", yaxis="Population Size", title="Discrete Stochastic Populations Dynamics", lw=0.3)
plot!(solutions[1].t,[solutions[1].u[i][2] for i in 1:length(solutions[1].t)], labels="Nutrients", color="red", lw=0.3)
for j in 2:nsins
    p=plot!(solutions[j].t, [solutions[j].u[i][1] for i in 1:length(solutions[j].t)], labels="", color= "blue", lw=0.3)
    q=plot!(solutions[j].t,[solutions[j].u[i][2] for i in 1:length(solutions[j].t)], labels="", color="red", lw=0.3)
    display(p)
    display(q)
end
oprob = ODEProblem(logistic_model, u0, tspan, p)
osol = solve(oprob, reltol=1e-8,abstol=1e-8)
Kbio = nutrient0+cell0
n = [((Kbio)*(cell0*exp(r*t)))/((Kbio)+(cell0*(exp(r*t)-1))) for t in osol.t]
plot!(osol.t, [osol.u[i][1] for i in 1:length(osol.t)], labels="Deterministic Continuous Solution", color="black", lw=2)
plot!(osol.t, [osol.u[i][2] for i in 1:length(osol.t)], labels="", color="black", legend=:right, lw=2)

# Can you simulate from the discrete stochastic exponential model?

############################################################################################################

using DiffEqBiological
using DifferentialEquations
using Plots
using Colors

exponential_model = @reaction_network exponential begin
  r, cell  --> 2cell
end r

r = 5.0
cell0 = 10.0

tspan = (0.0,1.0)
p = (r)
u0 = [cell0]

oprobe = ODEProblem(exponential_model, u0, tspan, p)
osole = solve(oprobe)
plot(osole, labels="Deterministic Solution", lw=2)

probe = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probe,Direct(),exponential_model)
sole = solve(jump_prob,FunctionMap())
#plot(sole)
plot!(sole, title="Deterministic and Stochastic Exponential Model", xaxis="Time", yaxis="Popuplation Size", legend=:left, lw=2, labels="Stochastic Solution")

nsims=100
probe = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probe,Direct(),exponential_model)
solutions =[solve(jump_prob,FunctionMap()) for i in 1:nsims]
plot(solutions[1].t, [solutions[1].u[i][1] for i in 1:length(solutions[1].t)], labels="Cells", color="blue", lw=0.2)
for j in 2:nsims
    p=plot!(solutions[j].t, [solutions[j].u[i][1] for i in 1:length(solutions[j].t)], labels="", color="blue", legend=:left, title="Exponential Model w/ Stochastic and Deterministic Solutions", lw=0.2)
    display(p)
end
oprobe = ODEProblem(exponential_model, u0, tspan, p)
osole = solve(oprobe)
plot!(osole, labels="Deterministic Solution", xaxis="Time", yaxis="Population Size",color="black", lw=2)

######################################################################################################################



# Can you simulate from the discrete stochastic Lotka-Volterra model?

lv_model = @reaction_network lv begin
  k1, prey --> 2prey
  k2, prey + predator --> 2predator
  k3, predator --> null
 # k4, prey --> null
end k1 k2 k3 #k4

k1 = 1.0
k2 = 0.1
k3 = 0.1
#k4 = 0.001

prey0 = 40.0
predator0 = 100.0
null0 = 0.0
tspan = (0.0,200.0)
p =  (k1,k2,k3)
u0 = [prey0, predator0]

oproblv = ODEProblem(lv_model, u0, tspan, p)
osollv = solve(oproblv, reltol=1e-5,abstol=1e-5)
#plot(osollv)
plot(osollv.t, [osollv.u[i][1] for i in 1:length(osollv.t)], labels="D-Prey", color= "blue", lw=2)
plot!(osollv.t, [osollv.u[i][2] for i in 1:length(osollv.t)], labels="D-Predators", color="orange", lw=2)

prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),lv_model)
sollv = solve(jump_prob,FunctionMap())
#plot(sollv)
plot!(sollv.t, [sollv.u[i][1] for i in 1:length(sollv.t)], labels="S-Prey", color= "green", lw=2.0)
plot!(sollv.t, [sollv.u[i][2] for i in 1:length(sollv.t)], labels="S-Predators", color="red", lw=2.0, title="Lotka-Volterra Deterministic and Stochastic Models", xaxis="Time", yaxis="Population Size")

# at larger pops the stochastic solution looks very similar to the deterministic solution but it doesnt have the advantage of being continuous

# Can you simulate from the discrete stochastic birth-death model?

############################################################################################################################

bd_model = @reaction_network bd begin
  lambda, cell  --> 2cell
  mu, cell  --> null
end lambda mu

lambda = 2.0
#lambda = 0.8
mu= 1.5
#mu= 0.5
cell0 = 100.0
null0 = 0.0

tspan = (0.0,5.0)
p =  (lambda, mu)
u0 = [cell0, null0]

oprobbd = ODEProblem(bd_model, u0, tspan, p)
osolbd = solve(oprobbd, reltol=1e-8,abstol=1e-8)
#plot(osolbd)
plot(osolbd.t, [osolbd.u[i][1] for i in 1:length(osolbd.t)], labels="", color= "blue", ls=:dash)
plot!(osolbd.t, [osolbd.u[i][2] for i in 1:length(osolbd.t)], labels="", color="red", ls=:dash)


probbd = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probbd,Direct(),bd_model)
solbd = solve(jump_prob,FunctionMap())
#plot(solbd)
plot!(solbd.t, [solbd.u[i][1] for i in 1:length(solbd.t)], labels="Cells", color= "blue")
plot!(solbd.t, [solbd.u[i][2] for i in 1:length(solbd.t)], labels="Dead Cells", color="red", legend=:left, title="Birth-Death Model w/ Deterministic and Stochastic Solutions", xaxis="Time", yaxis="Popuplation Size")


nsins=100
probbd = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probbd,Direct(),bd_model)
solutions =[solve(jump_prob,FunctionMap()) for i in 1:nsins]
plot(solutions[1].t, [solutions[1].u[i][1] for i in 1:length(solutions[1].t)], labels="Cells", color= "blue", xaxis="Time", yaxis="Population Size", title="Discrete Stochastic Populations Dynamics", lw=0.3)
for j in 2:nsins
    p=plot!(solutions[j].t, [solutions[j].u[i][1] for i in 1:length(solutions[j].t)], labels="", color= "blue", lw=0.2)
    q=plot!(solutions[j].t,[solutions[j].u[i][2] for i in 1:length(solutions[j].t)], labels="", color="red", lw=0.2)
    display(p)
    display(q)
end
oprobbd = ODEProblem(bd_model, u0, tspan, p)
osolbd = solve(oprobbd, reltol=1e-10,abstol=1e-10)
plot!(osolbd.t, [osolbd.u[i][1] for i in 1:length(osolbd.t)], labels="Deterministic Solution", color="black", lw=3)
plot!(osolbd.t, [osolbd.u[i][2] for i in 1:length(osolbd.t)], labels="", color="black", legend=:left, lw=3, title="Birth-Death Model Showing Stochastic Behavior")






nsins=10
probmtdna = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probmtdna,Direct(),mtdna_model)
solutions =[solve(jump_prob,FunctionMap()) for i in 1:nsins]
plot(solutions[1].t, [solutions[1].u[i][1] for i in 1:length(solutions[1].t)], labels="Wildtype", color= "blue", xaxis="Time", yaxis="Population Size", title="mtDNA Populations Dynamics", lw=0.3)
plot!(solutions[1].t,[solutions[1].u[i][2] for i in 1:length(solutions[2].t)], labels="Mutant", color="red", lw=0.3)
for j in 2:nsins
    p=plot!(solutions[j].t, [solutions[j].u[i][1] for i in 1:length(solutions[j].t)], labels="", color= "blue", lw=0.3)
    q=plot!(solutions[j].t,[solutions[j].u[i][3] for i in 1:length(solutions[j].t)], labels="", color="red", lw=0.3)
    display(p)
    display(q)
end
oprobmtdna = ODEProblem(mtdna_model, u0, tspan, p)
osolmtdna = solve(oprobmtdna)
plot!(osolmtdna.t, [osolmtdna.u[i][1] for i in 1:length(osolmtdna.t)], labels="Deterministic Continuous Solution", color="black", lw=2)
plot!(osolmtdna.t, [osolmtdna.u[i][3] for i in 1:length(osolmtdna.t)], labels="", color="black", legend=:right, lw=2)

################################################################################################################################

# What is the difference between the birth-death model and the exponential model?

using DiffEqBiological
using DifferentialEquations
using Plots
using Colors
#using ParameterizedFunctions

mtdna_model = @reaction_network mtdna begin
  b, wildtype --> 2wildtype
  d, wildtype  --> null
  bmut, mut --> 2mut
  dmut, mut --> null
  m, wildtype --> wildtype + mut
  # can we have wildtype --> 2mut
end b d bmut dmut m

# parameter values

b = 0.001875*365
d = 0.001875*365
bmut = 0.001875*365
dmut = 0.001875*365
m = (1e-5)*365

# initial conditions

wildtype0 = 100.0
mut0 = 0.0
null0 = 0.0
dummy0 = 1.0
tspan= (0.0, 100.0)
p = (b,d,bmut,dmut,m)
u0 = [wildtype0, mut0, null0]

sim_to_tot = function(res, totmax = 105.0)
  u0 = res["species"][end]
  oprobmtdna = ODEProblem(mtdna_model, u0, tspan, p)#, callback=cset)
  osolmtdna = solve(oprobmtdna)
  totmtDNA = [osolmtdna.u[i][1] + osolmtdna.u[i][3] for i in 1:length(osolmtdna.t)];
  triggered = [t>=totmax for t in totmtDNA];
  lastres = findfirst(triggered)-1;
  times = [t for t in osolmtdna.t[1:lastres]]
  species = [u for u in osolmtdna.u[1:lastres]]
  res = Dict("times" => times, "species" => species)
  return(res)
end

res = Dict("times" => [0.0], "species" => [u0])
current_time = 0.0
allres = []
while current_time <= tspan[2]
  resnew = sim_to_tot(res, 105.0)
  current_time = current_time + resnew["times"][end]
  append!(allres,resnew)
end






plot(osolmtdna.t, [osolmtdna.u[i][1] for i in 1:length(osolmtdna.t)], labels="Wildtype", color= "blue")
plot!(osolmtdna.t, [osolmtdna.u[i][3] for i in 1:length(osolmtdna.t)], labels="Mutant", color="red")
plot!(osolmtdna.t, totmtDNA, labels="Total", color="black")

probmtdna = DiscreteProblem(u0, tspan ,p, callback=cset)
jump_prob = JumpProblem(probmtdna,Direct(),mtdna_model)
solmtdna = solve(jump_prob,FunctionMap())
plot(solmtdna.t, [solmtdna.u[i][1] for i in 1:length(solmtdna.t)], labels="Wildtype", color= "blue")
plot!(solmtdna.t, [solmtdna.u[i][3] for i in 1:length(solmtdna.t)], labels="Mutant", color="red")
plot!(solmtdna.t, [solmtdna.u[i][1] + solmtdna.u[i][3] for i in 1:length(solmtdna.t)], labels="Total", color="black")
