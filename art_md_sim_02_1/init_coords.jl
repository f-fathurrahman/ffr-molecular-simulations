"""
Initializes a Mol object with certain coordinates, zeros velocities and
accelaration.
"""
function init_coords(input_vars, params)
    region = params.region
    initUcell = input_vars.initUcell
    nMol = params.nMol

    gap = region ./ initUcell
    
    mol = Vector{Mol}(undef,nMol)
    #
    c  = [0.0, 0.0]
    #
    n = 1
    for ny in 0:initUcell[2] - 1
        for nx in 0:initUcell[1] - 1
            c[1] = nx + 0.5
            c[2] = ny + 0.5
            c = gap .* c
            r = c - 0.5*region # position
            mol[n] = Mol(r, [0.0, 0.0], [0.0, 0.0])
            n = n + 1
        end
    end

    return mol
end
