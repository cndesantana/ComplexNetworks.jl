# version 0.1

module ComplexNetworks 
using DataFrames
using StatsBase

############################################################################################################################################
#This function calls the pearson correlation module and fills a correlation matrix. This is the first step in order to build up the networks.

function corMatrix(data,segNumber)

	size = length(data)
	rho = zeros(size,size)

	for (i in 1:size)

		x = data[i]

		for (j in 1:size)

			y = data[j]
			rho[i,j] = cor(x,y)
		
		end
	end


	writedlm(string("rho_",segNumber,".txt"),rho)

end

####################################################################################################################################################
#This function creates segments with speciefied size and starting point, given a time series.

function segTimeSeries(raw,segSize,segNumber)

	return raw[segNumber:segNumber+segSize,:]

end

function timeVarCor(raw,segSize,overlap)
    size = length(raw[1])
    for (k in 1:(size - segSize))
        corMatrix(segTimeSeries(raw,segSize,k),k)
    end

end

timeseries = readtable("arq.dat")
timeVarCor(timeseries,10,1)

end #module
