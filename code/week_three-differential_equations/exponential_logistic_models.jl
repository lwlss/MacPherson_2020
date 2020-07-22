using DifferentialEquations

f(u,p,t) = 1.01*u
u0 = 1/2
tspan = (0.0,1.0)
prob = ODEProblem(f,u0,tspan)

sol = solve(prob)

using Plots; gr()
plot(sol)

plot(sol,linewidth=5,title="Solution to the linear ODE with a thick line",
     xaxis="Time (t)",yaxis="u(t) (in μm)",label="Thick Line")

plot!(sol.t,t->0.5*exp(1.01t),lw=3,ls=:dash,label="True Solution")

############################################################################

f(u,p,t) = 1.5*u*(1-(u/p))
u0 = 1
p = 3
tspan = (0.0, 1.0)
prob2 = ODEProblem(f, u0, p, tspan)

sol2 = solve(prob2)

using Plots; gr()
plot(sol)
