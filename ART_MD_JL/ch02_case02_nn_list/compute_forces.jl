function compute_forces!( sim::Simulation )
    
    r_cut = sim.r_cut
    rr_cut = r_cut^2

    atoms = sim.atoms
    fill!(atoms.ra, 0.0)

    dr = [0.0, 0.0]
    uSum = 0.0
    virSum = 0.0
    
    nebr_tab_len = sim.nebr_tab_len
    nebr_tab = sim.nebr_tab
    nebr_tab_len = sim.nebr_tab_len
    region = sim.region

    # FIXME: can be modified for 1-based array
    for n in 0:(nebr_tab_len-1)
        j1 = nebr_tab[2 * n + 1]
        j2 = nebr_tab[2 * n + 1 + 1]
        #
        # Compute difference vector
        dr[1] = atoms.r[1,j1] - atoms.r[1,j2]
        dr[2] = atoms.r[2,j1] - atoms.r[2,j2]
        #
        # Apply PBC
        dr[1] = vwrap( dr[1], region[1] )
        dr[2] = vwrap( dr[2], region[2] )
        #
        rr = dr[1]^2 + dr[2]^2

        if rr < rr_cut
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




# assume unit mass
function compute_forces!(
    atoms::Atoms,
    r_cut::Float64,
    region::Vector{Float64}
)
    rr_cut = r_cut^2
    Natoms = atoms.Natoms
    
    fill!(atoms.ra, 0.0)
    uSum = 0.0
    virSum = 0.0

    dr = zeros(Float64,2)
    
    # This is loop over atom-pairs
    for j1 in 1:(Natoms-1), j2 in (j1+1):Natoms
        #
        # Compute difference vector
        dr[1] = atoms.r[1,j1] - atoms.r[1,j2]
        dr[2] = atoms.r[2,j1] - atoms.r[2,j2]
        #
        # Apply PBC
        dr[1] = vwrap( dr[1], region[1] )
        dr[2] = vwrap( dr[2], region[2] )
        #
        rr = dr[1]^2 + dr[2]^2
        #
        if rr < rr_cut
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
            uSum = uSum + 4.0*rri3*(rri3 - 1.0) + 1.0
            #
            virSum = virSum + fcVal*rr
        end # if rr
    end # j2, j1
    return uSum, virSum
end
# uSum and virSum are needed in eval_props
