using Plots # You might need to install this?
using Formatting # You'll probably need to install this

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

if !isdir("frames")
  mkdir("frames")
end

#if !isdir("frames_r")
 # mkdir("frames_r")
#end

fno = 1 # Frame counter
for x0 in 0:0.002:1.0
#for r in 0:0.01:5
    # Make a filename (within new directory) that is numbered
    # padded to 5 digits with zeros (i.e. 1 -> 00001)
    global fno
    fname = format("frames/frame{:05d}.png",fno)
    fno = fno + 1

    simres = logisticmap(x0=x0,r=4,n=100)
    #simres = logisticmap(x0=0.2,r=r,n=100)
    xvals = [x for (x, y) in simres]
    yvals = [y for (x, y) in simres]
    plot(xvals,yvals,legend=false,xaxis=false,yaxis=false,xlim=(0,1),ylim=(0,1));
    savefig(fname)
end

if !isdir("frames_time")
  mkdir("frames_time")
end

@time begin
    fno = 1 # Frame counter
    for x0 in 0:1:1.0
    #for r in 0:0.01:5
        # Make a filename (within new directory) that is numbered
        # padded to 5 digits with zeros (i.e. 1 -> 00001)
        global fno
        fname = format("frames_time/frame{:05d}.png",fno)
        fno = fno + 1

        simres = logisticmap(x0=x0,r=4,n=100)
        #simres = logisticmap(x0=0.2,r=r,n=100)
        xvals = [x for (x, y) in simres]
        yvals = [y for (x, y) in simres]
        plot(xvals,yvals,legend=false,xaxis=false,yaxis=false,xlim=(0,1),ylim=(0,1));
        savefig(fname)
    end
end


# NOTES
# These are cobweb plots
# https://en.wikipedia.org/wiki/Cobweb_plot

# The above code generates cobweb plots, fixing r and varying x0
# for all x0 from 0 to 1.0 in steps of 0.1

# Can you instead fix x0 and vary r from 0 to 5?

# Can you check how long it takes your computer to run through
# one iteration of the loop above?  How many frames could you
# make in an hour? - 18000  Try decreasing the step size for varying x0
# so that your computer is busy making plots for one hour.
# Do the same for the r version.

# To make a .gif from the .png files in the frames directory
# Need to first install ffmpeg, add to system path, then navigate to frames directory in command line
# and run ffmpeg like this:
# ffmpeg -framerate 12 -i frame%05d.png output.gif


#xvals = []
#yvals = []

#for (x, y) in simres
    #append!(xvals, x)
    #append!(yvals, y)
#end
