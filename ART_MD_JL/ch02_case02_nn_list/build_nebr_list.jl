function idx_vlinear(p, s)
   return p[2] * s[1] + p[1]
end

# m2v and cells are modified
# shift will be reset to zero at the beginning, no need to set it zeros
# before calling this function
function v_cell_wrap!(
    m2v::Vector{Int64},
    shift::Vector{Float64},
    cells,
    region::Vector{Float64},
)
    Ndims = size(shift, 1)
    fill!(shift, 0.0)
    for i in 1:Ndims
        if m2v[i] >= cells[i]
            m2v[i] = 0
            shift[i] = region[i]
        elseif m2v[i] < 0
            m2v[i] = cells[i] - 1
            shift[i] = -region[i]
        end
    end
    return
end


function build_nebr_list!(sim)

    r_cut = sim.r_cut
    r_nebr_shell = sim.inp.r_nebr_shell
    println("r_cut = ", r_cut)
    println("r_nebr_shell = ", r_nebr_shell)

    rrNebr = (r_cut + r_nebr_shell)^2
    println("rrNebr = ", rrNebr)
    
    cells = sim.cells
    region = sim.region
    invWid = cells ./ region
    # or use Δr = region ./ cells
    
    cell_list = sim.cell_list
    atoms = sim.atoms
    Natoms = atoms.Natoms

    # Reset cell_list. We use 0 as the invalid value
    fill!( cell_list, 0)

    rs = [0.0, 0.0]
    cc = [0, 0]

    for ia in 1:Natoms
        # move atom position to "shifted" simulation box
        # Recall that the original center of the box is (0,0)
        rs[1] = atoms.r[1,ia] + 0.5*region[1]
        rs[2] = atoms.r[2,ia] + 0.5*region[2]
        # Get index of the cell (2d)
        cc[1] = floor(Int64, rs[1] * invWid[1])
        cc[2] = floor(Int64, rs[2] * invWid[2])
        # Get the linear index from 2d index
        c = idx_vlinear(cc, cells) + Natoms + 1 # offset by 1
        cell_list[ia] = cell_list[c]
        cell_list[c] = ia
    end

    sim.nebr_tab_len = 0
    shift = [0.0, 0.0]
    m1v = [0, 0]
    m2v = [0, 0]

    dr = [0.0, 0.0] # Float64

    N_OFFSET = 5
    OFFSET_VALS = [
      [0,0], [1,0], [1,1], [0,1], [-1,1]
    ]

    nebr_tab = sim.nebr_tab

    # loop over m1y first
    for m1y in 0:(cells[2]-1), m1x in 0:(cells[1]-1) 
        #
        m1v[1] = m1x
        m1v[2] = m1y
        #
        # get linear index of current cell (offset by Natoms+1)
        m1 = idx_vlinear(m1v, cells) + Natoms + 1
        for offset in 1:N_OFFSET
            #
            m2v[:] .= m1v .+ OFFSET_VALS[offset]
            # OFFSET_VALS is Vector{Vector{Int64}}
            #
            v_cell_wrap!(m2v, shift, cells, region)
            m2 = idx_vlinear(m2v, cells) + Natoms + 1
            #
            j1 = cell_list[m1]
            while j1 > 0
                #
                j2 = cell_list[m2]
                while j2 > 0
                    #
                    if (m1 != m2) || (j2 < j1)
                        dr[1] = atoms.r[1,j1] - atoms.r[1,j2]
                        dr[2] = atoms.r[2,j1] - atoms.r[2,j2]
                        #
                        dr[1] -= shift[1]
                        dr[2] -= shift[2]
                        #
                        dr2 = dr[1]^2 + dr[2]^2
                        if dr2 < rrNebr
                            if sim.nebr_tab_len >= sim.nebr_tab_max
                                error("Too many neighbors, try increase nebr_tab_max")
                            end # if
                            # offset the original index to 1
                            nebr_tab[2*sim.nebr_tab_len+1] = j1
                            nebr_tab[2*sim.nebr_tab_len+1+1] = j2
                            sim.nebr_tab_len += 1
                        end # if
                    end
                    #
                    # Next element
                    j2 = cell_list[j2]
                end
                #
                # Next element
                j1 = cell_list[j1]
            end

        end # for
    end # for

    return

end # function
