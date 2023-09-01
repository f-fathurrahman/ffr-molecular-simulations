Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using Printf
using ARTMDCh02

function print_info(sim::Simulation)
    println("rCut = ", sim.rCut)
    println("Natoms = ", sim.atoms.Natoms)
    println("cells = ", sim.cells)
end


function debug_compute_forces!(sim)
    
    rCut = sim.rCut
    rrCut = rCut^2

    atoms = sim.atoms
    fill!(atoms.ra, 0.0)

    dr = [0.0, 0.0]
    uSum = 0.0
    virSum = 0.0
    
    nebr_tab_len = sim.nebr_tab_len
    nebr_tab = sim.nebr_tab
    nebr_tab_len = sim.nebr_tab_len
    region = sim.region

    for n in 0:(nebr_tab_len-1)
        j1 = nebr_tab[2 * n + 1]
        j2 = nebr_tab[2 * n + 1 + 1]

        @printf("n = %3d, atoms pair: (%3d %3d)\n", n, j1, j2)

        #
        # Compute difference vector
        dr[1] = atoms.r[1,j1] - atoms.r[1,j2]
        dr[2] = atoms.r[2,j1] - atoms.r[2,j2]
        #
        # Apply PBC
        dr[1] = ARTMDCh02.vwrap( dr[1], region[1] )
        dr[2] = ARTMDCh02.vwrap( dr[2], region[2] )
        #
        rr = dr[1]^2 + dr[2]^2

        if rr < rrCut
            rri = 1.0/rr # rri is dr^{-2}
            rri3 = rri^3 # rri3 is dr^{-6}
            fcVal = 48.0 * rri3 * ( rri3 - 0.5 ) * rri
            # fcVal = 48 * (dr^{-14} - 0.5*dr^{-8})
            #
            # 1st particle, unit mass, positive sign
            atoms.ra[1,j1] += fcVal*dr[1]
            atoms.ra[2,j1] += fcVal*dr[2]
            #
            # 2nd particle, unit mass, negative sign
            atoms.ra[1,j2] -= fcVal*dr[1]
            atoms.ra[2,j2] -= fcVal*dr[2]
            #
            uSum += 4.0*rri3*(rri3 - 1.0) + 1.0
            #
            virSum += fcVal*rr
        end
    end

    return uSum, virSum

end


function main()
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

    print_info(sim)
    build_nebr_list!(sim)
    println("nebr_tab_len = ", sim.nebr_tab_len)

    uSum, virSum = debug_compute_forces!(sim)

end


main()