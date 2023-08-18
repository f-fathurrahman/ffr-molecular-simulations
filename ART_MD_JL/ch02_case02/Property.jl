mutable struct Property
    val::Float64 # current value
    s::Float64 # sum
    s2::Float64 # variance
end

function prop_zero!( prop::Property )
    prop.val = 0.0
    prop.s = 0.0
    prop.s2 = 0.0
    return
end

function prop_accum!( prop::Property )
    prop.s = prop.s + prop.val
    prop.s2 = prop.s2 + prop.val^2
    return
end

function prop_avg!( prop::Property, n::Int64 )
    prop.s = prop.s / n
    prop.s2 = sqrt( max( prop.s2/n - prop.s^2, 0.0 ) )
end

function do_props_accum!( icode::Int64, stepAvg::Int64, totEnergy, kinEnergy, pressure )
    if icode == 0
        prop_zero!( totEnergy )
        prop_zero!( kinEnergy )
        prop_zero!( pressure )
    elseif icode == 1
        prop_accum!( totEnergy )
        prop_accum!( kinEnergy )
        prop_accum!( pressure )
    elseif icode == 2
        prop_avg!( totEnergy, stepAvg )
        prop_avg!( kinEnergy, stepAvg )
        prop_avg!( pressure, stepAvg )
    end
    return
end
