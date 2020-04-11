# assume unit mass
function compute_forces!( mol::Vector{Mol}, rCut::Float64, region::Vector{Float64} )
    rrCut = rCut^2
    
    nMol = length(mol)
    for n = 1:nMol
        mol[n].ra[1] = 0.0
        mol[n].ra[2] = 0.0
    end
    #
    uSum = 0.0
    virSum = 0.0
    #
    for j1 in 1:nMol-1, j2 in j1+1:nMol
        #
        dr = mol[j1].r - mol[j2].r
        #
        vwrap_all!( dr, region )
        #
        rr = dr[1]^2 + dr[2]^2
        #
        if rr < rrCut
            rri = 1.0/rr
            rri3 = rri^3
            fcVal = 48.0 * rri3 * ( rri3 - 0.5 ) * rri
            # 1st particle, unit mass
            mol[j1].ra = mol[j1].ra + fcVal*dr
            # 2nd particle, unit masss
            mol[j2].ra = mol[j2].ra - fcVal*dr
            #
            uSum = uSum + 4.0*rri3*(rri3 - 1.0) + 1.0
            #
            virSum = virSum + fcVal*rr
        end # if rr
    end # j2, j1
    return uSum, virSum
end
