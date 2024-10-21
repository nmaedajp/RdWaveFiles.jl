#
#  GL900 によって記録された，CSVファイルをよみ，Wavedata として返す．
#  
function rdgl900(folder, flnm, obs; 
    hz = 100, nch = 6, 
    chid = ["CH1", "CH2", "CH3", "CH4", "CH5", "CH6"], 
    coef = [3.0e-5, 3.0e-5, 3.0e-5, 3.0e-3, 3.0e-3, 3.0e-3])
#
# 引数
#   folder：CSVファイルのある フォルダ名．文字型．String
#   flnm：　CSVファイル名
#   obs：　 測定名
#   初期値指定
#   hz = 100 サンプリング周波数(Hz)．
#   nch = 6 ：チャンネル数．VSE15ーAV200 のときは 6ch を使用している．
#   chid ：チャンネルの名前．
#   coef ：RANGE を 0.3 としたときの換算係数．換算後の単位は，CH1〜3 は m/s，CH4〜6 は m/s²．
#
    flnmd = joinpath(folder, flnm) # フォルダ名＋ファイル名
    data = readdlm(flnmd, ',')     # データを読み込む． 
#
#   データファイルは，shift-JIS で記載されている．
#   nkfなどでUTFにコード変換を使用する必要があるが，データ部分は日本語ではないので，変換の必要はない．
#
#    for i = 1:10
#        data[i, 1] = nkf_convert("$(data[i, 1])")
#    end
#    for k = 2:6
#        data[11,k] = nkf_convert("$(data[11,k])")
#    end
#    data[25, 1] = nkf_convert("$(data[25, 1])")
#    for k = 1:3
#        data[26, k] = nkf_convert("$(data[26, k])")
#    end
#    for i=1:10
#        @show i, data[i,:]
#    end
#
# 先頭時刻：データの先頭は，9行目のトリガ時刻となっている．
    headtime = Array{Int64}(undef, 6)
    headtime[1] = parse(Int,data[9,2][1:4])
    headtime[2] = parse(Int,data[9,2][6:7])
    headtime[3] = parse(Int,data[9,2][9:10])
    headtime[4] = parse(Int,data[9,3][1:2])
    headtime[5] = parse(Int,data[9,3][4:5])
    headtime[6] = parse(Int,data[9,3][7:8])
#    @show headtime
    nrow, ncol = size(data)  # データのサイズから
    nwave = nrow - 27        # 波形の数を数える．
#    @show nwave
    wave = Array{Float64}(undef, nwave, nch)
    for ich = 1:nch
        wave[1:nwave, ich] = data[28:nrow, ich+4] * coef[ich]  # 波形データ
    end
    dt = 1.0/hz
    t = [(iwave - 1)*dt for iwave = 1:nwave] # データの時刻．Δt から計算している．
#    @show nrow, ncol
    return Wavedata(obs, headtime, nwave, nch, hz, t, chid, wave) # Wavedata タイプで返す．
end
