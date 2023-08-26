mutable struct Atoms
    Natoms::Int64
    r::Array{Float64,2}
    rv::Array{Float64,2}
    ra::Array{Float64,2}
end

function Atoms( Natoms::Int64, NDIM::Int64 )
    r = zeros(Float64,NDIM,Natoms)
    rv = zeros(Float64,NDIM,Natoms)
    ra = zeros(Float64,NDIM,Natoms)
    return Atoms(Natoms, r, rv, ra)
end

import Base: length
function length( atoms::Atoms )
    return atoms.Natoms
end

function print_xyz( atoms::Atoms, filename::String, mode::String, LJ2ANG )
    filxyz = open(filename, mode)
    Natoms = atoms.Natoms
    @printf( filxyz, "%d\n\n", Natoms )
    for ia in 1:Natoms
        @printf( filxyz, "Ar %18.10f %18.10f %18.10f %18.10f %18.10f %18.10f\n",
                 atoms.r[1,ia]*LJ2ANG, atoms.r[2,ia]*LJ2ANG, 0.0,
                 atoms.rv[1,ia], atoms.rv[2,ia], 0.0 )
    end
    close(filxyz)
    return
end # function

function print_xyz(atoms::Atoms)
    print_xyz(atoms, "TRAJ_ATOMS.xyz", "w", 3.4)
    return
end
