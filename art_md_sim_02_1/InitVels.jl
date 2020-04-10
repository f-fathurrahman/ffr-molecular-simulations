function init_velocities!( input_vars, param, mol )
    vSum = [0.0, 0.0]
    nMol = mol.nMol

    for n in 1:nMol
        vx = randn()
        vy = randn()
        mol[n].rv[:] = [vx, vy]*velMag
        vSum[:] = vSum[:] + mol[n].rv
    end
    
    for n in 1:nMol
        mol[n].rv[:] = mol[n].rv[:] - vSum/nMol
    end

    return
end
