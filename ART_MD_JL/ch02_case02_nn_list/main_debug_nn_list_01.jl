Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using ARTMDCh02
using GLMakie

set_theme!(theme_black())

#function main()
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
    #print_xyz(sim.atoms)


    f = Figure()
    ax = Axis(f[1,1], aspect=1)
    x = sim.atoms.r[1,:]
    y = sim.atoms.r[2,:]
    scatter!(ax, x, y, markersize=20)

    region = sim.region
    x1 = -region[1]/2; x2 = region[1]/2
    y1 = -region[1]/2; y2 = -region[2]/2
    lines!([x1, x2], [y1, y2], color=:blue)

    x1 = region[1]/2;  x2 = region[1]/2
    y1 = -region[1]/2; y2 = region[2]/2
    lines!([x1, x2], [y1, y2], color=:blue)

    x1 = region[1]/2; x2 = -region[1]/2
    y1 = region[1]/2; y2 = region[2]/2
    lines!([x1, x2], [y1, y2], color=:blue)

    x1 = -region[1]/2; x2 = -region[1]/2
    y1 = region[1]/2;  y2 = -region[2]/2
    lines!([x1, x2], [y1, y2], color=:blue)

    save("IMG_atoms.png", f)


#    println("Finished, log file is ", joinpath(sim.outdir, sim.log_name))
#end

#main()