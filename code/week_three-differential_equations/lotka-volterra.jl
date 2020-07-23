using DifferentialEquations
using Plots; gr()

function f(du,u,p,t)
    du[1] = (p[1]*u[1]) - (p[2]*u[1]*u[2])
    du[2] = (p[2]*u[1]*u[2]) - (p[3]*u[2])
end
u0 = [10.0;4.0]
p = [5.0;0.1;1.0]
tspan = (0.0, 100.0)
prob = ODEProblem(f,u0,tspan,p)

sol = solve(prob,reltol=1e-7,abstol=1e-7)

plot(sol)

plot(sol,linewidth=5,title="Lotka-Volterra System/Predator Prey Dynamics",
     xaxis="Time (years)",yaxis="Population size",label=["Prey" "Predator"], legend =:bottomright)

u1 = [u[1] for u in sol.u];    
u2 = [u[2] for u in sol.u]
