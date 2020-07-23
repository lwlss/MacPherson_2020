using DifferentialEquations
using Plots; gr()

f(u,r,p,t) = (p[1]*u) - (p[2]*u*r)

f(r,u,p,t) = (p[3]*u*r) - (p[4]*r)
