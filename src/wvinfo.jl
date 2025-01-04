function wvinfo(wave; oneline = false)
    if oneline 
        println(wave.obs, " ", wave.headtime, " ", wave.nwave, " ", wave.hz,
                " ", wave.nch, " ", wave.chid)
    else
        println(" ")
        println("測定名 = ", wave.obs)
        println("先頭時刻:　", wave.headtime)
        println("波形サンプル数:　",wave.nwave)
        println("サンプリング周波数:　",wave.hz)
        println("チャンネル数：　",wave.nch)
        println("チャンネルid: ", wave.chid)      
    end  
end
