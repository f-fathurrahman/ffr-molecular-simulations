# XXX All properties are calculated here.
# XXX I think this is not ideal. Probably we need one method
# XXX for each property
# Maybe something like:
# - eval_property!(p::KineticEnergy, inputs...)
# - eval_property!(p::PotentialEnergy, inputs...)
# - eval_property!(p::Energies, input...)

function eval_props!(
    sim, uSum, virSum
)

    # virSum is calculated in compute_forces!

    atoms = sim.atoms
    tot_energy = sim.tot_ene
    kin_energy = sim.kin_ene
    pressure = sim.pressure
    density = sim.inp.density

    NDIM = size(atoms.r,1)
    vSum = [0.0, 0.0]
    vvSum = 0.0
    Natoms = atoms.Natoms
    
    vvMax = 0.0
    for ia in 1:Natoms
        vSum[1] += atoms.rv[1,ia]
        vSum[2] += atoms.rv[2,ia]
        vv = atoms.rv[1,ia]^2 + atoms.rv[2,ia]^2
        #
        vvSum = vvSum + vv
        #
        vvMax = max(vvMax, vv)
    end
    
    # These properties are normalized (divided by Natoms)
    kin_energy.val = 0.5*vvSum/Natoms
    tot_energy.val = kin_energy.val + uSum/Natoms
    pressure.val = density*( vvSum + virSum ) / (Natoms*NDIM)

    sim.disp_hi += sqrt(vvMax) * sim.inp.Δt
    if sim.disp_hi > 0.5 * sim.inp.r_nebr_shell
        sim.nebr_now = true
    end

    return vSum, vvSum
end

