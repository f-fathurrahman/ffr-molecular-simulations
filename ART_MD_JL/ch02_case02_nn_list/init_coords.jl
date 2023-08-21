function init_coords!(
    atoms::Atoms,
    inp::InputVars,
    region
)
    initUcell = inp.initUcell
    gap = region ./ initUcell
    c = [0.0, 0.0]
    ia = 0
    for ny in 0:initUcell[2] - 1
        for nx in 0:initUcell[1] - 1
            ia = ia + 1
            c[1] = (nx + 0.5)*gap[1]
            c[2] = (ny + 0.5)*gap[2]
            # Set positions
            atoms.r[1,ia] = c[1] - 0.5*region[1]
            atoms.r[2,ia] = c[2] - 0.5*region[2]
        end
    end
    return
end
