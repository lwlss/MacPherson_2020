using Plots
using DifferentialEquations

labs = ["Prey", "Predator"];
function f(du,u,p,t)
    du[1] = (p[1]*u[1]) - (p[2]*u[1]*u[2])
    du[2] = (p[2]*u[1]*u[2]) - (p[3]*u[2])
end
u0 = [10.0;4.0]
p = [0.1;0.01;0.01]
tspan = (0.0, 1000.0)
prob = ODEProblem(f,u0,tspan,p)

# You need to solve the problem.  i.e. you need to run the simulation:
res = solve(prob, reltol=1e-14,abstol=1e-14)

# Then you need to get the simulated values in a nice format for plotting
t = res.t
prey = [values[1] for values in res.u]
pred = [values[2] for values in res.u]

# Plot the dynamics as usual
p1 = plot(t,prey, label="Prey")
plot!(t,pred, title="Predator Prey Dynamics", yaxis="Population Size", xaxis="Time (Years)", label="Predator",legend=:topright)

# Plot the phase-space diagram
p2 = plot(pred,prey, title="Phase Space Diagram", yaxis="Prey Population", xaxis="Predator Population", legend=false)

# Combine the two plots side by side
plot(p1,p2,layout=(1,2),linewidth=3 )
