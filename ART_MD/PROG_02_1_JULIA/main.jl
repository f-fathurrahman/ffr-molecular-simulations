using Printf
using Random

const NDIM = 2
const LJ2ANG = 3.4  # LJ unit to Angstrom

mutable struct Mol
    r::Vector{Float64}
    rv::Vector{Float64}
    ra::Vector{Float64}
end

mutable struct Property
    val::Float64
    s::Float64
    s2::Float64
end

include("InputVars.jl")
include("Params.jl")

include("init_coords.jl")
include("init_velocities.jl")
include("init_accelarations.jl")
include("print_mol_xyz.jl")

include("accum_props.jl")
include("eval_props.jl")
include("apply_boundary_cond.jl")
include("compute_forces.jl")
include("leapfrog_step.jl")
include("single_step.jl")

function main()
    
    Random.seed!(1234)

    input_vars = InputVars(step_limit=100)
    @show input_vars
    
    params = init_Params(input_vars)
    @show params

    mol = init_coords( input_vars, params )
    init_velocities!( mol, input_vars, params )
    init_accelarations!( mol )
    
    print_mol_xyz( mol, "TRAJ_0.xyz", "w", LJ2ANG )

    totEnergy = Property(0.0, 0.0, 0.0)
    kinEnergy = Property(0.0, 0.0, 0.0)
    pressure  = Property(0.0, 0.0, 0.0)

    do_props_accum!( 0, input_vars.step_avg, totEnergy, kinEnergy, pressure )

    step_limit = input_vars.step_limit
    more_cycles = true
    step_count = 0
    time_now = 0.0

    while more_cycles
        step_count, time_now =
        single_step!( mol, input_vars, params,
                      totEnergy, kinEnergy, pressure,
                      step_count, time_now )
        if step_count > step_limit
            more_cycles = false
        end
    end

    println("Pass here ...")
end

@time main()
@time main()