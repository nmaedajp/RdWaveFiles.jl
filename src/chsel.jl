function chsel(wave, ch)
# rdjumult，rdjusngl で読まれた，wave の中から，
# 特定のチャンネルを抽出した波形データを named tuple の形で返す．
# 入力：wave：rdjumult，rdjusngl で読まれた named tupleタイプの波形データ
# 　　：ch　： 抽出するチャンネル．chid ではなく，何番目のチャンネルなのかを指定する．
# 20230619：返す値をnamed Tupleから構造体へ．
nch = length(ch)
    waveF=Array{Float64}(undef, wave.nwave, nch)
    chid=Array{String}(undef, nch)
    for ich = 1:nch
       waveF[:,ich]=wave.waveF[:,ch[ich]]
       chid[ich]=wave.chid[ch[ich]]
    end
    return Wavedata(wave.obs, wave.headtime, wave.nwave, nch, wave.hz, wave.t, chid, waveF)
end
