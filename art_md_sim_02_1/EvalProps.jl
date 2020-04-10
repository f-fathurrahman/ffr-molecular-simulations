function EvalProps()
  global vSum = Vec2d(0.0,0.0)
  global vvSum = 0.0
  global totEnergy, kinEnergy, pressure
  for n = 1:nMol
    vSum = vSum + mol[n].rv
    vv = mol[n].rv.x^2 + mol[n].rv.y^2
    vvSum = vvSum + vv
  end
  # These properties are normalized (divided by nMol)
  kinEnergy.val = 0.5*vvSum/nMol
  totEnergy.val = kinEnergy.val + uSum/nMol
  pressure.val = density*( vvSum + virSum ) / (nMol*NDIM)
end
