using Plots; gr()
using DifferentialEquations

# Lorenz example from documentation
function g(du,u,p,t)
 du[1] = p[1]*(u[2]-u[1])
 du[2] = u[1]*(p[2]-u[3]) - u[2]
 du[3] = u[1]*u[2] - p[3]*u[3]
end
u0 = [1.0;0.0;0.0]
tspan = (0.0,180.0)
p = [10.0,28.0,8/3]
prob = ODEProblem(g,u0,tspan,p)

sollor = solve(prob,reltol=1e-14,abstol=1e-14)

plot(sollor,title="Lorenz System",label=false, xaxis="Time (x)")

# Get the results
u1 = [s[1] for s in sollor.u];
u2 = [s[2] for s in sollor.u];
u3 = [s[3] for s in sollor.u];
t = sollor.t

plot(t,u1, xaxis=false, yaxis=false, legend=false)
plot!(t,u2, xaxis=false, yaxis=false, legend=false)
plot!(t,u3, xaxis=false, yaxis=false, legend=false)
plot(u1,u2, xaxis=false, yaxis=false, legend=false)
plot(u1,u3, xaxis=false, yaxis=false, legend=false)

# Logistic model as system of 2 ODEs
# Cell = u[1]
# Agar = u[2]

function g(du,u,p,t)
 du[1] = p[1]*u[1]*u[2]
 du[2] = -p[1]*u[1]*u[2]
end
u0 = [0.1;1.0]
tspan = (0.0,10.0)
p = [5.0]
prob = ODEProblem(g,u0,tspan,p)

sollogistic = solve(prob,reltol=1e-8,abstol=1e-8)
plot(sollogistic)


using Plots
using DifferentialEquations

function g(du,u,p,t)
 du[1] = p[1]*(u[2]-u[1])
 du[2] = u[1]*(p[2]-u[3]) - u[2]
 du[3] = u[1]*u[2] - p[3]*u[3]
end
u0 = [1.0;0.0;0.0]
tspan = (0.0,180.0)
p = [10.0,28.0,8/3]
prob = ODEProblem(g,u0,tspan,p)

sollor = solve(prob,reltol=1e-14,abstol=1e-14)

t = sollor.t
u1 = [s[1] for s in sollor.u];
u2 = [s[2] for s in sollor.u];
u3 = [s[3] for s in sollor.u];
# Get the results
plotlzsys=plot(t,u1, xaxis=false, yaxis=false, legend=false)
plot!(t,u2, xaxis=false, yaxis=false, legend=false)
plot!(t,u3, xaxis=false, yaxis=false, legend=false)

plotlz = plot(u1,u2, xaxis=false, yaxis=false, legend=false)
#plot(u1,u3, xaxis=false, yaxis=false, legend=false)

plot(plotlzsys,plotlz,layout=(1,2),legend=false,linewidth=3 )
