mutable struct Wavedata
    obs::String
    headtime::Array{Int64,1}
    nwave::Int64
    nch::Int64
    hz::Int64
    t::Array{Float64,1}
    chid::Array{String,1}
    waveF::Array{Float64,2}
end
