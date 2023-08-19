Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using Printf
using ARTMDCh02

function run_density(density::Float64)
    Random.seed!(1234)
    outdir = @sprintf("MDRUN_dens_%.3f", density)
    sim = Simulation(
        InputVars(
            Δt = 0.001, density = density, initUcell = [50,50],
            limit_vel = 4, range_vel = 3.0, size_hist_vel = 50,
            step_avg = 100, step_limit = 1000, step_vel = 5,
            temperature = 1.0
        ),
        outdir = outdir
    )
    while sim.step_count <= sim.inp.step_limit
        single_step!(sim)
    end
    close_all_files!(sim)

    println("Finished, log file is ", joinpath(sim.outdir, sim.log_name))
end

for dens in [0.2, 0.4, 0.5, 0.6, 0.8, 1.0, 1.2]
    run_density(dens)
end