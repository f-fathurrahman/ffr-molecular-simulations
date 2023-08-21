mutable struct Atoms
    Natoms::Int64
    r::Array{Float64,2}
    rv::Array{Float64,2}
    ra::Array{Float64,2}
end

function Atoms( Natoms::Int64, NDIM::Int64 )
    r = zeros(Float64,NDIM,Natoms)
    rv = zeros(Float64,NDIM,Natoms)
    ra = zeros(Float64,NDIM,Natoms)
    return Atoms(Natoms, r, rv, ra)
end

import Base: length
function length( atoms::Atoms )
    return atoms.Natoms
end