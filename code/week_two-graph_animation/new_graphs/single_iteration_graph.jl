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


# name/number each iteration then plot 1, 1+2, 1+2+3 ...


# To make frames varying r, specify x0_vals as an array with a single value
# along with whatever values of r you want to loop through
vary("frames_r";x0_vals=[0.5],r_vals=0:0.1:5, n=[100])

# To make frames varying x0, specify r_vals as an array with a single value
# along with whatever values of x0 you want to loop through
vary("frames_x0";x0_vals=0:0.05:1,r_vals=[4.0], n=[100])

vary("frames_n";x0_vals=[0.2],r_vals=[4], nvals = 1:500)

r_vals = 4.1
vary("loop1";x0_vals=[(r_vals+sqrt(r_vals-4)*sqrt(r_vals))/(2*r_vals)],r_vals=[4], nvals=1:100)

vary("loop2";x0_vals=[(r_vals-sqrt(r_vals-4)*sqrt(r_vals))/(2*r_vals)],r_vals=[4], nvals=1:10)

ffmpeg -i frame%05d.png -vf "fps=12,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 output.gif
