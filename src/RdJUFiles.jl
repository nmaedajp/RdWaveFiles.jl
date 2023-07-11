module RdJUFiles

using Printf

export rdwin1_ch, rdjumult, rdjusngl, wvinfo, chsel, Wavedata, wvlist_m, wvlist_s

include("Wavedata.jl") # mutable struct Wavedata

include("rdwingrp.jl") # functions used in rdwin1_ch.jl

include("rdwin1_ch.jl")  # read a win-format file 

include("rdjumult.jl")
include("rdjusngl.jl")

include("wvinfo.jl")  # print Wavedata infomation
include("chsel.jl")   # extract CHs in Wavedata  

include("wvlist.jl")  # make list for winfiles

end
