mutable struct Params
    rCut::Float64
    region::Vector{Float64}
    nMol::Int64
    velMag::Float64
end
# This datatype represent some parameters that are derived
# or calculated from InputVars.
# Some of them might be InputVars as well
# This is translated from SetParams.c



function Params( input_vars::InputVars )
    #
    density = input_vars.density
    initUcell = input_vars.initUcell
    temperature = input_vars.temperature

    rCut = 2.0^(1.0/6.0)

    region = initUcell ./ sqrt(density)

    nMol = prod(initUcell)

    velMag = sqrt( NDIM*(1.0 - 1.0/nMol) * temperature )

    return Params(rCut, region, nMol, velMag)
end


import Base: show
function show( io::IO, p::Params )
    @printf("\n")
    @printf("Parameters in LJ unit:\n")
    @printf("\n")
    @printf("nMol = %d\n", p.nMol)
    @printf("rCut = %18.10f\n", p.rCut)
    @printf("region = [%18.10f,%18.10f]\n", p.region[1], p.region[2])
    @printf("velMag = %18.10f\n", p.velMag)
end