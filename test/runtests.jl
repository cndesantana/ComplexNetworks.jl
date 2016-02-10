using ComplexNetworks
using DataFrames

function main()
    
    println("Testing ComplexNetworks library");
   
    timeseries = readdlm("arq.dat", ',')
    ComplexNetworks.timeVarCor(timeseries,10,1)
   
end

main();
