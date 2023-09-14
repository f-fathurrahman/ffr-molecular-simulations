# XXX as dictionary?
mutable struct InputVars
    Δt::Float64
    density::Float64
    initUcell::Vector{Int64} # XXX use tuple instead?
    step_avg::Int64
    step_equil::Int64
    step_limit::Int64
    temperature::Int64
end

# Constructor
function InputVars( ;
    Δt = 0.0025,
    density = 0.8,
    initUcell = [20,20],
    step_avg = 100,
    step_equil = 0,
    step_limit = 10000,
    temperature = 1.0
)
    return InputVars(Δt, density, initUcell,
        step_avg, step_equil, step_limit,
        temperature
    )
end


import Base: show
function show(io::IO, inp::InputVars)
    @printf(io, "Δt            = %f\n", inp.Δt)
    @printf(io, "density       = %f\n", inp.density)
    @printf(io, "temperature   = %f\n", inp.temperature)
    @printf(io, "initUcell     = [%d,%d]\n", inp.initUcell[1], inp.initUcell[2])
    @printf(io, "step_avg      = %d\n", inp.step_avg)
    @printf(io, "step_equil    = %d\n", inp.step_equil)
    @printf(io, "step_limit    = %d\n", inp.step_limit)
    return
end