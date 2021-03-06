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

function vwrap_all!( v::Vector{Float64}, region::Vector{Float64} )
    v[1] = vwrap( v[1], region[1] )
    v[2] = vwrap( v[2], region[2] )
    return
end


function apply_boundary_cond!( mol::Vector{Mol}, region::Vector{Float64})
    nMol = length(mol)
    for n = 1:nMol
        vwrap_all!( mol[n].r, region )
    end
    return
end
