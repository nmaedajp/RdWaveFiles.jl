function rdjumult(wvdir, obs, pnt; coef=1.2310680e-07, rm_offset=1)
# -------------------------------------------------------------------------
# read wave data for observation with multi sensors; eg array observation.
# -------------------------------------------------------------------------
# wvdir : base directory of wavedata     *
# obs   : obsservation site name String  *
# pnt   : point name for an observation  *
    npnt = length(pnt)
    nfl = Array{Int64}(undef, npnt)
# count files in a point directory 
    for ipnt =1:npnt
        fldir = joinpath(wvdir, obs, pnt[ipnt])
        wvfl = flnmck(readdir(fldir))
#        println(wvfl)
        nfl[ipnt] = length(wvfl)
    end
# println(nfl)
# check for no. of files in a point directory 
    for ipnt = 2:npnt
        if nfl[ipnt] != nfl[1]
            error("No. of files in points is different each other at \""*obs*"\". Please check!")
        end
    end
    nfl0 = nfl[1]
# temporary file for each wave data
    wave=Array{NamedTuple{(:headtime, :nwave, :hz, :nch, :chid, :wave), 
               Tuple{Vector{Int64}, Int64, Int64, Int64, Vector{String}, Matrix{Int64}}}}(undef,nfl0,npnt);
# read wave data
    for ipnt =1:npnt
        for ifl = 1:nfl0
            fldir = joinpath(wvdir, obs, pnt[ipnt])
            wvfl = flnmck(readdir(fldir))
            flnm2=joinpath(fldir,wvfl[ifl])
            data = read(flnm2);
            wave[ifl,ipnt] = rdwin1_ch(data)
#         println("file name = ", pnt[ipnt],"/",wvfl[ifl],", head time = ",
#            wave.headtime, ", hz = ",wave.hz, ", (nwave,nch) = ",(wave.nwave,wave.nch), 
#            ", chid", wave.chid)
        end
    end
# check for CH id among files
    for ipnt = 1:npnt
        for ifl = 2:nfl0
            if wave[ifl,ipnt].chid != wave[1,ipnt].chid
                println(wave[ifl,ipnt].chid,wave[1,ipnt].chid)
                error("ch ID are different each other at \""*obs*"/"*pnt[ipnt]*"\". Please check!")
            end    
        end
    end
# check for head time among points
    for ifl = 1:nfl0
        for ipnt = 2:npnt
            if wave[ifl,ipnt].headtime != wave[ifl,1].headtime
               println((ifl,ipnt,wave[ifl,ipnt].headtime, wave[ifl,1].headtime))
               error("head time is different among points at \""*obs*"/"*pnt[ipnt]*"\". Please check!")
            end    
        end
    end
# check for hz among points and files
    for ifl = 1:nfl0
        for ipnt = 1:npnt
            if wave[ifl,ipnt].hz != wave[1,1].hz
                println((ifl,ipnt,wave[ifl,ipnt].hz, wave[1,1].hz))
                error("sampling rate is different among points and files at \""*obs*"/"*pnt[ipnt]*"\". Please check!")
            end    
        end
    end
# check for nwave among points and files
    for ifl = 1:nfl0
        for ipnt = 1:npnt
            if wave[ifl,ipnt].nwave != wave[1,1].nwave
                println((ifl,ipnt,wave[ifl,ipnt].nwave, wave[1,1].nwave))
                error("no of wavedata is different among points and files at \""*obs*"/"*pnt[ipnt]*"\". Please check!")
            end    
        end
    end
# set waveF information
    headtime = wave[1,1].headtime
    nwave = wave[1,1].nwave * nfl0
    hz = wave[1,1].hz
    chid = wave[1,1].chid
    for ipnt = 2:npnt
        chid = vcat(chid, wave[1,ipnt].chid)
    end
    nch = wave[1,1].nch * npnt
# set waveF data
    waveF = Array{Float64}(undef,nwave,nch)
    for ipnt =1:npnt
        wave_pnt = Float64.(wave[1,ipnt].wave)
        for ifl = 2:nfl0
            wave_pnt = vcat(wave_pnt,Float64.(wave[ifl,ipnt].wave))
        end
#         println("obs name = ", pnt[ipnt],", head time = ",
#            wave[ifl,ipnt].headtime, ", hz = ",
#            wave[ifl,ipnt].hz, ", (nwave,nch) = ",(wave[ifl,ipnt].nwave,wave[ifl,ipnt].nch), 
#            ", chid", wave[ifl,ipnt].chid
#         )
        icol1 = (ipnt-1) * wave[1,1].nch+1
        icol2 =  ipnt    * wave[1,1].nch
        waveF[:,icol1:icol2] = wave_pnt[:]
    end
    waveF = waveF * coef
    if rm_offset >0
        for ich=1:nch
            waveF[1:nwave,ich] = waveF[1:nwave,ich] .- sum(waveF[1:nwave,ich])/nwave
        end
    end
# println(headtime)
# println(nwave)
# println(hz)
# println(chid)
# println(nch)
# print_matrix_i("temp.txt",wave[1,1].wave)
# print_matrix("temp2.txt",waveF)
    t = [(iwave-1)/hz for iwave=1:nwave];
    return Wavedata(obs, headtime, nwave, nch, hz, t, chid, waveF)
#    return (; obs, headtime, nwave, nch, hz, t, chid, waveF)
end