using GLMakie
using DelimitedFiles
using Statistics: mean

set_theme!(theme_black())

const LJ_UNIT_ENE = 120 * 1.3806e-16 # erg
const erg2eV = 6.242e+11 # 1 erg ≈ 6.242e+11
const LJ_UNIT_TIME = 2.161e-12 # s
const second2femtosecond = 1e15

function do_plot()
    data = readdlm("energies.dat")
    time = data[:,1]*LJ_UNIT_TIME*second2femtosecond
    # total energy is converted to eV
    tot_ene = data[:,2]*LJ_UNIT_ENE*erg2eV
    ref_ene = mean(tot_ene)
    lines(time, tot_ene .- ref_ene,
        figure = (;resolution=(1200,800)),
        axis = (;title="Total energy fluctuations",
            xlabel="Time (fs)", ylabel="Relative energy (eV)")
    )
end

do_plot()