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