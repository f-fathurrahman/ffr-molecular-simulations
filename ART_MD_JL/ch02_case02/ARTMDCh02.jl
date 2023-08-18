module ARTMDCh02

using Printf
using Random

using StaticArrays: MVector

# Let's fix NDIM=2 for the moment
const NDIM = 2
const LJ2ANG = 3.4  # LJ unit to Angstrom

export NDIM, LJ2ANG

include("Atoms.jl")
export Atoms

include("Property.jl")
export Property
export prop_zero!, prop_accum!, prop_avg!, do_props_accum!

include("InputVars.jl")
export InputVars

include("init_coords.jl")
export init_coords, init_coords!

include("init_velocities.jl")
export init_velocities!

#include("print_mol_xyz.jl")
#export print_mol_xyz

include("Simulation.jl")
export Simulation, close_all_files!

include("eval_props.jl")
export eval_props!

include("apply_boundary_cond.jl")
export apply_boundary_cond!

include("compute_forces.jl")
export compute_forces!

include("leapfrog_step.jl")
export leapfrog_step!

include("eval_vel_dist.jl")
export eval_vel_dist!

include("single_step.jl")
export single_step!

end # module