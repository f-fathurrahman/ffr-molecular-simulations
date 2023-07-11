# wrap to [ -Lregion/2, +Lregion/2 ]
function vwrap( v::Float64, Lregion::Float64 )
    vout = v
    if v >= 0.5*Lregion
        vout = v - Lregion
    elseif v < -0.5*Lregion
        vout = v + Lregion
    end
    return vout
end

function vwrap_all!( v::AbstractVector, region::AbstractVector )
    v[1] = vwrap( v[1], region[1] )
    v[2] = vwrap( v[2], region[2] )
    return
end


function apply_boundary_cond!( atoms::Atoms, region::Vector{Float64})
    Natoms = atoms.Natoms
    for ia in 1:Natoms
        atoms.r[1,ia] = vwrap( atoms.r[1,ia], region[1] )
        atoms.r[2,ia] = vwrap( atoms.r[2,ia], region[2] )
    end
    return
end


function apply_boundary_cond!( mol::Vector{Mol}, region::Vector{Float64})
    nMol = length(mol)
    for n in 1:nMol
        vwrap_all!( mol[n].r, region )
    end
    return
end
