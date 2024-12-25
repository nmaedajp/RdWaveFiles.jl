function rdjusngl(wvdir, obs ; coef=1.2310680e-07, rm_offset=1)
    # -------------------------------------------------------------------------
    # read wave data for observation with a single sensors.
    # -------------------------------------------------------------------------
    # wvdir : base directory of wavedata     *
    # obs   : obsservation site name String  *
    #
    # count files in a obs directory 
        fldir = joinpath(wvdir, obs)
        wvfl = flnmck(readdir(fldir))
        nfl0 = length(wvfl)
    #
    # temporary file for each wave data
        wave=Array{NamedTuple{(:headtime, :nwave, :hz, :nch, :chid, :wave), 
                Tuple{Vector{Int64}, Int64, Int64, Int64, Vector{String}, Matrix{Int64}}}}(undef,nfl0);
    #
    # read wave data
        for ifl = 1:nfl0
            fldir = joinpath(wvdir, obs)
            wvfl  = flnmck(readdir(fldir))
            flnm2 = joinpath(fldir, wvfl[ifl])
            data  = read(flnm2);
            wave[ifl] = rdwin1_ch(data)
    #         println("file name = ", pnt[ipnt],"/",wvfl[ifl],", head time = ",
    #            wave.headtime, ", hz = ",wave.hz, ", (nwave,nch) = ",(wave.nwave,wave.nch), 
    #            ", chid", wave.chid)
        end
    #
    # check for CH id among files
        for ifl = 2:nfl0
            if wave[ifl].chid != wave[1].chid
                println(wave[ifl].chid, wave[ifl].chid)
                error("ch ID are different each other at \""*obs*"/"*"\". Please check!")
            end    
        end
    # check for head time among points -> this check is for multi sensors.
    #   for ifl = 1:nfl0
    #      for ipnt = 2:npnt
    #         if wave[ifl,ipnt].headtime != wave[ifl,1].headtime
    #           println((ifl,ipnt,wave[ifl,ipnt].headtime, wave[ifl,1].headtime))
    #           error("head time is different among points at \""*obs*"/"*pnt[ipnt]*"\". Please check!")
    #         end    
    #      end
    #   end
    # check for hz among files
        for ifl = 2:nfl0
            if wave[ifl].hz != wave[1].hz
                println((ifl, wave[ifl].hz, wave[1].hz))
                error("sampling rate is different among points and files at \""*obs*"/"*"\". Please check!")
            end    
        end
    # check for nwave among files
    #    for ifl = 1:nfl0
    #        if wave[ifl].nwave != wave[1].nwave
    #            println((ifl, wave[ifl].nwave, wave[1].nwave))
    #            error("no of wavedata is different among points and files at \""*obs*"/"*"\". Please check!")
    #        end    
    #    end
    # set waveF information
        headtime = wave[1].headtime
        hz = wave[1].hz
        chid = wave[1].chid
        nch = wave[1].nch
    # set waveF data
        wave_pnt = Float64.(wave[1].wave)
        for ifl = 2:nfl0
            wave_pnt = vcat(wave_pnt, Float64.(wave[ifl].wave))
        end
        nwave, nch1 = size(wave_pnt)
    #         println("obs name = ", pnt[ipnt],", head time = ",
    #            wave[ifl,ipnt].headtime, ", hz = ",
    #            wave[ifl,ipnt].hz, ", (nwave,nch) = ",(wave[ifl,ipnt].nwave,wave[ifl,ipnt].nch), 
    #            ", chid", wave[ifl,ipnt].chid
    #         )
        waveF = Array{Float64}(undef, nwave, nch)
        waveF[:, :] = wave_pnt[:, :]
        waveF = waveF * coef
        if rm_offset > 0
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
    end