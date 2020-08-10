using DiffEqBiological
using DifferentialEquations
using Plots
using Colors

logistic_model = @reaction_network logistic begin
  r, cell + nutrient --> 2cell
end r

r = 1.5
cell0 = 1.0
nutrient0 = 20.0

tspan = (0.0,1.0)
p =  (r)
u0 = [cell0, nutrient0]

oprob = ODEProblem(logistic_model, u0, tspan, p)
osol = solve(oprob)
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
osol = solve(oprob)
Kbio = nutrient0+cell0
n = [((Kbio)*(cell0*exp(r*t)))/((Kbio)+(cell0*(exp(r*t)-1))) for t in osol.t]
plot!(osol.t, [osol.u[i][1] for i in 1:length(osol.t)], labels="Deterministic Non-Discrete Solution", color="black", lw=2)
plot!(osol.t, [osol.u[i][2] for i in 1:length(osol.t)], labels="", color="black", legend=:right, lw=2)

# Can you simulate from the discrete stochastic exponential model?


exponential_model = @reaction_network exponential begin
  r, cell  --> 2cell
end r

r = 2.0
cell0 = 1.0

tspan = (0.0,1.0)
p = (r)
u0 = [cell0]

oprobe = ODEProblem(exponential_model, u0, tspan, p)
osole = solve(oprobe)
plot(osole, labels="Deterministic Solution", lw=2)

prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),exponential_model)
sole = solve(jump_prob,FunctionMap())
#plot(sole)
plot!(sole, title="Deterministic and Stochastic Exponential Model", xaxis="Time", yaxis="Popuplation Size", legend=:left, lw=2, labels="Stochastic Solution")

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


bd_model = @reaction_network bd begin
  lambda, cell  --> 2cell
  mu, cell  --> null
end lambda mu

lambda = 0.8
mu= 0.5
cell0 = 5.0
null0 = 0.0

tspan = (0.0,10.0)
p =  (lambda, mu)
u0 = [cell0, null0]

oprobbd = ODEProblem(bd_model, u0, tspan, p)
osolbd = solve(oprobbd, reltol=1e-8,abstol=1e-8)
#plot(osolbd)
plot(osolbd.t, [osolbd.u[i][1] for i in 1:length(osolbd.t)], labels="Cells", color= "blue")
plot!(osolbd.t, [osolbd.u[i][2] for i in 1:length(osolbd.t)], labels="Dead Cells", color="red")


probbd = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probbd,Direct(),bd_model)
solbd = solve(jump_prob,FunctionMap())
#plot(solbd)
plot!(solbd.t, [solbd.u[i][1] for i in 1:length(solbd.t)], labels="Cells", color= "black")
plot!(solbd.t, [solbd.u[i][2] for i in 1:length(solbd.t)], labels="Dead Cells", color="brown")



# What is the difference between the birth-death model and the exponential model?

mtdna_model = @reaction_network mtdna begin
  b*max(wildtype+mut), wildtype  --> 2wildtype
  d, wildtype  --> null
  bmut, mut --> 2mut
  dmut, mut --> null
  m, wildtype --> wildtype + mut
  # can we have wildtype --> 2mut
end b d bmut dmut m

function condition(u,t,integrator)
    u[1]+u[3]
end

function affect!(integrator)
    integrator.p[1]=0
end

change_b=ContinuousCallback(condition,affect!)
# parameter values

b = 0.001875*365
d = 0.001875*365
bmut = 0.001875*365
dmut = 0.001875*365
m = (1.0e-5)*365

# initial conditions

wildtype0 = 100.0
mut0 = 0.0
null0 = 0.0
tspan= (0.0, 100.0)
p = (b,d,bmut,dmut,m)
u0 = [wildtype0, mut0, null0]

oprobmtdna = ODEProblem(mtdna_model, u0, tspan, p, callback=change_b)
osolmtdna = solve(oprobmtdna)
plot(osolmtdna.t, [osolmtdna.u[i][1] for i in 1:length(osolmtdna.t)], labels="Wildtype", color= "blue")
plot!(osolmtdna.t, [osolmtdna.u[i][3] for i in 1:length(osolmtdna.t)], labels="Mutant", color="red")
plot!(osolmtdna.t, [osolmtdna.u[i][1] + osolmtdna.u[i][3] for i in 1:length(osolmtdna.t)], labels="Total", color="black")


probmtdna = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probmtdna,Direct(),mtdna_model)
solmtdna = solve(jump_prob,FunctionMap())
plot(solmtdna.t, [solmtdna.u[i][1] for i in 1:length(solmtdna.t)], labels="Wildtype", color= "blue")
plot!(solmtdna.t, [solmtdna.u[i][3] for i in 1:length(solmtdna.t)], labels="Mutant", color="red")
plot!(solmtdna.t, [solmtdna.u[i][1] + solmtdna.u[i][3] for i in 1:length(solmtdna.t)], labels="Total", color="black")
