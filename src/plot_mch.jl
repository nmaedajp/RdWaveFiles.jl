
# 整数配列６個（年月日時分秒）のデータから，日付の文字列を作成する．
# Dates.formatで可能だが，あまり他のパッケージは使いたくない．
# sprintf を使わないで，2桁整数に
function dig2(i)
    if i < 10
        ch = "0$i"
    else
        ch = "$i"
    end
    return ch
end
function it2cht(it)
    cht="$(it[1])-$(dig2(it[2]))-$(dig2(it[3]))T$(dig2(it[4])):$(dig2(it[5])):$(dig2(it[6])).00"
    return cht
end
#
# 多チャンネルをプロットするための関数．GMT.jlを使用している．
# wave は 構造体 Wavetypeを使用している． 
# (20240810)：単位が1chと2ch以降で軸からの距離がずれる．
# (20240810)：現在，LABELのオフセットを1chを6p，2ch以降を8pとして位置合わせしている．
# (20240810)：原因はわからない．⇒ besemapを用いて軸を描くようにした．(20240812)
# (20240811)：nt1，nt2 を使う．
# (20240812)：オフセットを除くためのオプション．rm_offsetを追加．
# (20240812)：plt_t0 のオプションを 論理型に変更する．
# (20250104)：wave，y1, y2 に型を付加．
# (20250104)：rm_offset を true に．
# 
function plot_mch(wave::Wavedata, t1::Float64, t2::Float64, y1::Float64, y2::Float64, title::String;
    width=16.0, height=1.5, offset=0.9, szmj=10, pw=0.25, pc=:black, 
    szttl=12, szlbl=10, szleg=10, 
    xlabel="time [s]", unit="[m/s@+2@+]", rm_offset=true,  
    plt_t0=true)
#
# wave:プロットする波形データ．
#      パッケージRdJUFilesで定義されているWavedata．
# t1,t2:プロットする始まりの時間と終わりの時間
# y1,y2:プロットする最小値と最大値
#      :両方とも 0.0 の場合は，プロットする範囲の波形のデータから
#      :振幅の最大値から求める．
# title:グラフのタイトル
#
# 以下はキーワード引数（初期値を与えているので，指定しなくとも良い）
# width=16:プロットの幅(cm)．波形をプロットする幅．
# height=1.5:プロットの高さ(cm)．１chごとのプロットの高さ．  
# offset=0.9:チャンネルごとのプロットの間隔．
# szmj=10:軸の目盛の文字のサイズ(pt)
# pw=0.25:プロットする波形の線の幅(pt)
# pc=:black:プロットする波形の色
# szttl=12:タイトルの文字の大きさ(pt)
# szlbl=10:軸ラベルの文字の大きさ(pt)
# szleg=10:ch名を記す文字の大きさ(pt)
# xlabel="time [s]":横軸のラベル
# unit="[m/s@+2@+]":縦軸のラベル．初期設定は加速度．
# rm_offset=false:プロットするときにオフセットを除く
# plt_t0=true:タイトルに先頭時刻を表示する．
#
# dt:サンプリング周期，nwave:波形のサイズ，t：時間
    dt = 1.0/wave.hz
    nwave = wave.nwave
    t = wave.t
#
# n1，n2
    nt1 = round(Int64, t1/dt) + 1
    nt2 = round(Int64, t2/dt) + 1
    if nt2 > nwave
        nt2 = nwave
    end
# set title
    if plt_t0
        ttl = title*"  t0="*it2cht(wave.headtime)
    else
        ttl=title
    end
# remove offset
    if rm_offset
        n = nt2 - nt1 + 1
        avr = [sum(wave.waveF[nt1:nt2, ich])/n for ich = 1:wave.nch]'
#        @show avr
    end
# set y1 & y2
    if y1 == 0.0 && y2 == 0.0
        if rm_offset
            y1 = -maximum(abs.(wave.waveF[nt1:nt2, :] .- avr ))
            y2 =  maximum(abs.(wave.waveF[nt1:nt2, :] .- avr ))
        else
            y1 = -maximum(abs.(wave.waveF[nt1:nt2, :]))
            y2 =  maximum(abs.(wave.waveF[nt1:nt2, :]))
        end
    end
