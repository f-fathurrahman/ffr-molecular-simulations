using Printf
using Random

const NDIM = 2
const LJ2ANG = 3.4  # LJ unit to Angstrom

mutable struct Mol
    r::Vector{Float64}
    rv::Vector{Float64}
    ra::Vector{Float64}
end

mutable struct Prop
    val::Float64
    s::Float64
    s2::Float64
end

mutable struct InputVars
    deltaT::Float64
    density::Float64
    initUcell::Vector{Int64}
    stepAvg::Int64
    stepEquil::Int64
    stepLimit::Int64
    temperature::Int64
end

function init_InputVars()
    deltaT = 0.005
    density = 0.8
    initUcell = [20,20]
    stepAvg = 10
    stepEquil = 0
    stepLimit = 100
    temperature = 1.0
    return InputVars(deltaT, density, initUcell, stepAvg, stepEquil, stepLimit, temperature)
end

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

    region = initUcell ./ sqrt(density) #[ initUcell.x/sqrt(density), initUcell.x/sqrt(density) ]

    nMol = prod(initUcell)

    velMag = sqrt( NDIM*(1.0 - 1.0/nMol) * temperature )

    @printf("Parameters in LJ unit:\n")
    @printf("rCut = %f\n", rCut)
    @printf("region = [%f,%f]\n", region[1], region[2])
    @printf("velMag = %f\n", velMag)

    return Params(rCut, region, nMol, velMag)
end

include("init_coords.jl")
include("init_velocities.jl")
include("init_accelarations.jl")
include("print_mol_xyz.jl")

function main()
    
    Random.seed!(1234)

    input_vars = init_InputVars()
    @show input_vars
    
    params = init_Params(input_vars)
    @show params

    mol = init_coords( input_vars, params )
    init_velocities!( mol, input_vars, params )
    init_accelarations!( mol )
    
    println(mol[1].r)
    println(mol[1].rv)
    
    println(mol[2].r)
    println(mol[2].rv)
    
    print_mol_xyz( mol, "TRAJ_0.xyz", "w", LJ2ANG )

    println("Pass here ...")
end


#=

totEnergy = Prop(0.0, 0.0, 0.0)
kinEnergy = Prop(0.0, 0.0, 0.0)
pressure = Prop(0.0, 0.0, 0.0)

include("AccumProps.jl")
AccumProps( 0 )  # not actually needed, included for the sake of similarity

global moreCycles = true
global stepCount = 0
global timeNow = 0.0
global uSum = 0.0
global virSum = 0.0

include("LeapfrogStep.jl")
include("ApplyBoundaryCond.jl")
include("ComputeForces.jl")
include("EvalProps.jl")
include("PrintSummary.jl")
include("SingleStep.jl")

function main()
# Run the MD steps
  while moreCycles
      SingleStep(mol)
      if stepCount > stepLimit
          moreCycles = false
      end
  end
end
=#

main()
