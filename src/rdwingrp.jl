function conbyte(x)
    sz=length(x)
    wa=0.0
    for i=1:sz
      wa=wa+x[i]*(256^(sz-i))
    end
    wa=Int64(wa)
    return wa
end
function toint(x)
    sz = length(x)
    xx = conbyte(x)
    if xx >= 2^(sz*8-1)
      xx = xx - 2^(sz*8)
    end
    return xx
end
function headit(buf)
    it0=decbcd.(buf)
    it0[1]=2000+it0[1]
    return it0
end
function decbcd(buf)
    it=floor(buf/16)*10 + mod(buf,16)
    it=Int64(it)
    return it
end
function datatowv(data,spsize,hz)
    sz = length(data)
    wave = Array{Int64}(undef,hz)
    wave[1] = toint(data[1:4])
    for i = 2:hz
        i1 =  4 + spsize*(i-2)+1
        i2 = i1 + spsize -1
        wave[i] = wave[i-1] + toint(data[i1:i2])
  end
  return wave
end
function flnmck(flnm)
  nfl = length(flnm)
  flJU = String[]
  for ifl = 1:nfl
    ck_res = occursin(r"[0-9]{8}.[0-9]{2}", flnm[ifl])
    if ck_res
	   push!(flJU, flnm[ifl])
	end
  end
  return flJU
end