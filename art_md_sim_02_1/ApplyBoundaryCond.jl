function ApplyBoundaryCond()
  for n = 1:nMol
    VWrapAll!( mol[n].r, region )
  end
end # function
