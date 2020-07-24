using DifferentialEquations
using Plots; gr()

f(u,p,t) = p[1]*u
u0 = 0.5
#params = [3.0]
p = [3.0]
tspan = (0.0,1.0)
prob = ODEProblem(f,u0,tspan,params)

sol = solve(prob,reltol=1e-7,abstol=1e-7)

plot(sol)

plot(sol,linewidth=5,title="Solution to the linear ODE with a thick line",
     xaxis="Time (d)",yaxis="Population size",label="Numerical solution")

plot!(sol.t,t->u0*exp(p[1]t),lw=3,ls=:dash,label="True Solution")

############################################################################

f(u,p,t) = p[1]*u*(1-(u/p[2]))
#f(u,p,t) = p[1]*u*(1-u)
u0 = 0.1
#params = [5.0,1.0]
p = [5.0,1.0]
tspan = (0.0, 10.0)
#prob2 = ODEProblem(f, u0, tspan, params)
prob2 = ODEProblem(f, u0, tspan, p)
sol2 = solve(prob2,reltol=1e-8,abstol=1e-8)

plot(sol2)

plot(sol2,linewidth=5,title="Logistic ODE Graph",
     xaxis="Time (s)",yaxis="Population size",label="Numerical Solution", legend=:bottomright)

plot!(sol2.t,t->((p[2])*(u0*exp(p[1]t)))/(p[2]+(u0*(exp(p[1]t)-1))),lw=3,ls=:dash,label="True Solution")