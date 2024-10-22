var documenterSearchIndex = {"docs":
[{"location":"","page":"Home","title":"Home","text":"CurrentModule = RdWaveFiles","category":"page"},{"location":"#RdWaveFiles","page":"Home","title":"RdWaveFiles","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"JU410で記録した win formatのファイルを読む関数\nGL900 で記録したファイルを読む関数","category":"page"},{"location":"#rdwin1_ch","page":"Home","title":"rdwin1_ch","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"rdwin1_ch(data; nch=3)\nwin format のファイルを読み込んだデータから波形などの情報を取り出す．\ndata: win format のファイル１つをバイナリで読み込んだデータ\nnch: チャンネル数．ファイルを読めばチャンネル数も決まるが，たとえば，６チャンネル記録する設定になっているが，３チャンネル分しかデータとして記録されていないというような場合に対応するため，引数としている．初期設定は，nch = 3 である．\nrdjusngl，rdjumultから引いており，普通は使用しない．波形のリストを作成するときなどに使用する．","category":"page"},{"location":"#rdjusngl","page":"Home","title":"rdjusngl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"rdjusngl(wvdir, obs ; coef=1.2310680e-07, rm_offset=1)\nイメージとしては，単点測定．\nwvdir：文字型変数：測定点の上のディレクトリの名前\nobs：文字型変数：複数の測定の名前","category":"page"},{"location":"#rdjumult","page":"Home","title":"rdjumult","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"rdjumult(wvdir, obs, pnt; coef=1.2310680e-07, rm_offset=1)\nイメージとしては，アレイ測定のように１測定で複数のセンサーを設置している場合．\nwvdir：文字型変数：測定点の上のディレクトリの名前\nobs：文字型変数：複数の測定の名前\npnt：文字型ベクトル：複数のセンサーの名前","category":"page"},{"location":"#共通事項","page":"Home","title":"共通事項","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"オプション\ncoef=1.2310680e-07：地動換算係数をゲイン ×100 のときの値を初期設定としている．\nrm_offset=1：オフセットを除いた波形を返す．\n返す値：named tupleで返している．\nwave = rdju( ) のように返した場合\nwave.headtime：先頭時刻を配列で返す．［年，月，日，時，分，秒］\nwave.nwave：波形のサンプル数/チャンネル\nwave.hz：サンプリング周波数\nwave.nch：チャンネル数\nwave.chid：チャンネルID．ju410で設定している値．文字型ベクトル\nwave.waveF：波形データ：実数型配列．大きさは (nwave，nch)","category":"page"},{"location":"#rdgl900","page":"Home","title":"rdgl900","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"rdgl900(folder, flnm, obs; hz = 100, nch = 6,    chid = [\"CH1\", \"CH2\", \"CH3\", \"CH4\", \"CH5\", \"CH6\"], coef = [3.0e-5, 3.0e-5, 3.0e-5, 3.0e-3, 3.0e-3, 3.0e-3])\nGL900で記録したCSVファイルを読み込み，mutable struct Wavedata として返す．\nfolder：CSVファイルのある フォルダ名．文字型．String\nflnm：　CSVファイル名\nobs：　 測定名\n初期値指定\nhz = 100 サンプリング周波数(Hz)．\nnch = 6 ：チャンネル数．VSE15ーAV200 のときは 6ch を使用している．\nchid ：チャンネルの名前．\ncoef ：RANGE を 0.3 としたときの換算係数．換算後の単位は，CH1〜3 は m/s，CH4〜6 は m/s²．","category":"page"},{"location":"#wvinfo","page":"Home","title":"wvinfo","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"wvinfo(wave) \nmutable struct Wavedata のデータに対して，その情報を出力する．\nprintln(\"測定名 = \", wave.obs)\nprintln(\"先頭時刻:　\", wave.headtime)\nprintln(\"波形サンプル数:　\",wave.nwave)\nprintln(\"サンプリング周波数:　\",wave.hz)\nprintln(\"チャンネル数：　\",wave.nch)\nprintln(\"チャンネルid: \", wave.chid)","category":"page"},{"location":"#chsel","page":"Home","title":"chsel","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"chsel(wave, ch)\nmutable struct Wavedata のデータから，特定のチャンネルを抽出して，mutable struct Wavedataで返す．\n入力：wave：mutable struct Wavedata\nch　： 抽出するチャンネル．chid ではなく，何番目のチャンネルなのかを指定する．","category":"page"},{"location":"#wavelist","page":"Home","title":"wavelist","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"フォルダ内にある win ファイルの情報をリストアップする．\nデータ編集（切り出し）の際のコピーミスなどの確認を行う．\nwvlist_s(wvfolder,obs,flout)\n図１のファイル構造に従うフォルダの下にある winファイルのリストを作成する．\nflout：ファイルの出力先．\"\" とすると，標準出力にリストを出力する．\nwvlist_m(wvfolder,obs,pnt,flout)\n図２のファイル構造に従うフォルダの下にある winファイルのリストを作成する．\nflout：ファイルの出力先．\"\" とすると，標準出力にリストを出力する．","category":"page"},{"location":"","page":"Home","title":"Home","text":"Documentation for RdWaveFiles.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [RdWaveFiles]","category":"page"}]
}
