function eval_vel_distrib!()
    # real deltaV, histSum
    # int j, n;

    # histVel: array
    histVel[1:sizeHistVel] .= 0.0
    
    Δv = rangeVel / sizeHistVel # rangeVel is input
    for ia in 1:Natoms
        vlen = sqrt(atoms[ia].rv[1]^2 + atoms[ia].rv[2]^2)
        j = floor(Int64, vlen / Δv) + 1 # offset by 1 ?
        # because j is using 0-based array
        idx_update = min(j, sizeHistVel)
        histVel[idx_update] += 1
        # increment count of histVel, min of sizeHistVel-1 (size of histVel) or index j
    end
    countVel += 1 # increment countVel
    
    # limitVel is input
    if countVel == limitVel
        histSum = sum(histVel)
        histVel[:] *= (1/histSum) # scale
        hFunction = 0.0
        for j in 1:sizeHistVel
            if histVel[j] > 0
                hFunction =+ histVel[j] * log( histVel[j / ( (j + 0.5)*Δv) )
                # FIXME: check the denumerator: it should be v_{n}^{d-1}
                # For 2d, d = 2, so it should be v_{n}
            end
        end
        #PrintVelDist(veldist_file);
        # Print out the result here
        # Reset countVel
        countVel = 0
    end

    return
end
