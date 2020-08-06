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
plot(osol.t, [osol.u[i][1] for i in 1:length(osol.t)], labels="cells", color= "blue")
plot!(osol.t, [osol.u[i][2] for i in 1:length(osol.t)], labels="nutrients", color="red")


# https://nextjournal.com/sosiris-de/diffeqbiological
# What is the final value of cell(t)?  How does it relate to K?
# Can you overlay the analytical solution?

prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),logistic_model)
sol = solve(jump_prob,FunctionMap())
plot(sol)

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
solutions =[solve(jump_prob,FunctionMap()) for i in 1:nsins]
plot(solutions[1].t, [solutions[1].u[i][1] for i in 1:length(solutions[1].t)], labels="Cells", color= "blue", xaxis="Time", yaxis="Population Size", title="Discrete Stochastic Populations Dynamics", lw=0.1)
plot!(solutions[1].t,[solutions[1].u[i][2] for i in 1:length(solutions[1].t)], labels="Nutrients", color="red")
for j in 2:nsins
    p=plot!(solutions[j].t, [solutions[j].u[i][1] for i in 1:length(solutions[j].t)], labels="", color= "blue")
    q=plot!(solutions[j].t,[solutions[j].u[i][2] for i in 1:length(solutions[j].t)], labels="", color="red")
    display(p)
    display(q)
end

# Can you simulate from the discrete stochastic exponential model?


exponential_model = @reaction_network logistic begin
  r, cell  --> 2cell
end r

r = 1.5
cell0 = 1.0

tspan = (0.0,1.0)
p =  (r)
u0 = [cell0]

oprob = ODEProblem(logistic_model, u0, tspan, p)
osole = solve(oprob)
plot(osole)

prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),exponential_model)
sole = solve(jump_prob,FunctionMap())
#plot(sole)
plot!(sole)

# Can you simulate from the discrete stochastic Lotka-Volterra model?

lv_model = @reaction_network lv begin
  k1, prey --> 2prey
  k2, prey + predator --> 2predator
  k3, predator --> null
  k4, prey --> null
end k1 k2 k3 k4

k1 = 1.0
k2 = 0.1
k3 = 0.1
k4 = 0.001

prey0 = 4.0
predator0 = 10.0
null0 = 0.0
tspan = (0.0,100.0)
p =  (k1,k2,k3,k4)
u0 = [prey0, predator0, null0]

oproblv = ODEProblem(lv_model, u0, tspan, p)
osollv = solve(oproblv)
plot(osollv)

prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),lv_model)
sollv = solve(jump_prob,FunctionMap())
#plot(sole)
plot(sollv)

# Can you simulate from the discrete stochastic birth-death model?


bd_model = @reaction_network bd begin
  lambda, cell  --> 2cell
  mu, cell  --> null
end lambda, mu

lambda = 2.0
mu= 0.5
cell0 = 1.0
null0 = 0.0

tspan = (0.0,1.0)
p =  (lambda, mu)
u0 = [cell0, null0]

oprobbd = ODEProblem(logistic_model, u0, tspan, p)
osole = solve(oprob)
plot(osole)

probbd = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(probbd,Direct(),bd_model)
solbd = solve(jump_prob,FunctionMap())
#plot(sole)
plot!(solbd)

# What is the difference between the birth-death model and the exponential model?
