function single_step!( sim::Simulation )

    time_now = sim.time_now
    step_count = sim.step_count
    totEnergy = sim.tot_ene
    kinEnergy = sim.kin_ene
    pressure = sim.pressure

    Δt = sim.input.Δt
    region = sim.region
    step_avg = sim.input.step_avg
    rCut = sim.rCut

    step_count += 1 # increment
    time_now = step_count*Δt

    atoms = sim.atoms

    leapfrog_step!( atoms, Δt, update_vel_only=false )
    
    apply_boundary_cond!( atoms, region )
    
    uSum, virSum = compute_forces!( atoms, rCut, region )
    
    leapfrog_step!( atoms, Δt, update_vel_only=true )
    
    vSum, vvSum = eval_props!( atoms, input_vars.density, uSum, virSum, totEnergy, kinEnergy, pressure )
    
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
