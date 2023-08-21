Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using ARTMDCh02

function main()
    Random.seed!(1234)
    sim = Simulation(
        InputVars(
            Δt = 0.001, density = 0.8, initUcell = [50,50],
            limit_vel = 4, range_vel = 3.0, size_hist_vel = 50,
            step_avg = 100, step_limit = 1000, step_vel = 5,
            temperature = 1.0
        ),
        outdir="MDRUN_3"
    )
    while sim.step_count <= sim.inp.step_limit
        single_step!(sim)
    end
    close_all_files!(sim)

    println("Finished, log file is ", joinpath(sim.outdir, sim.log_name))
end

main()