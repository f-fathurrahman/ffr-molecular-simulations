function init_velocities!(
    atoms::Atoms,
    inp::InputVars,
    velMag::Float64
)
    
    vSum = [0.0, 0.0]
    Natoms = atoms.Natoms
    for ia in 1:Natoms
        s = 2*pi*rand()
        atoms.rv[1,ia] = cos(s)*velMag
        atoms.rv[2,ia] = sin(s)*velMag
        vSum[1] += atoms.rv[1,ia]
        vSum[2] += atoms.rv[2,ia]
    end

    for ia in 1:Natoms
        atoms.rv[1,ia] -= vSum[1]/Natoms
        atoms.rv[2,ia] -= vSum[2]/Natoms
    end

    return
end
