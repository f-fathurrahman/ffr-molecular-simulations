function leapfrog_step!( atoms::Atoms, Δt::Float64, part::Int64 )
    Natoms = atoms.Natoms
    if part == 1
        # update velocities and coordinates
        for ia in 1:Natoms
            # velocities
            atoms.rv[1,ia] = atoms.rv[1,ia] + 0.5*Δt*atoms.ra[1,ia]
            atoms.rv[2,ia] = atoms.rv[2,ia] + 0.5*Δt*atoms.ra[2,ia]
            # positions
            atoms.r[1,ia]  = atoms.r[1,ia] + Δt*atoms.rv[1,ia]
            atoms.r[2,ia]  = atoms.r[2,ia] + Δt*atoms.rv[2,ia]
        end
    else
        # only update velocities
        for ia in 1:Natoms
            atoms.rv[1,ia] = atoms.rv[1,ia] + 0.5*Δt*atoms.ra[1,ia]
            atoms.rv[2,ia] = atoms.rv[2,ia] + 0.5*Δt*atoms.ra[2,ia]
        end
    end
    return
end # function


function leapfrog_step!( mol::Vector{Mol}, Δt::Float64, part::Int64 )
    nMol = length(mol)
    if part == 1
        # update velocities and coordinates
        for n = 1:nMol
            mol[n].rv = mol[n].rv + 0.5*Δt*mol[n].ra
            mol[n].r  = mol[n].r + Δt*mol[n].rv
        end
    else
        # only update velocities
        for n = 1:nMol
            mol[n].rv = mol[n].rv + 0.5*Δt*mol[n].ra
        end
    end
end # function
