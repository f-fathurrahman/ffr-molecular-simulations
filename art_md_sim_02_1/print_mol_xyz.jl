function print_mol_xyz( mol::Array{Mol}, filename::String, mode::String, LJ2ANG )
    filxyz = open( filename, mode )
    Natoms = length( mol )
    @printf( filxyz, "%d\n\n", Natoms )
    for ia in 1:Natoms
        @printf( filxyz, "Ar %18.10f %18.10f %18.10f %18.10f %18.10f %18.10f\n",
                 mol[ia].r[1]*LJ2ANG, mol[ia].r[2]*LJ2ANG, 0.0,
                 mol[ia].rv[1], mol[ia].rv[2], 0.0 )
    end
    close( filxyz )
end # function
