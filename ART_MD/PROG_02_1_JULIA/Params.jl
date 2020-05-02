mutable struct Params
    rCut::Float64
    region::Vector{Float64}
    nMol::Int64
    velMag::Float64
end

function init_Params( input_vars::InputVars )
    #
    density = input_vars.density
    initUcell = input_vars.initUcell
    temperature = input_vars.temperature

    rCut = 2.0^(1.0/6.0)

    region = initUcell ./ sqrt(density)

    nMol = prod(initUcell)

    velMag = sqrt( NDIM*(1.0 - 1.0/nMol) * temperature )

    # XXX Move to show
    @printf("Parameters in LJ unit:\n")
    @printf("rCut = %f\n", rCut)
    @printf("region = [%f,%f]\n", region[1], region[2])
    @printf("velMag = %f\n", velMag)

    return Params(rCut, region, nMol, velMag)
end
