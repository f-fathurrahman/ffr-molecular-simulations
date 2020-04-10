"""
Initializes accelaration on mols
In this special case, it is not really needed because this task
has been done in InitCoords
"""
function InitAccels()
  for n=1:nMol
    mol[n].ra = VecR(0.0,0.0)
  end
end
