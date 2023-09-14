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
    NDIM = size(v, 1)
    for i in 1:NDIM
        v[i] = vwrap( v[i], region[i] )
    end
    return
end


function apply_boundary_cond!( atoms::Atoms, region::Vector{Float64})
    Natoms = atoms.Natoms
    NDIM = size(atoms.r, 1)
    for ia in 1:Natoms
        for i in 1:NDIM
            atoms.r[i,ia] = vwrap( atoms.r[i,ia], region[i] )
        end
    end
    return
end
