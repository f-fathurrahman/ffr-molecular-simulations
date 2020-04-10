function PropZero!( prop::Prop )
  prop.val = 0.0
  prop.sum = 0.0
  prop.sum2 = 0.0
end

function PropAccum!( prop::Prop )
  prop.sum = prop.sum + prop.val
  prop.sum2 = prop.sum2 + prop.val^2
end

function PropAvg!( prop::Prop, n::Int64 )
  prop.sum = prop.sum / n
  prop.sum2 = sqrt( max( prop.sum2/n - prop.sum^2, 0.0 ) )
end

function AccumProps( icode::Int64 )
  if icode == 0
    PropZero!( totEnergy )
    PropZero!( kinEnergy )
    PropZero!( pressure )
  elseif icode == 1
    PropAccum!( totEnergy )
    PropAccum!( kinEnergy )
    PropAccum!( pressure )
  elseif icode == 2
    PropAvg!( totEnergy, stepAvg )
    PropAvg!( kinEnergy, stepAvg )
    PropAvg!( pressure, stepAvg )
  end
end
