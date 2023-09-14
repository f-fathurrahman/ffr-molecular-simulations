# assume unit mass
function compute_forces!(
    atoms::Atoms,
    rCut::Float64,
    region::Vector{Float64}
)
    NDIM = size(atoms.r, 1)

    rrCut = rCut^2
    Natoms = atoms.Natoms
    
    fill!(atoms.ra, 0.0)
    uSum = 0.0
    virSum = 0.0

    dr = zeros(Float64,NDIM)
    
    # This is loop over atom-pairs
    for j1 in 1:(Natoms-1), j2 in (j1+1):Natoms
        #
        # Compute difference vector
        dr[:] .= atoms.r[:,j1] - atoms.r[:,j2]
        #
        # Apply PBC
        for i in 1:NDIM
            dr[i] = vwrap( dr[i], region[i] )
        end
        #
        rr = sum(dr[:].^2)
        #
        if rr < rrCut
            rri = 1.0/rr # rri is dr^{-2}
            rri3 = rri^3 # rri3 is dr^{-6}
            fcVal = 48.0 * rri3 * ( rri3 - 0.5 ) * rri
            # fcVal = 48 * (dr^{-14} - 0.5*dr^{-8})
            #
            # 1st particle, unit mass, positive sign
            @views atoms.ra[:,j1] .+= fcVal*dr[:]
            #
            # 2nd particle, unit mass, negative sign
            @views atoms.ra[:,j2] .-= fcVal*dr[:]
            #
            uSum += 4.0*rri3*(rri3 - 1.0) + 1.0
            #
            virSum += fcVal*rr
        end # if rr
    end # j2, j1
    return uSum, virSum
end
# uSum and virSum are needed in eval_props
