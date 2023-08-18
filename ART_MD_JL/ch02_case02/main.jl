Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using ARTMDCh02

function main()
    Random.seed!(1234)
    sim = Simulation(
        InputVars(step_limit=10_000, step_avg=100)
    )
    while sim.step_count <= sim.inp.step_limit
        single_step!(sim)
    end
end

main()