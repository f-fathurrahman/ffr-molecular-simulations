Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using ARTMDCh02

function main()
    Random.seed!(1234)
    sim = Simulation(
        InputVars(step_limit=10_000, step_avg=1)
    )
    single_step!(sim)
end

main()