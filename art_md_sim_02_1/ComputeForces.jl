# assume unit mass
function ComputeForces(mol)
  rrCut = rCut^2
  #
  for n = 1:nMol
    mol[n].ra = Vec2d(0.0,0.0)
  end
  #
  global uSum = 0.0
  global virSum = 0.0
  #
  for j1 = 1:nMol-1
    for j2 = j1+1:nMol
      dr = mol[j1].r - mol[j2].r
      VWrapAll!( dr, region )
      rr = dr.x^2 + dr.y^2
      if rr < rrCut
        rri = 1.0/rr
        rri3 = rri^3
        fcVal = 48.0 * rri3 * ( rri3 - 0.5 ) * rri
        # 1st particle, unit mass
        mol[j1].ra = mol[j1].ra + fcVal*dr
        # 2nd particle, unit masss
        mol[j2].ra = mol[j2].ra - fcVal*dr
        #
        uSum = uSum + 4.0*rri3*(rri3 - 1.0) + 1.0
        #
        virSum = virSum + fcVal*rr
      end # if rr
    end # for j2
  end # for j1
end
