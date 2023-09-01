Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using Printf
using ARTMDCh02

function print_info(sim::Simulation)
    println("rCut = ", sim.rCut)
    println("Natoms = ", sim.atoms.Natoms)
    println("cells = ", sim.cells)
end


function main()
    Random.seed!(1234)
    # Use small initUcell
    sim = Simulation(
        InputVars(
            Δt = 0.001, density = 0.8, initUcell = [4,4],
            limit_vel = 4, range_vel = 3.0, size_hist_vel = 50,
            step_avg = 100, step_limit = 1000, step_vel = 5,
            temperature = 1.0,
            nebr_tab_fac = 8, r_nebr_shell = 0.4
        ),
        outdir="MDRUN_debug"
    )

    print_info(sim)
    build_nebr_list!(sim)
end


main()