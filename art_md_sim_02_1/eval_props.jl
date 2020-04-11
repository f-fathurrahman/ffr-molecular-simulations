function eval_props!(
    mol::Vector{Mol},
    density, uSum, virSum, totEnergy, kinEnergy, pressure
)
    NDIM = 2 # HARDCODED
    vSum = [0.0, 0.0]
    vvSum = 0.0
    nMol = length(mol)
    for n = 1:nMol
        vSum = vSum + mol[n].rv
        vv = mol[n].rv[1]^2 + mol[n].rv[2]^2
        vvSum = vvSum + vv
    end
    # These properties are normalized (divided by nMol)
    kinEnergy.val = 0.5*vvSum/nMol
    totEnergy.val = kinEnergy.val + uSum/nMol
    pressure.val = density*( vvSum + virSum ) / (nMol*NDIM)
    return vSum, vvSum
end
