module RdWaveFiles

using Printf, DelimitedFiles
using GMT

export rdwin1_ch, rdjumult, rdjusngl, wvinfo, chsel, Wavedata, wvlist_m, wvlist_s, rdgl900

include("Wavedata.jl") # mutable struct Wavedata

include("rdwingrp.jl") # functions used in rdwin1_ch.jl

include("rdwin1_ch.jl")  # read a win-format file 

include("rdjumult.jl")
include("rdjusngl.jl")

include("rdgl900.jl")  # read a csv file recorded by GL900

include("wvinfo.jl")  # print Wavedata infomation
include("chsel.jl")   # extract CHs in Wavedata  

include("wvlist.jl")  # make list for winfiles

include("plot_mch.jl")  # make plot of Wavedata

end
