using DifferentialEquations
using Plots; gr()

function f(du,u,p,t)
    du[1] = (p[1]*u[1]) - (p[2]*u[1]*u[2])
    du[2] = (p[2]*u[1]*u[2]) - (p[3]*u[2])
end
u0 = [10.0;4.0]
p = [2.0;0.5;0.6]
tspan = (0.0, 100.0)
prob = ODEProblem(f,u0,tspan,p)

sol = solve(prob,reltol=1e-7,abstol=1e-7)

plot(sol)

plot(sol,linewidth=5,title="Lotka-Volterra System/Predator Prey Dynamics",
     xaxis="Time (years)",yaxis="Population size",label=["Prey" "Predator"], legend =:topright)

u1 = [u[1] for u in sol.u];
u2 = [u[2] for u in sol.u]

function f(du,u,p,t)
    du[1] = (p[1]*u[1]) - (p[2]*u[1]*u[2])
    du[2] = (p[2]*u[1]*u[2]) - (p[3]*u[2])
end
u0 = [10.0;5.0]
p = [1.0;0.1;0.1]
tspan = (0.0, 100.0)
prob = ODEProblem(f,u0,tspan,p)

sol = solve(prob,reltol=1e-7,abstol=1e-7)

plots = plot(sol, linewidth=2, title="Predator Prey Dynamics",
     xaxis="Time (years)",yaxis="Population size",label=["Prey" "Predator"], legend =:bottomright)

[plots[1] plots[2] plot(sol)]


using PlotlyJS
using Distributions

labs = ["Prey", "Predator"];
function f(du,u,p,t)
    du[1] = (p[1]*u[1]) - (p[2]*u[1]*u[2])
    du[2] = (p[2]*u[1]*u[2]) - (p[3]*u[2])
end
u0 = [10.0;4.0]
p = [5.0;0.1;1.0]
tspan = (0.0, 100.0)
prob = ODEProblem(f,u0,tspan,p)

layout = Layout(
title = "Predator Prey Dynamics",
xaxis_title="time (months)",
yaxis_title="Populations Size",
font_family = "Arial",
font_size = 14
)

layout["title"]=""
plots = [plot(prob[i],layout) for i in 1:length(labs)];
[plots[1] plots[2] plot()]


# plot(prob, layout)
