function SingleStep(mol)
    global stepCount, timeNow
    stepCount = stepCount + 1
    timeNow = stepCount*deltaT
    #
    LeapfrogStep(1,mol)
    ApplyBoundaryCond()
    ComputeForces(mol)
    LeapfrogStep(2,mol)
    #
    EvalProps()
    AccumProps(1)
    #
    if stepCount % stepAvg == 0
        AccumProps(2)
        #PrintSummary()
        AccumProps(0)
    end
end
