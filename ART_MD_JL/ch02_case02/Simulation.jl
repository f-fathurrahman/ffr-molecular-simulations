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
    #
    log_name::String
    log_file::IOStream
    #
    hist_vel::Vector{Float64}
    count_vel::Int64
    hFunction::Float64
    #
    vel_dist_name::String
    vel_dist_file::IOStream
    #
    hfunc_name::String
    hfunc_file::IOStream
end


# In the current scenario, the atomistic structure is constructed
# from inp::InputVars
function Simulation( inp::InputVars;
    log_name="LOG_md",
    vel_dist_name="VEL_DIST.dat",
    hfunc_name="HFUNC.dat"
)

    println("Input variables:")
    println(inp)
    println()

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
    pressure = Property(0.0, 0.0, 0.0)

    do_props_accum!( 0, inp.step_avg, tot_ene, kin_ene, pressure )

    more_cycles = true
    step_count = 0
    time_now = 0.0

    hist_vel = zeros(Float64, inp.size_hist_vel)
    count_vel = 0
    hFunction = 0.0

    log_file = open(log_name, "w")
    vel_dist_file = open(vel_dist_name, "w")
    hfunc_file = open(hfunc_name, "w")

    return Simulation(
        inp, atoms,
        rCut, region, velMag,
        tot_ene, kin_ene, pressure,
        more_cycles, step_count, time_now,
        log_name, log_file,
        hist_vel, count_vel, hFunction,
        vel_dist_name, vel_dist_file,
        hfunc_name, hfunc_file
    )
end


function close_all_files!(sim::Simulation)
    close(sim.log_file)
    close(sim.vel_dist_file)
    close(sim.hfunc_file)
end