function build_nebr_list!()

    #VecR dr, invWid, rs, shift;
    #VecI cc, m1v, m2v, vOff[] = OFFSET_VALS;
    #real rrNebr;
    #int c, j1, j2, m1, m1x, m1y, m2, n, offset;

    dr = [0.0, 0.0] # Float64
    cc = [0, 0] # Int64

    N_OFFSET = 5
    OFFSET_VALS = [
      [0,0], [1,0], [1,1], [0,1], [-1,1]
    ]

    rrNebr = (rCut + r_nebr_shell)^2
    
    invWid = cells ./ region
    
    #for(n = nMol; n < nMol + VProd (cells); n ++) cellList[n] = -1;
    fill!( cell_list, -1)

    for ia in 1:Natoms
        # VSAdd(rs, mol[n].r, 0.5, region);
        rs[1] = atoms.r[1,ia] + 0.5*region[1]
        rs[2] = atoms.r[2,ia] + 0.5*region[2]
        # VMul(cc, rs, invWid);
        cc[1] = rs[1] * invWid[1]
        cc[2] = rs[2] * invWid[2]
        # c = VLinear (cc, cells) + nMol;
        # VLinear(p, s) # convert to "linear" index
        # ((p).z * (s).y + (p).y) * (s).x + (p).x
        c = cc[2]* cells[1] + cc[1]
        cell_list[ia] = cellList[c]
        cell_list[c] = ia
    end

    nebr_tab_len = 0
    #for (m1y = 0; m1y < cells.y; m1y ++) {
    #for (m1x = 0; m1x < cells.x; m1x ++) {
    for m1y in 0:(cells[2]-1), m1x in 0:(cells[1]-1) 
        VSet (m1v, m1x, m1y);
        m1v[1] = m1x
        m1v[2] = m1y
        m1 = VLinear(m1v, cells) + nMol;
        for (offset = 0; offset < N_OFFSET; offset ++) {
            VAdd (m2v, m1v, vOff[offset]);
            VZero (shift);
            VCellWrapAll ();
            m2 = VLinear (m2v, cells) + nMol;
            DO_CELL (j1, m1) {
                DO_CELL (j2, m2) {
                    if (m1 != m2 || j2 < j1) {
                        VSub (dr, mol[j1].r, mol[j2].r);
                        VVSub (dr, shift);
                        if (VLenSq (dr) < rrNebr) {
                            if (nebrTabLen >= nebrTabMax)
                                ErrExit (ERR_TOO_MANY_NEBRS);
                            end
                            nebrTab[2 * nebrTabLen] = j1;
                            nebrTab[2 * nebrTabLen + 1] = j2;
                            ++ nebrTabLen;
                        end # if
                    end # if
                end # for
            end # for
        end # for
    end # for

end # function
