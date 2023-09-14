function init_coords!(
    atoms::Atoms,
    inp::InputVars,
    region
)
    NDIM = size(atoms.r, 1)

    initUcell = inp.initUcell
    gap = region ./ initUcell
    c = zeros(Float64, NDIM)

    # FIXME: this is for NDIM=3 only
    @assert NDIM == 3

    # FIXME: There are more compact ways to do this
    ia = 0
    for nz in 0:(initUcell[3]-1), ny in 0:(initUcell[2]-1), nx in 0:(initUcell[1]-1)
        ia = ia + 1
        c[1] = (nx + 0.5)*gap[1]
        c[2] = (ny + 0.5)*gap[2]
        c[3] = (nz + 0.5)*gap[3]
        # Set positions
        @views atoms.r[:,ia] .= c[:] - 0.5*region[:]
    end
    return
end
