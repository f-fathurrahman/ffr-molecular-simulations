using GLMakie
using DelimitedFiles

set_theme!(theme_black())

function do_plot()
    data = readdlm("energies.dat")
    f = Figure()
    ax = Axis(f[1,1])
    lines!(ax, data[:,1], data[:,2])
    f
end

do_plot()