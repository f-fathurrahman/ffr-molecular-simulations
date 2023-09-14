function _vrand3!(v)
    x = 0.0
    y = 0.0
    s = 2.0
    while s > 1.0
        x = 2*rand() - 1
        y = 2*rand() - 1
        s = x^2 + y^2
    end
    v[3] = 1.0 - 2*s
    s = 2*sqrt(1 - s)
    v[1] = s * x
    v[2] = s * y
    return
end

function _vrand2!(v)
    s = 2*pi*rand()
    v[1] = cos(s)
    v[2] = sin(s)
    return
end


function init_velocities!(
    atoms::Atoms,
    inp::InputVars,
    velMag::Float64
)

    NDIM = size(atoms.r, 1)
    @assert NDIM >= 2
    @assert NDIM <= 3

    Natoms = atoms.Natoms

    # Random vector generator
    vrand = _vrand2!
    if NDIM == 3
        vrand = _vrand3!
    end

    vSum = zeros(Float64, NDIM)
    for ia in 1:Natoms
        #
        # Generate random vector
        @views vrand(atoms.rv[:,ia])
        #
        # Rescale the velocity
        atoms.rv[:,ia] .*= velMag
        #
        # Accumulate
        @views vSum[:] .+= atoms.rv[:,ia]
    end

    for ia in 1:Natoms
        @views atoms.rv[:,ia] .-= vSum[:]/Natoms
    end

    return
end
