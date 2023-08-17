# XXX All properties are calculated here.
# XXX I think this is not ideal. Probably we need one method
# XXX for each property
# Maybe something like:
# - eval_property!(p::KineticEnergy, inputs...)
# - eval_property!(p::PotentialEnergy, inputs...)
# - eval_property!(p::Energies, input...)

function eval_props!(
    atoms::Atoms,
    density, uSum, virSum, totEnergy, kinEnergy, pressure
)
    # virSum is calculated in compute_forces!


    NDIM = size(atoms.r,1)
    vSum = [0.0, 0.0]
    vvSum = 0.0
    Natoms = atoms.Natoms
    
    for ia in 1:Natoms
        vSum[1] += atoms.rv[1,ia]
        vSum[2] += atoms.rv[2,ia]
        #
        vv = atoms.rv[1,ia]^2 + atoms.rv[2,ia]^2
        #
        vvSum = vvSum + vv
    end
    
    # These properties are normalized (divided by Natoms)
    kinEnergy.val = 0.5*vvSum/Natoms
    totEnergy.val = kinEnergy.val + uSum/Natoms
    pressure.val = density*( vvSum + virSum ) / (Natoms*NDIM)
    
    return vSum, vvSum
end

