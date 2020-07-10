function logistic(r,x)
    r*x*(1.0-x)
end

function logisticmap(x0,r,N)
    results = [(x0,logistic(r,x0))];
    for i in 1:(N-1)
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xnew)])
      print(results)
  end
  results
end

print(logisticmap(0.2,3.7,10))
