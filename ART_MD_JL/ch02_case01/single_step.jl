# mol can be Atoms or Vector{Mol}
function single_step!(
    mol, 
    input_vars, params,
    totEnergy, kinEnergy, pressure,
    step_count::Int64,
    time_now::Float64
)
    # Because step_count and time_now cannot be modified inplace we return them.

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
    
    vSum, vvSum = eval_props!( mol, input_vars.density, uSum, virSum, totEnergy, kinEnergy, pressure )
    
    do_props_accum!( 1, step_avg, totEnergy, kinEnergy, pressure )

    nMol = length(mol)

    if step_count % step_avg == 0

        # Compute the average
        do_props_accum!( 2, step_avg, totEnergy, kinEnergy, pressure )

        @printf("%5d %8.4f %7.4f %7.4f %7.4f %7.4f %7.4f %7.4f %7.4f\n",
            step_count, time_now, (vSum[1] + vSum[2])/nMol,
            totEnergy.s, totEnergy.s2, kinEnergy.s, kinEnergy.s2,
            pressure.s, pressure.s2 )

        do_props_accum!( 0, step_avg, totEnergy, kinEnergy, pressure )
    end
    return step_count, time_now
end
