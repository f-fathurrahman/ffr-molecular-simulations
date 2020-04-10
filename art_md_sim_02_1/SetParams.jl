# set parameters
#function SetParams( INP::InputVars )
function SetParams()
    #
    #density = INP.density
    #initUcell = INP.initUcell
    #temperature = INP.temperature
    #
    global const rCut = 2.0^(1.0/6.0)
    global const region = VecR( initUcell.x/sqrt(density), initUcell.x/sqrt(density) )
    global const nMol = initUcell.x * initUcell.y
    global const velMag = sqrt( NDIM*(1.0-1.0/nMol) * temperature )
    #
    @printf( "Parameters in LJ unit:\n" )
    @printf( "rCut = %f\n", rCut )
    @printf( "region = [%f,%f]\n", region.x, region.y )
    @printf( "velMag = %f\n", velMag )
    return rCut, region, nMol, velMag
end
