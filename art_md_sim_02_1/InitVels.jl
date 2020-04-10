"""
Initializes velocities
Modifies mol
Return vSum (a global variable)
"""
function InitVels()
  global vSum = VecR(0.0,0.0)
  for n = 1:nMol
    vx = randn()
    vy = randn()
    mol[n].rv = VecR(vx,vy)*velMag
    vSum = vSum + mol[n].rv
  end
  for n = 1:nMol
    mol[n].rv = mol[n].rv - vSum/nMol
  end
end
