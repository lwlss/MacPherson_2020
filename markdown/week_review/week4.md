# Week Four

## Logistic Map: X<sub>n+3</sub> = X<sub>n</sub>

Following from the previous week, I took one step further and solved X<sub>n+3</sub> = X<sub>n</sub>

Using wolfram Alpha once again, the roots of the equation X<sub>n+3</sub> = X<sub>n</sub> for Xn can be found to be:

![xn3sol](../../images/xn3_solution.png)

By inputting just one of the above solutions into the `vary` function for the values of X and running for 10 iterations, a stable set of identical images will be produced:

```julia
r = 4
x = (1/2)*(1-sqrt(-(2sqrt(r-4))/r^(3/2)-2/r+1))
vary("xn+3";x0_vals=(x),r_vals=r, nvals=1:50)
```

![stablexn3](../../images/xn3_stable.png)

When the code is run again, but this time by adding ε epsilon onto the value of x seen below, it quickly destabilises the system and causes chaotic behaviour typically seen in the logistic map to occur once again:

```julia
r = 4
x = (1/2)*(1-sqrt(-(2sqrt(r-4))/r^(3/2) - 2/r + 1))
vary("xn+3";x0_vals=(x+0.00001),r_vals=r, nvals=1:50) # here the `0.00001` represents epsilon
```

![destablexn3](../../xn+3/output.gif)
