using DiffEqBiological
using DifferentialEquations
using Plots

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
plot(osol)

# https://nextjournal.com/sosiris-de/diffeqbiological
# What is the final value of cell(t)?  How does it relate to K?
# Can you overlay the analytical solution?

prob = DiscreteProblem(u0, tspan ,p)
jump_prob = JumpProblem(prob,Direct(),logistic_model)
sol = solve(jump_prob,FunctionMap())
plot(sol)

# Can you plot the stochastic solution (sol) on top of the deterministic solution (osol)?
# Can you see how step-like the results are?
# What happens if you increase nutrient0 to 2000.0?
# Do the stochastic results still look very different to the deterministic ones?
# If you run line 27 above several times, saving the results in a list comprehension,
# then drawing them all on the same plot, will they be the same?

# Can you simulate from the discrete stochastic exponential model?
# Can you simulate from the discrete stochastic Lotka-Volterra model?
# Can you simulate from the discrete stochastic birth-death model?
# What is the difference between the birth-death model and the exponential model?
