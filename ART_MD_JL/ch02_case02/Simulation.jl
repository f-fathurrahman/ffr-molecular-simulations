mutable struct Simulation
    inp::InputVars
    atoms::Atoms
    rCut::Float64
    region::Vector{Float64}
    velMag::Float64
    tot_ene::Property
    kin_ene::Property
    pressure::Property
    more_cycles::Bool
    step_count::Int64
    time_now::Float64 
end


# In the current scenario, the atomistic structure is constructed
# from inp::InputVars
function Simulation( inp::InputVars )
    
    density = inp.density
    initUcell = inp.initUcell
    temperature = inp.temperature

    rCut = 2.0^(1.0/6.0)
    region = initUcell ./ sqrt(density)
    Natoms = prod(initUcell)
    velMag = sqrt( NDIM*(1.0 - 1.0/Natoms) * temperature )

    atoms = Atoms(Natoms, 2)
    init_coords!( atoms, inp, region )
    init_velocities!( atoms, inp, velMag )
    # accelarations are already initialized to zero

    tot_ene = Property(0.0, 0.0, 0.0)
    kin_ene = Property(0.0, 0.0, 0.0)
    pressure  = Property(0.0, 0.0, 0.0)

    do_props_accum!( 0, inp.step_avg, tot_ene, kin_ene, pressure )

    more_cycles = true
    step_count = 0
    time_now = 0.0

    return Simulation(
        inp,
        atoms,
        rCut,
        region,
        velMag,
        tot_ene,
        kin_ene,
        pressure,
        more_cycles,
        step_count,
        time_now
    )
end
