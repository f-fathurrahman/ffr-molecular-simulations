Pkg.activate("../")

push!(LOAD_PATH, pwd())

import Random
using Printf
using ARTMDCh02

function idx_vlinear(p, s)
   return p[2] * s[1] + p[1]
end

function print_info(sim::Simulation)
    println("r_cut = ", sim.r_cut)
    println("Natoms = ", sim.atoms.Natoms)
    println("cells = ", sim.cells)
end


# m2v and cells are modified
# shift will be reset to zero at the beginning, no need to set it zeros
# before calling this function
function v_cell_wrap!(
    m2v::Vector{Int64},
    shift::Vector{Float64},
    cells::Vector{Int64},
    region::Vector{Float64},
    i::Int64
)
    fill!(shift, 0.0)
    if m2v[i] >= cells[i]
        m2v[i] = 0
        shift[i] = region[i]
    elseif m2v[i] < 0
        m2v[i] = cells[i] - 1
        shift[i] = -region[i]
    end
    return
end


function build_cell_list!(cell_list, atoms, region, cells)

    println()
    println("Bulding cell_list:")
    println()

    invWid = cells ./ region

    Natoms = atoms.Natoms

    # indexing starts from 1, 0 is invalid value
    fill!(cell_list, 0)
    rs = zeros(Float64, 2)
    cc = zeros(Int64, 2)

    prev_c = 0
    for ia in 1:Natoms
        # shift the coordinates (?)
        rs[1] = atoms.r[1,ia] + 0.5*region[1]
        rs[2] = atoms.r[2,ia] + 0.5*region[2]
        #
        cc[1] = floor(Int64, rs[1] * invWid[1])
        cc[2] = floor(Int64, rs[2] * invWid[2])
        #
        c = idx_vlinear(cc, cells) + Natoms + 1 # offset by 1
        # c will always larger than Natoms
        #println("\nia = ", ia, " rs = ", rs)
        #println("ia = ", ia, " cc = ", cc, " c = ", c)
        println("\nCurrent cell_list")
        println("Atom index: ", ia, " linear index: ", c)
        if prev_c != c
            println("Different cell")
        end
        # What are these ?
        cell_list[ia] = cell_list[c] # pointer to next data
        cell_list[c] = ia # the data
        print_cell_list(cell_list, Natoms)
        prev_c = c
    end
    return
end
# The cell_list[Natoms+1:Natoms+Ncells] contain the first index of the list
# cell_list[1:Natoms] contains index to next data


function print_cell_list(cell_list, Natoms)
    N = size(cell_list, 1)
    for i in 1:N
        @printf("%3d ", i)
        if i == Natoms
            print(" | ")
        end
    end
    println()
    for i in 1:N
        @printf("%3d ", cell_list[i])
        if i == Natoms
            print(" | ")
        end
    end
    println()
end



function main()
    Random.seed!(1234)
    # Use small initUcell
    sim = Simulation(
        InputVars(
            Δt = 0.001, density = 0.8, initUcell = [3,3],
            limit_vel = 4, range_vel = 3.0, size_hist_vel = 50,
            step_avg = 100, step_limit = 1000, step_vel = 5,
            temperature = 1.0,
            nebr_tab_fac = 8, r_nebr_shell = 0.4
        ),
        outdir="MDRUN_debug"
    )

    print_info(sim)
    #print_xyz(sim.atoms)
    #plot_debug(sim)

    r_cut = sim.r_cut
    r_nebr_shell = sim.inp.r_nebr_shell
    cells = sim.cells
    region = sim.region
    cell_list = sim.cell_list
    atoms = sim.atoms
    Natoms = atoms.Natoms

    rr_nebr = (r_cut + r_nebr_shell)^2

    build_cell_list!(cell_list, atoms, region, cells)

    println("\nFinal cell_list:")
    for i in 1:length(cell_list)
        @printf("%3d %3d\n", i-1, cell_list[i]-1)
        # offset by 1 to get the same result as the original C
    end

    # Debug DO_CELL
    # This is how we loop over cell and get the list of atoms
    # within the cell
    for icell in (Natoms+1):length(cell_list)
        println("\nicell = ", icell - Natoms)
        j = cell_list[icell]
        while j > 0
            println("Atom index j = ", j)
            j = cell_list[j] # next data
        end
    end



    N_OFFSET = 5
    OFFSET_VALS = [
      [0,0], [1,0], [1,1], [0,1], [-1,1]
    ]

    # cell numbering uses C-style ordering (row first)
    m1v = [0, 0]
    m2v = [0, 0]
    sim.nebr_tab_len = 0
    for m1y in 0:cells[2]-1, m1x in 0:cells[1]-1
        m1v[1] = m1x
        m1v[2] = m1y
        # get linear index of current cell (offset by Natoms+1)
        m1 = idx_vlinear(m1v, cells) + Natoms + 1
        @printf("\n[%d %d]: m1 = %d\n", m1x, m1y, m1)
        for ioff in 2:2
            m2v = m1v + OFFSET_VALS[ioff]
        end
    end

end


#=
using GLMakie
function plot_debug(sim::Simulation)
    
    set_theme!(theme_black())

    f = Figure()
    ax = Axis(f[1,1], aspect=1)
    x = sim.atoms.r[1,:]
    y = sim.atoms.r[2,:]
    scatter!(ax, x, y, markersize=20)

    # Plot the region
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
end
=#

main()