function init_velocities!( mol::Vector{Mol}, input_vars::InputVars, params::Params )
    
    vSum = [0.0, 0.0]
    nMol = length(mol)
    velMag = params.velMag

    for n in 1:nMol
        mol[n].rv[1] = randn()*velMag
        mol[n].rv[2] = randn()*velMag
        vSum[1] = vSum[1] + mol[n].rv[1]
        vSum[2] = vSum[2] + mol[n].rv[2]
    end    
    for n in 1:nMol
        @printf("Before: %18.10f %18.10f\n", mol[n].rv[1], mol[n].rv[2])
        mol[n].rv[1] = mol[n].rv[1] - vSum[1]/nMol
        mol[n].rv[2] = mol[n].rv[2] - vSum[2]/nMol
        @printf("After : %18.10f %18.10f\n", mol[n].rv[1], mol[n].rv[2])
    end
    println("vSum = ", vSum)
    println("vSum = ", vSum/nMol)
    return
end
