function wvinfo(wave)
    println("測定名 = ", wave.obs)
    println("先頭時刻:　", wave.headtime)
    println("波形サンプル数:　",wave.nwave)
    println("サンプリング周波数:　",wave.hz)
    println("チャンネル数：　",wave.nch)
    println("チャンネルid: ", wave.chid)
    println(" ")
end
