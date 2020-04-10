function PrintMolXYZ( mol::Array{Mol},
      filename::AbstractString, mode::AbstractString )
  filxyz = open( filename, mode )
  Natoms = length( mol )
  @printf( filxyz, "%d\n\n", Natoms )
  for ia = 1:Natoms
    @printf( filxyz, "Ar %f %f %f %f %f %f\n",
             mol[ia].r.x*LJ2ANG, mol[ia].r.y*LJ2ANG, 0.0,
             mol[ia].rv.x*LJ2ANG, mol[ia].rv.y*LJ2ANG, 0.0 )
  end # for
  close( filxyz )
end # function
