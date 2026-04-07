push!(LOAD_PATH, pwd())

import Random
using ARTMDCh03

function main()
    Random.seed!(1234)
    sim = Simulation(
        InputVars(
            Δt = 0.005, density = 0.8, initUcell = [5,5,5],
            step_avg = 20, step_limit = 5000,
            temperature = 1.0
        ),
        outdir="MDRUN_0"
    )
    while sim.step_count <= sim.inp.step_limit
        single_step!(sim)
    end
    close_all_files!(sim)

    println("Finished, log file is ", joinpath(sim.outdir, sim.log_name))
end

main()
