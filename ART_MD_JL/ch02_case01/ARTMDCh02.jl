module ARTMDCh02

using Printf
using Random

using StaticArrays: MVector

# Let's fix NDIM=2 for the moment
const NDIM = 2
const LJ2ANG = 3.4  # LJ unit to Angstrom

export NDIM, LJ2ANG

include("datatypes.jl")
export Mol, Atoms, Property

include("InputVars.jl")
export InputVars

include("Params.jl")
export Params

include("init_coords.jl")
export init_coords, init_coords!

include("init_velocities.jl")
export init_velocities!

include("init_accelarations.jl")
export init_accelarations!

include("print_mol_xyz.jl")
export print_mol_xyz

include("accum_props.jl")
export prop_zero!, prop_accum!, prop_avg!, do_props_accum!

include("eval_props.jl")
export eval_props!

include("apply_boundary_cond.jl")
export apply_boundary_cond!

include("compute_forces.jl")
export compute_forces!

include("leapfrog_step.jl")
export leapfrog_step!

include("single_step.jl")
export single_step!

end # module