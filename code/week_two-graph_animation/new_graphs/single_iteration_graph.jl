using Plots
using Formatting

function logistic(r,x)
    r*x*(1.0-x)
end

function logisticmap(;x0=0.2,r=4,n=10)
    results = [(x0,logistic(r,x0))];
    for i in 1:(n-1)
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xold)])
      append!(results,[(xold,xnew)])
  end
  results
end

xvals = [x for (x, y) in simres]
yvals = [y for (x, y) in simres]

function vary(dname;x0_vals=[],r_vals=[])
 if !isdir(dname)
  mkdir(dname)
 end
 fno = 1
 for x0 in x0_vals
  for r in r_vals
   fname = format(dname*"/frame{:05d}.png",fno)
   fno = fno + 1
   simres = logisticmap(x0=x0, r=r, n=100)
   xvals = [x for (x, y) in simres]
   yvals = [y for (x, y) in simres]
   plot(xvals,yvals,legend=false,xaxis=false,yaxis=false,xlim=(0,1),ylim=(0,1));
   savefig(fname)
  end
 end
end


# name/number each iteration then plot 1, 1+2, 1+2+3 ...
