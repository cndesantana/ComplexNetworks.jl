# version 0.1

module ComplexNetworks 
using DataFrames

############################################################################################################################################
#This function calls the pearson correlation module and fills a correlation matrix. This is the first step in order to build up the networks.

function corMatrix(data,segNumber)

	elemNum, chNum  = size(data)
	rho = zeros(elemNum,elemNum)

	for (i in 1:elemNum)

		x = data[:,i]

		for (j in 1:elemNum)

			y = data[:,j]
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
    elemNum, chNum  = size(raw)
    for (k in 1:(elemNum - segSize))
        corMatrix(segTimeSeries(raw,segSize,k),k)
    end

end

end #module
