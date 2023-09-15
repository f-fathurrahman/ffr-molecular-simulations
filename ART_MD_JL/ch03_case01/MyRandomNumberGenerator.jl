mutable struct MyRandomGenerator
    randSeedP::Int32
end


function MyRandomGenerator(;seed=Int32(17))
    return MyRandomGenerator(seed)
end


#=
function InitRand (int randSeedI)
{
  struct timeval tv;

  if (randSeedI != 0) randSeedP = randSeedI;
  else {
    gettimeofday (&tv, 0);
    randSeedP = tv.tv_usec;
  }
}
=#

function rand_r!(rnd::MyRandomGenerator)
    IADD = Int32(453806245)
    IMUL = Int32(314159269)
    MASK = Int32(2147483647)
    SCALE = 0.4656612873e-9

    rnd.randSeedP = (rnd.randSeedP * IMUL + IADD) & MASK
    return rnd.randSeedP * SCALE
end