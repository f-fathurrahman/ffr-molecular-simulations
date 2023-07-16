Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using Printf
using ARTMDCh02

function main()
    
    Random.seed!(1234)

    input_vars = InputVars(step_limit=100_000)
    params = Params(input_vars)

    # This is using struct of vectors
    atoms = Atoms(params.nMol, 2)

    init_coords!( atoms, input_vars, params )
    init_velocities!( atoms, input_vars, params )
    #init_accelarations!( mol )

    tot_ene = Property(0.0, 0.0, 0.0)
    kin_ene = Property(0.0, 0.0, 0.0)
    pressure  = Property(0.0, 0.0, 0.0)

    # Zero out all Property's
    do_props_accum!( 0, input_vars.step_avg, tot_ene, kin_ene, pressure )

    step_limit = input_vars.step_limit
    more_cycles = true
    step_count = 0
    time_now = 0.0

    while more_cycles
        step_count, time_now =
        my_single_step!( atoms, input_vars, params, tot_ene, kin_ene, pressure,
                         step_count, time_now )
        if step_count > step_limit
            more_cycles = false
        end
    end
end


function my_single_step!(
    mol,
    input_vars, params,
    totEnergy, kinEnergy, pressure,
    step_count::Int64,
    time_now::Float64
)
    Δt = input_vars.Δt
    region = params.region
    step_avg = input_vars.step_avg
    rCut = params.rCut

    step_count = step_count + 1
    time_now = step_count*Δt

    leapfrog_step!( mol, Δt, 1 )
    
    apply_boundary_cond!( mol, region )
    
    uSum, virSum = compute_forces!( mol, rCut, region )
    
    leapfrog_step!( mol, Δt, 2 )
    
    _, _ = eval_props!( mol, input_vars.density, uSum, virSum, totEnergy, kinEnergy, pressure )

    if step_count % 100 == 0
        @printf("%18.10f ", time_now)
        @printf("%18.10f ", totEnergy.val)
        @printf("%18.10f ", kinEnergy.val)
        @printf("%18.10f ", pressure.val)
        @printf("\n")
    end

    return step_count, time_now
end


main()