# ch 1
    GMT.basemap(frame=(axes=(:left_full,:bottom_full,:right_bare,:top_bare), annot=:a,
        ticks=:a, grid=:a),
        J="X$(width)c/$(height)c",
        region=(t1, t2, y1, y2), 
        ylabel=unit,
        title=ttl, 
        conf=(FONT_TITLE="$(szttl)p,Helvetica,black", 
        FONT_LABEL="$(szlbl)p,Helvetica,black", 
        FONT_ANNOT_PRIMARY="$(szmj)p,Helvetica,black",
        MAP_ANNOT_OFFSET="2p",
        MAP_LABEL_OFFSET="6p",
        MAP_TITLE_OFFSET="12p",
        MAP_FRAME_PEN="0.5p,black")  
    )
    if rm_offset
        GMT.plot(t[nt1:nt2], wave.waveF[nt1:nt2, 1] .-avr[1], pen=(pw, pc))
    else
        GMT.plot(t[nt1:nt2], wave.waveF[nt1:nt2, 1], pen=(pw, pc))
    end
    GMT.legend((
	       vspace=-0.25,
           text1=(txt="ch "*wave.chid[1]),
          ),
          pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
          conf=(FONT_ANNOT_PRIMARY="$(szleg)p,Helvetica,black",)
        )
# ch ich
    for ich = 2:wave.nch-1
        GMT.basemap(frame=(axes=(:left_full,:bottom_full,:right_bare,:top_bare), annot=:a,
            ticks=:a, grid=:a),
            Y="-$(offset+height)",
            J="X$(width)c/$(height)c",
            region=(t1, t2, y1, y2), 
            ylabel=unit,
            conf=(FONT_TITLE="$(szttl)p,Helvetica,black", 
                FONT_LABEL="$(szlbl)p,Helvetica,black", 
                FONT_ANNOT_PRIMARY="$(szmj)p,Helvetica,black",
                MAP_ANNOT_OFFSET="2p",
                MAP_LABEL_OFFSET="6p",
                MAP_TITLE_OFFSET="12p",
                MAP_FRAME_PEN="0.5p,black")  
        )
        if rm_offset
            GMT.plot(t[nt1:nt2], wave.waveF[nt1:nt2, ich] .- avr[ich], pen=(pw, pc))
        else
            GMT.plot(t[nt1:nt2], wave.waveF[nt1:nt2, ich], pen=(pw, pc))
        end
        GMT.legend((
            vspace=-0.25,
            text1=(text="ch "*wave.chid[ich])
           ),
           pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
           conf=(FONT_ANNOT_PRIMARY="10p,Helvetica,black",)
        )
    end
# ch nch
    GMT.basemap(frame=(axes=(:left_full,:bottom_full,:right_bare,:top_bare), annot=:a,
        ticks=:a, grid=:a),
        Y="-$(offset+height)",
        J="X$(width)c/$(height)c",
        region=(t1, t2, y1, y2), 
        xlabel=xlabel, ylabel=unit,
        conf=(FONT_TITLE="$(szttl)p,Helvetica,black", 
              FONT_LABEL="$(szlbl)p,Helvetica,black", 
              FONT_ANNOT_PRIMARY="$(szmj)p,Helvetica,black",
              MAP_ANNOT_OFFSET="2p",
              MAP_LABEL_OFFSET="6p",
              MAP_TITLE_OFFSET="12p",
              MAP_FRAME_PEN="0.5p,black"),
        time_stamp=""
    )
    if rm_offset
        GMT.plot(t[nt1:nt2], wave.waveF[nt1:nt2, wave.nch] .- avr[wave.nch], pen=(pw, pc))
    else
        GMT.plot(t[nt1:nt2], wave.waveF[nt1:nt2, wave.nch], pen=(pw, pc))
    end
    GMT.legend((
        vspace=-0.25,
        text1=(text="ch "*wave.chid[wave.nch])
       ),
       pos=(norm=(0,1), width=3.5, justify=:BL, offset=0.05, spacing=0.1),
       conf=(FONT_ANNOT_PRIMARY="10p,Helvetica,black",)
    )
end
