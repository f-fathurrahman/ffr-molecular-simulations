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
