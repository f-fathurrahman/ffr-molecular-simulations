mutable struct Mol
    r::Vector{Float64}
    rv::Vector{Float64}
    ra::Vector{Float64}
end

mutable struct Property
    val::Float64
    s::Float64
    s2::Float64
end

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