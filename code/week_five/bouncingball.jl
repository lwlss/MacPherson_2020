using DifferentialEquations
using ParameterizedFunctions

ball! = @ode_def BallBounce begin
  dy =  v
  dv = -g
end g

function condition(u,t,integrator)
  u[1]
end

function affect!(integrator)
    integrator.u[2] = -integrator.p[2] * integrator.u[2]
end

bounce_cb = ContinuousCallback(condition,affect!)

u0 = [50.0,0.0]
tspan = (0.0,15.0)
p = (9.8,0.9)
prob = ODEProblem(ball!,u0,tspan,p,callback=bounce_cb)

sol = solve(prob,Tsit5())
using Plots; gr()
plot(sol)

##########################################################

function condition_kick(u,t,integrator)
    t == 2
end

function affect_kick!(integrator)
    integrator.u[2] += 50
end

kick_cb = DiscreteCallback(condition_kick,affect_kick!)
u0 = [50.0,0.0]
tspan = (0.0,10.0)
p = (9.8,0.9)
prob = ODEProblem(ball!,u0,tspan,p,callback=kick_cb)

sol = solve(prob,Tsit5(),tstops=[2.0])
plot(sol)
