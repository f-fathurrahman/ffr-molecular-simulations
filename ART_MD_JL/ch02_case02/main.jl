Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using ARTMDCh02

function main()
    
    Random.seed!(1234)

    # Initialize input variables
    input_vars = InputVars(step_limit=10_000, step_avg=100)
    
    # Other originally global parameters     
    params = Params(input_vars)
    #println(params)

    # This is using struct of vectors
    atoms = Atoms(params.nMol, 2)

    init_coords!( atoms, input_vars, params )
    init_velocities!( atoms, input_vars, params )
    #init_accelarations!( mol )

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

main()