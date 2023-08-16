function init_velocities!( atoms::Atoms, input_vars::InputVars, params::Params )
    
    vSum = [0.0, 0.0]
    Natoms = atoms.Natoms
    velMag = params.velMag

    for ia in 1:Natoms
        s = 2*pi*rand()
        atoms.rv[1,ia] = cos(s)*velMag
        atoms.rv[2,ia] = sin(s)*velMag
        vSum[1] = vSum[1] + atoms.rv[1,ia]
        vSum[2] = vSum[2] + atoms.rv[2,ia]
    end

    for ia in 1:Natoms
        atoms.rv[1,ia] = atoms.rv[1,ia] - vSum[1]/Natoms
        atoms.rv[2,ia] = atoms.rv[2,ia] - vSum[2]/Natoms
    end

    return
end


function init_velocities!( mol::Vector{Mol}, input_vars::InputVars, params::Params )
    
    vSum = [0.0, 0.0]
    nMol = length(mol)
    velMag = params.velMag

    for n in 1:nMol
        s = 2*pi*rand()
        mol[n].rv[1] = cos(s)*velMag
        mol[n].rv[2] = sin(s)*velMag
        vSum[1] = vSum[1] + mol[n].rv[1]
        vSum[2] = vSum[2] + mol[n].rv[2]
    end    
    for n in 1:nMol
        mol[n].rv[1] = mol[n].rv[1] - vSum[1]/nMol
        mol[n].rv[2] = mol[n].rv[2] - vSum[2]/nMol
    end
    return
end
