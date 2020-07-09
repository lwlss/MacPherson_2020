function logistic(r,x)
    r*x*(1.0-x)
end


x0 = 0.2
r = 3.7
results = [(x0,logistic(r,x0))];
# We've already seen arrays: [1,2,3,4]
# Here I'm using tuples: (1,2,3,4)
# Results is an array filled with tuples!
N = 1000; # or any big number
for i in 1:(N-1)
  xold = results[end][2]
  xnew = logistic(r,xold)
  append!(results,[(xold,xnew)])
end

print(results)
