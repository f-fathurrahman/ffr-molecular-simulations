function LeapfrogStep( part::Int64, mol )
  if part == 1
    # update velocities and coordinates
    for n = 1:nMol
      mol[n].rv = mol[n].rv + 0.5*deltaT*mol[n].ra
      mol[n].r  = mol[n].r + deltaT*mol[n].rv
    end
  else
    # only update velocities
    for n = 1:nMol
      mol[n].rv = mol[n].rv + 0.5*deltaT*mol[n].ra
    end
  end
end # function
