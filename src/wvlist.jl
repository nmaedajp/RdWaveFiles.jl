function wvlist_m(wvfolder,obs,pnt,flout)
    nobs = length(obs);  npoint = length(pnt);
    if(length(flout) >0)
        fl = open(flout,"w")
     end
    for iobs =1:nobs
        for ipnt =1:npoint
            println(obs[iobs], " ", pnt[ipnt])
            if(length(flout) >0)
                println(fl, obs[iobs], " ", pnt[ipnt])
            end
            folder = joinpath(wvfolder, obs[iobs], pnt[ipnt])
            wvfl = RdJUFiles.flnmck(readdir(folder))
#             println(wvfl) 
            nfl=length(wvfl)
            for ifl=1:nfl
                flnm=joinpath(folder, wvfl[ifl])
                data = read(flnm);
                wave = rdwin1_ch(data)
                szdata = sizeof(data)
                println(" ", wvfl[ifl], " ", wave.headtime, ", ", 
                        wave.hz, " Hz, ", (wave.nwave, wave.nch), 
                        ", chid ", wave.chid,", file size ",szdata)
                if(length(flout) >0)
                    println(fl, " ", wvfl[ifl], " ", wave.headtime, ", ", 
                        wave.hz, " Hz, ", (wave.nwave, wave.nch), 
                        ", chid ", wave.chid, ", file size ",szdata)
                end
             end
        end
    end
    if(length(flout) >0)
        close(fl)
    end
end

function wvlist_s(wvfolder,obs,flout)
    nobs = length(obs); 
    if(length(flout) >0)
       fl = open(flout,"w")
    end
    for iobs =1:nobs
        println(obs[iobs])
        if(length(flout) >0)
            println(fl, obs[iobs])
        end
        folder = joinpath(wvfolder, obs[iobs])
        wvfl = RdJUFiles.flnmck(readdir(folder))
#             println(wvfl) 
        nfl=length(wvfl)
        for ifl=1:nfl
            flnm=joinpath(folder, wvfl[ifl])
            data = read(flnm);
            wave = rdwin1_ch(data)
            szdata = sizeof(data)
            println(" ", wvfl[ifl], " ", wave.headtime, ", ", 
                    wave.hz, " Hz, ", (wave.nwave, wave.nch), 
                    ", chid ", wave.chid, ", file size ",szdata)
            if(length(flout) >0)
                println(fl, " ", wvfl[ifl], " ", wave.headtime, ", ", 
                    wave.hz, " Hz, ", (wave.nwave, wave.nch), 
                    ", chid ", wave.chid, ", file size ",szdata)
            end
        end
    end
    if(length(flout) >0)
        close(fl)
    end
end
