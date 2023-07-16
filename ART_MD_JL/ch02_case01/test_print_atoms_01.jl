Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using Printf
using ARTMDCh02
    
Random.seed!(1234)

input_vars = InputVars(step_limit=10_000, step_avg=100)    
params = Params(input_vars)
atoms = Atoms(params.nMol, 2)

init_coords!( atoms, input_vars, params )
init_velocities!( atoms, input_vars, params )
print_mol_xyz( atoms, "TRAJ_0.xyz", "w", LJ2ANG )

tot_ene = Property(0.0, 0.0, 0.0)
kin_ene = Property(0.0, 0.0, 0.0)
pressure  = Property(0.0, 0.0, 0.0)

do_props_accum!( 0, input_vars.step_avg, tot_ene, kin_ene, pressure )

step_limit = input_vars.step_limit
more_cycles = true
step_count = 0
time_now = 0.0
while more_cycles
    step_count, time_now =
    single_step!( atoms, input_vars, params,
                  tot_ene, kin_ene, pressure,
                  step_count, time_now )
    if step_count % 100 == 0
        print_mol_xyz( atoms, "TRAJ_0.xyz", "a", LJ2ANG )
    end
    if step_count > step_limit
        more_cycles = false
    end
end
