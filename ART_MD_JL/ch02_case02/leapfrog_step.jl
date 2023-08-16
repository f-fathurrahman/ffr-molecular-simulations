function leapfrog_step!(
    atoms::Atoms,
    Δt::Float64;
    update_vel_only=false
)
    Natoms = atoms.Natoms

    for ia in 1:Natoms
        atoms.rv[1,ia] += 0.5*Δt*atoms.ra[1,ia]
        atoms.rv[2,ia] += 0.5*Δt*atoms.ra[2,ia]
    end
    
    if update_vel_only
        return
    end
   
    # positions
    for ia in 1:Natoms
        atoms.r[1,ia] += Δt*atoms.rv[1,ia]
        atoms.r[2,ia] += Δt*atoms.rv[2,ia]
    end
    return
end
