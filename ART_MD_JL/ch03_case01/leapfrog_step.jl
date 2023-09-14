function leapfrog_step!(
    atoms::Atoms,
    Δt::Float64;
    update_vel_only=false
)
    Natoms = atoms.Natoms

    for ia in 1:Natoms
        @views atoms.rv[:,ia] .+= 0.5*Δt*atoms.ra[:,ia]
    end
    
    if update_vel_only
        return
    end
   
    # positions
    for ia in 1:Natoms
        @views atoms.r[:,ia] .+= Δt*atoms.rv[:,ia]
    end
    return
end
