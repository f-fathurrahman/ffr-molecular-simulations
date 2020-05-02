function eval_props!(
    atoms::Atoms,
    density, uSum, virSum, totEnergy, kinEnergy, pressure
)
    NDIM = size(atoms.r,1)
    vSum = [0.0, 0.0]
    vvSum = 0.0
    Natoms = atoms.Natoms
    
    for ia in 1:Natoms
        vSum[1] = vSum[1] + atoms.rv[1,ia]
        vSum[2] = vSum[2] + atoms.rv[2,ia]
        #
        vv = atoms.rv[1,ia]^2 + atoms.rv[2,ia]^2
        #
        vvSum = vvSum + vv
    end
    
    # These properties are normalized (divided by Natoms)
    kinEnergy.val = 0.5*vvSum/Natoms
    totEnergy.val = kinEnergy.val + uSum/Natoms
    pressure.val = density*( vvSum + virSum ) / (Natoms*NDIM)

    #println("")
    #println("vSum = ", vSum)
    #println("vvSum = ", vvSum)
    
    return vSum, vvSum
end


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
