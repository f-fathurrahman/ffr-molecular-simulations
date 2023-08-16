mutable struct Simulation
    input::InputVars
    atoms::Atoms
    rCut::Float64
    region::Vector{Float64}
    nMol::Int64
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

    tot_ene = Property(0.0, 0.0, 0.0)
    kin_ene = Property(0.0, 0.0, 0.0)
    pressure  = Property(0.0, 0.0, 0.0)

    more_cycles = true
    step_count = 0
    time_now = 0.0

    return Simulation(
        input,
        atoms,
        rCut,
        region,
        nMol,
        velMag,
        tot_ene,
        kin_ene,
        pressure,
        more_cycles,
        step_count,
        time_now
    )
end
