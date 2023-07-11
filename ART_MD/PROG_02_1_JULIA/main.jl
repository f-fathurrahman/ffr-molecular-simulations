Pkg.activate("../")

using Printf
using Random

using StaticArrays: MVector

const NDIM = 2
const LJ2ANG = 3.4  # LJ unit to Angstrom

include("datatypes.jl")

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

    input_vars = InputVars(step_limit=10_000, step_avg=100)
    #@show input_vars
    
    params = Params(input_vars)
    #println(params)

    # This is using struct of vectors
    atoms = Atoms(params.nMol, 2)

    init_coords!( atoms, input_vars, params )
    init_velocities!( atoms, input_vars, params )
    #init_accelarations!( mol )
    
    print_mol_xyz( atoms, "TRAJ_0.xyz", "w", LJ2ANG )

    tot_ene = Property(0.0, 0.0, 0.0)
    kin_ene = Property(0.0, 0.0, 0.0)
    pressure  = Property(0.0, 0.0, 0.0)

    do_props_accum!( 0, input_vars.step_avg, tot_ene, kin_ene, pressure )

    step_limit = input_vars.step_limit
    more_cycles = true
    step_count = 0
    time_now = 0.0

    while more_cycles
        step_count, time_now =
        single_step!( atoms, input_vars, params,
                      tot_ene, kin_ene, pressure,
                      step_count, time_now )
        if step_count > step_limit
            more_cycles = false
        end
    end

end

@time main()
@time main()
