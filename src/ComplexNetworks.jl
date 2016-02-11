# version 0.1

module ComplexNetworks 
using DataFrames

############################################################################################################################################
#This function calls the pearson correlation module and fills a correlation matrix. This is the first step in order to build up the networks.


function corMatrix(data,segNumber)

	elemNum, chNum  = size(data)
	rho = zeros(chNum,chNum)
	adj = zeros(chNum,chNum)
	

	for (i in 1:chNum)

		x = data[:,i]

		for (j in 1:chNum)

			y = data[:,j]
			rho[i,j] = cor(x,y)
                        if abs(rho[i,j]) >= 0.9
                            
                            adj[i,j] = 1
                        
                        end
		end
	end


	writedlm(string("./files/rho_",segNumber,".txt"),rho)
	writedlm(string("./files/adj_",segNumber,".txt"),adj)
	
	return adj

end

####################################################################################################################################################
#This function creates segments with speciefied size and starting point, given a time series.

function segTimeSeries(raw,segSize,segNumber)

	return raw[segNumber:segNumber+segSize-1,:]

end

#######################################################################################################################################################
#This function runs the corMatrix function several times in order to calculate the time varying correlation matrix

function timeVarCor(raw,segSize,overlap)

    elemNum, chNum  = size(raw)
    adjT = zeros(chNum,chNum)
    for (k in 1:(elemNum - segSize))
            
        adjT = adjT + corMatrix(segTimeSeries(raw,segSize,k),k)
        
    end
    writedlm(string("adjT.txt"),adjT)
    
end


end #module
