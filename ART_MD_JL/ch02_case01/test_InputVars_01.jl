Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using ARTMDCh02

input_vars = InputVars(step_limit=10_000, step_avg=100)
println(input_vars)
