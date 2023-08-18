function eval_vel_dist!(
    sim::Simulation
)
    
    #println("Evaluating velocity distrib")

    hist_vel = sim.hist_vel
    size_hist_vel = sim.inp.size_hist_vel
    atoms = sim.atoms
    Natoms = sim.atoms.Natoms

    # histVel: array
    fill!(hist_vel, 0.0)
    
    Δv = sim.inp.range_vel / sim.inp.size_hist_vel
    println("Δv = ", Δv)

    for ia in 1:Natoms
        vlen = sqrt(atoms.rv[1,ia]^2 + atoms.rv[2,ia]^2)
        j = floor(Int64, vlen / Δv) + 1 # offset by 1 ?
        # because j is using 0-based array
        idx_update = min(j, size_hist_vel)
        hist_vel[idx_update] += 1
        # increment count of histVel, min of size_hist_vel-1 (size of hist_vel) or index j
    end
    sim.count_vel += 1 # increment countVel
    
    # Calculate hFunction
    if sim.count_vel == sim.inp.limit_vel
        hist_sum = sum(hist_vel)
        hist_vel[:] *= (1/hist_sum) # scale
        sim.hFunction = 0.0
        for i in 1:size_hist_vel
            if hist_vel[i] > 0.0
                vi = (i - 0.5)*Δv
                sim.hFunction =+ hist_vel[i] * log( hist_vel[i] / ( (i - 0.5)*Δv) )
                # FIXME: check the denumerator: it should be v_{n}^{d-1}
                # For 2d, d = 2, so it should be v_{n}
                # We start from 1 instead of 0, the offset is -0.5
            end
        end
        print_vel_dist(sim)
        # Print out the result here
        # Reset countVel
        sim.count_vel = 0
    end

    return
end


function print_vel_dist( sim::Simulation )
    
    time_now = sim.time_now
    hist_vel = sim.hist_vel
    
    vel_dist_file = sim.vel_dist_file
    hfunc_file = sim.hfunc_file

    hFunction = sim.hFunction
    size_hist_vel = sim.inp.size_hist_vel
    range_vel = sim.inp.range_vel

    @printf(vel_dist_file, "# %18.10f\n", time_now)
    for i in 1:size_hist_vel
        v_bin = (i - 0.5)*range_vel/size_hist_vel
        @printf(vel_dist_file, "%18.10f %18.10f\n", v_bin, hist_vel[i])
    end

    @printf(hfunc_file, "%18.10f %18.10f\n", time_now, hFunction)

    return
end