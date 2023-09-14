function single_step!( sim::Simulation )

    # increment some global variables here
    sim.step_count += 1
    sim.time_now = sim.step_count*sim.inp.Δt

    step_count = sim.step_count
    time_now = sim.time_now

    totEnergy = sim.tot_ene
    kinEnergy = sim.kin_ene
    pressure = sim.pressure

    step_avg = sim.inp.step_avg
    step_equil = sim.inp.step_equil

    Δt = sim.inp.Δt
    region = sim.region
    rCut = sim.rCut
    density = sim.inp.density

    atoms = sim.atoms

    leapfrog_step!( atoms, Δt, update_vel_only=false )
    
    apply_boundary_cond!( atoms, region )
    
    uSum, virSum = compute_forces!( atoms, rCut, region )
    
    leapfrog_step!( atoms, Δt, update_vel_only=true )
    
    vSum, vvSum = eval_props!( atoms, density, uSum, virSum, totEnergy, kinEnergy, pressure )
    
    do_props_accum!( 1, step_avg, totEnergy, kinEnergy, pressure )

    Natoms = atoms.Natoms
    if sim.step_count % step_avg == 0
        # Compute the average
        do_props_accum!( 2, step_avg, totEnergy, kinEnergy, pressure )
        @printf(sim.log_file, "%5d %8.4f %7.4f %7.4f %7.4f %7.4f %7.4f %7.4f %7.4f\n",
            sim.step_count, sim.time_now, sum(vSum)/Natoms,
            totEnergy.s, totEnergy.s2, kinEnergy.s, kinEnergy.s2,
            pressure.s, pressure.s2 )
        do_props_accum!( 0, step_avg, totEnergy, kinEnergy, pressure )
    end
    return
end
