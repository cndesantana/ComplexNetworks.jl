# version 0.1

module ComplexNetworks 
using DataFrames
using StatsBase

#This function, written by Jalem Raj Rohit (https://github.com/Dawny33/) performs a pearson correlation analysis and retuns a rho value.
function p_correlation(x,y)
        @assert(length(x) == length(y))
        n = length(x)
        @assert(n>0)
        avg_x = mean(x)
        avg_y = mean(y)
        prod_diff = 0
        xdiff2 = 0
        ydiff2 = 0
        for id = 1:n
                xdiff = x[id] - avg_x
                ydiff = y[id] - avg_y
                prod_diff += xdiff*ydiff
                xdiff2 += xdiff^2
                ydiff2 += ydiff^2
        end
return prod_diff/sqrt(xdiff2*ydiff2)
end


#This function calls the pearson correlation module and fills a correlation matrix. This is the first step in order to build up the networks.

function corMatrix(data)
size = length(data)
rho = zeros(size,size)

for (i in 1:size)
	x = data[i]
	for (j in 1:size)
		y = data[j]
		rho[i,j] = p_correlation(x,y)
		
	end
end


writedlm("rho.txt",rho)

end

timeseries = readtable("arq.dat")
corMatrix(timeseries)

end #module
