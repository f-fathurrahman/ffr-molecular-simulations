"""
Initializes accelaration on mols
In this special case, it is not really needed because this task
has been done in InitCoords
"""
function init_accelarations!( mol::Vector{Mol} )
    
    nMol = length(mol)

    for n in 1:nMol
        mol[n].ra[1] = 0.0
        mol[n].ra[2] = 0.0
    end

    return
end
