mutable struct Mol
    r::MVector{2,Float64}
    rv::MVector{2,Float64}
    ra::MVector{2,Float64}
end

mutable struct Property
    val::Float64 # current value
    s::Float64 # sum
    s2::Float64 # variance
end
# XXX add name or symbol for Property?
# Or name Property as abstract type?
# eval_property can be dispatched according to concrete types


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