using DifferentialEquations
using Plots; gr()
using Formatting


function logistic(r,x)
    r*x*(1.0-x)
end

function logisticmap(;x0=0.21,r=4,n=10)
    results = [(x0,logistic(r,x0))];
    #N = 100; Note this line should not be here
    for i in 1:(n-1) # Note change of case N -> n.  Why?
      xold = results[end][2]
      xnew = logistic(r,xold)
      append!(results,[(xold,xold)])
      append!(results,[(xold,xnew)])
  end
  results
end

function vary(dname;x0_vals=[],r_vals=[], nvals=[])
 if !isdir(dname)
  mkdir(dname)
 end
 fno = 1
 for x0 in x0_vals
  for r in r_vals
      for n in nvals
          fname = format(dname*"/frame{:05d}.png",fno)
          fno = fno + 1
          simres = logisticmap(x0=x0, r=r, n=n)
          xvals = [x for (x, y) in simres]
          yvals = [y for (x, y) in simres]
          plot(xvals,yvals,legend=false,xaxis=false,yaxis=false,xlim=(0,1),ylim=(0,1));
          savefig(fname)
        end
    end
end
end


# Figure out how to make/deleate directories and remove their contents

r = 4.0
x = (r+sqrt(r-4)*sqrt(r))/(2*r)
vary("xn+2";x0_vals=(x+0.00001),r_vals=r, nvals=1:50)
