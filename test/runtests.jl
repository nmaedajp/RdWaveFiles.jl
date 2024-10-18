using RdWaveFiles
using Test

wvdir="./test"
obs = ["tsobs"]
wvdir2="./test/tsobs"
pnt = ["pnt1", "pnt2"]
println("wave dir for rdjumult = ",wvdir)
println("obs name for rdjumult = ",obs)
println("wave dir for rdjusngl = ",wvdir2)
println("sensor name = ",pnt)

#waveml = rdjumult(wvdir, obs[1], pnt; coef=1.0, rm_offset=0)
#wavesg1 = rdjusngl(wvdir2, pnt[1]; coef=1.0, rm_offset=0)
#wavesg2 = rdjusngl(wvdir2, pnt[2]; coef=1.0, rm_offset=0)
#println(waveml.headtime, " ",waveml.nwave, " ", waveml.hz, " ",waveml.nch, " ",waveml.chid)
#println(wavesg1.headtime, " ",wavesg1.nwave, " ", wavesg1.hz, " ",wavesg1.nch, " ",wavesg1.chid)
#println(wavesg2.headtime, " ",wavesg2.nwave, " ", wavesg2.hz, " ",wavesg2.nch, " ",wavesg2.chid)
#for i=1:10
#    println(waveml.waveF[i,:])
#end
#head10=[-128040  167294  -1191659  -3990  -196954  -1042366
#        -127838  167787  -1193179  -3306  -196422  -1043332
#        -127969  168812  -1195531  -3331  -195381  -1044932
#        -128166  168457  -1193324  -4306  -195588  -1043419
#        -129230  167194  -1191030  -4552  -196487  -1042541
#        -129267  167543  -1193003  -3723  -196705  -1043493
#        -128881  167895  -1194529  -4218  -196422  -1044601
#        -128926  168497  -1193437  -4692  -195374  -1044894
#        -128646  168944  -1193818  -4117  -194632  -1043641
#        -128359  168581  -1193625  -3650  -195388  -1043693]
@testset "RdWaveFiles.jl" begin
#    @test waveml.headtime  == [2022,10,18,17,58,0]
#    @test wavesg1.headtime == [2022,10,18,17,58,0]
#    @test wavesg2.headtime == [2022,10,18,17,58,0]
#    @test waveml.waveF[1:10,1:6] == Float64.(head10)
#    @test wavesg1.waveF[1:10,1:3] == Float64.(head10[1:10,1:3])
#    @test wavesg2.waveF[1:10,1:3] == Float64.(head10[1:10,4:6])
end
