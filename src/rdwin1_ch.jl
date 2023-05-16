function rdwin1_ch(data, nch)
# Array definition 
    headtime  = Array{Int64}(undef,6)
    hz_each   = Array{Int64}(undef,60,nch)
    chid_each = Array{String}(undef,60,nch)
# 
    sz=length(data)
    isec0 = 0
    nbyo  = 0 
# byo loop1 : get hz, nbyo
    while isec0 < sz
        nbyo   = nbyo+1 
        sz1sec = conbyte(data[isec0+1:isec0+4])
        it0    = headit(data[isec0+5:isec0+10])
        if isec0 == 0
          headtime = it0
    #      println(headtime)
        end
        ich0=10
        #  channel loop
        for ich=1:nch
          chid_each[nbyo,ich] = @sprintf("%2X%02X", data[isec0+ich0+1],data[isec0+ich0+2])
          spsize = data[isec0+ich0+3] >> 4
          hz_each[nbyo,ich] = conbyte([mod(data[isec0+ich0+3],16), data[isec0+ich0+4]])
    #      println(sz1sec," ",it0," ",chid[nbyo,ich]," ",spsize," ",hz[nbyo,ich])
          if spsize == 0 || spsize == 5
            error("SAMPLE_SIZE: The case that sample size = $spsize is not supported.")
          else
            byosize = 4 +spsize*(hz_each[nbyo,ich]-1)
          end
          ich0 = ich0 + 4+ byosize
        end
        isec0 =isec0+sz1sec
    end
#    
#  println("nbyo = ",nbyo)
# check hz and chid.
    if nbyo > 1
        for ibyo = 2:nbyo
          if hz_each[ibyo,:] != hz_each[1,:]
            error("Sampling Frequencies at $ibyo second are $(hz_each[ibyo,:]). These are not same as head one $(hz_each[1,:]).")
          end
          if chid_each[ibyo,:] != chid_each[1,:]
            error("Channel IDs at $ibyo second are $(chid_each[ibyo,:]). These are not same as head one $(chid_each[1,:]).")
          end
        end
    end
    if nch >1
        for ich = 2:nch
          if hz_each[1,ich] != hz_each[1,1]
            error("Sampling Frequencies are different among channels. $(hz_each[1,:]).")
          end
        end
    end
    
# read wave data
    isec0 = 0
    hz = hz_each[1,1]
    nwave = hz*nbyo
    wave  = Array{Int64}(undef,nwave,nch)
    for ibyo = 1:nbyo
        sz1sec = conbyte(data[isec0+1:isec0+4])
        ich0=10
        n1 = hz*(ibyo-1) + 1
        n2 = hz*ibyo
    #  channel loop
        for ich=1:nch
            spsize = data[isec0+ich0+3] >> 4
            byosize = 4 +spsize*(hz-1)
            i = isec0+ich0+4
            i1 = i+1
            i2 = i+byosize
            wave[n1:n2,ich] = datatowv(data[i1:i2],spsize,hz)
            ich0 = ich0 + 4+ byosize
        end
        isec0 =isec0+sz1sec
    end
    chid = chid_each[1,:]
    return (;headtime, nwave, hz, nch, chid, wave)
end
