#1.環境の設計

puts"グリッドワールドの大きさを教えてください。（ｎ×ｎ）"
n = gets.to_i
#puts"n:#{n}"
#グリッドワールドの大きさを取得する。
puts"エージェントの人数を教えてください。"
enum =gets.to_i
#エージェントがスタートに設置されて、矢印の長さを更新されるまでの過程を何回くりかえすか。(エージェントの個数)
puts"エージェントの寿命は何ステップですか。"
elife =gets.to_i
#エージェントの寿命の指定
puts"履歴の長さを指定してください。"
T =gets.to_i
#履歴の長さ
x =0
y =0
#現在座標
=begin
gx_h =[]
gy_h =[]
#ゴールの座標の記録
=end
arrow =Array.new(n).map {Array.new(n,0)}
#グリッドワー ルド作成
gx =rand(0..n-1)
gy =rand(0..n-1)
#puts"goal(x,y):(#{gx},#{gy})"
#グリッドワールドの任意の位置にゴールを設置
#gx_h[k]=gx
#gy_h[k]=gy
#ゴールの座標を記録
u =Array.new(n).map{Array.new(n,0)}
d =Array.new(n).map{Array.new(n,0)}
r =Array.new(n).map{Array.new(n,0)}
l =Array.new(n).map{Array.new(n,0)}
#上下左右の矢印の長さを格納
history_x =[]
history_y =[]
=begin
u_h =[]
d_h =[]
r_h =[]
l_h =[]
=end
#エージェントの過去の移動履歴
p =1
#エージェントがゴールに到達した際の総報酬
t =1
#ゴールからさかのぼったエージェントのステップ数（ゴールからtステップ前）
e_g =0
#ゴールしたエージェントの数
#puts"n-1:#{n-1}"

u[0][0]=0 #(0,0)
l[0][0]=0
d[0][0]=0.5
r[0][0]=0.5
=begin
puts"四つ角"
puts"u[0][0]:#{u[0][0]}"
puts"d[0][0]:#{d[0][0]}"
puts"r[0][0]:#{r[0][0]}"
puts"l[0][0]:#{l[0][0]}"
=end
d[n-1][0]=0 #(0,n-1)
l[n-1][0]=0
u[n-1][0]=0.5
r[n-1][0]=0.5
=begin
puts"u[#{n-1}][0]:#{u[n-1][0]}"
puts"d[n-1][0]:#{d[n-1][0]}"
puts"r[n-1][0]:#{r[n-1][0]}"
puts"l[n-1][0]:#{l[n-1][0]}"
=end
u[0][n-1]=0 #(n-1,0)
r[0][n-1]=0
d[0][n-1]=0.5
l[0][n-1]=0.5
=begin
puts"u[0][#{n-1}]:#{u[0][n-1]}"
puts"d[0][n-1]:#{d[0][n-1]}"
puts"r[0][n-1]:#{r[0][n-1]}"
puts"l[0][n-1]:#{l[0][n-1]}"
=end
d[n-1][n-1]=0 #(n-1,n-1)
r[n-1][n-1]=0
u[n-1][n-1]=0.5
l[n-1][n-1]=0.5
=begin
puts "u[#{n-1}][#{n-1}]:#{u[n-1][n-1]}"
puts "d[n-1][n-1]:#{d[n-1][n-1]}"
puts "r[n-1][n-1]:#{r[n-1][n-1]}"
puts "l[n-1][n-1]:#{l[n-1][n-1]}"
puts"__________________________________"
=end
#四つ角
for i in 1..n-2 do
	u[0][i] =0 #上側
	d[0][i] =0.3
	r[0][i] =0.3
	l[0][i] =0.4
=begin
	puts"上側"
	puts"u(#{i},0):#{u[0][i]}"
	puts"d(#{i},0):#{d[0][i]}"
	puts"r(#{i},0):#{r[0][i]}"
	puts"l(#{i},0):#{l[0][i]}"
	puts"__________________________________"
=end
	d[n-1][i] =0  #下側
	u[n-1][i] =0.3
	r[n-1][i] =0.3
	l[n-1][i] =0.4
=begin
	puts"下側"
	puts"u(#{i},#{n-1}):#{u[n-1][i]}"
	puts"d(#{i},#{n-1}):#{d[n-1][i]}"
	puts"r(#{i},#{n-1}):#{r[n-1][i]}"
	puts"l(#{i},#{n-1}):#{l[n-1][i]}"
	puts"__________________________________"
=end
	l[i][0]=0 #左側
	u[i][0]=0.3
	d[i][0]=0.3
	r[i][0]=0.4
=begin
	puts"左側"
	puts"u(0,#{i}):#{u[i][0]}"
	puts"d(0,#{i}):#{d[i][0]}"
	puts"r(0,#{i}):#{r[i][0]}"
	puts"l(0,#{i}):#{l[i][0]}"
	puts"__________________________________"
=end
	r[i][n-1]=0  #右側
	u[i][n-1]=0.3
	d[i][n-1]=0.3
	l[i][n-1]=0.4
=begin
	puts"右側"
	puts"u(#{n-1},#{i}):#{u[i][n-1]}"
	puts"d(#{n-1},#{i}):#{d[i][n-1]}"
	puts"r(#{n-1},#{i}):#{r[i][n-1]}"
	puts"l(#{n-1},#{i}):#{l[i][n-1]}"
	puts"__________________________________"
=end
end
#残りの壁
#境界線の作成(確率を0にする。)ついでに他の方向の矢印にも確立を格納する。(環境の初期化)

for i in 1..n-2 do
	for j in 1..n-2 do
		u[i][j]=0.25
		d[i][j]=0.25
		r[i][j]=0.25
		l[i][j]=0.25
=begin
		puts"他のグリッド"
		puts"u(#{j},#{i}):#{u[i][j]}"
		puts"d(#{j},#{i}):#{d[i][j]}"
		puts"r(#{j},#{i}):#{r[i][j]}"
		puts"l(#{j},#{i}):#{l[i][j]}"
		puts"__________________________________"
=end
	end
end
#他のグリッドに確率を格納（等確立の0.25）
=begin
puts"確認"
puts"矢印を出力します。"
for i in 0..n-1 do
	for j in 0..n-1 do
		puts"(x,y):(#{i},#{j})"
	    puts"u:#{u[j][i]}"
		puts"d:#{d[j][i]}"
	    puts"l:#{l[j][i]}"
		puts"r:#{r[j][i]}"
    end
end
=end
#_________________________________________________________________________________________________________________________

#2.学習
for k in 1..enum do #エージェントの個数分繰り返す。
	sx =rand(0..n-1)
	sy =rand(0..n-1)
    #puts"start(x,y):(#{sx},#{sy})"
	#startを,グリッドワールドにランダムに格納

	ex =sx
	ey =sy
	#puts"エージェントの座標(ex,ey):(#{ex},#{ey})"
	#エージェントの作成(スタート地点に設置)
	history_x[0] =ex
	history_y[0] =ey #エージェントの経路記録（スタート地点の記録）
	for h in 1..elife-1 do #hはエージェント寿命である。四つの矢印の長さを使って確率的に移動する。もしゴールについたらforから脱出する。
		#puts"h:#{h}"
		#puts"移動前のエージェントの座補(x,y)=(#{ex},#{ey})"
		#puts"u:#{u[ey][ex]}"
		#puts"d:#{d[ey][ex]}"
	    #puts"l:#{l[ey][ex]}"
		#puts"r:#{r[ey][ex]}"
		u[ey][ex]=u[ey][ex].round(3)#小数点下三桁に変換
		d[ey][ex]=d[ey][ex].round(3)
		r[ey][ex]=r[ey][ex].round(3)
		l[ey][ex]=l[ey][ex].round(3)

		sum = u[ey][ex] + d[ey][ex] + r[ey][ex] + l[ey][ex]
		#puts"sum:#{sum}"

		ra =rand(0..999)/999.to_f
		ra =ra.round(3)
		#puts"ra:#{ra}"

		if ex==gx && ey==gy#スタート地点とゴール地点が同じ場合、終了する。(そのエージェントはゴールする。ただし、報酬なし)
			e_g+=1#ゴールしたエージェントのカウント
			#puts"_________________________________エージェント#{e_g}人目ゴール_____________________________"
			break
		end
=begin
		u_c =u[ey][ex] / sum
		puts "u_c:#{u_c}"
=end
		if ra<u[ey][ex]/sum#上に行く
			ey =ey-1

			history_x[h] =ex
			history_y[h] =ey #エージェントの経路記録

			#u_h[h]=1#エージェントがどちらに行ったのかの軌跡の記録
		elsif ra < (u[ey][ex]+d[ey][ex]) / sum#下に行く
			ey =ey+1

			history_x[h] =ex
			history_y[h] =ey

			#d_h[h]=1
		elsif ra < (u[ey][ex]+d[ey][ex]+r[ey][ex]) / sum#右に行く
			ex =ex+1

			history_x[h] =ex
			history_y[h] =ey

			#r_h[h]=1
		else#左に行く
			ex =ex-1

			history_x[h] =ex
			history_y[h] =ey

			#l_h[h]=1
		end
		#puts"移動前のエージェントの座標(x,y):(#{history_x[h]},#{history_y[h]})(履歴から引用)"
		#puts"移動後のエージェントの座標(x,y):(#{ex},#{ey})"
		#puts"________*________*____________*_______________*__________"

		if ex==gx && ey==gy
=begin
			puts"start(sx,sy):(#{sx},#{sy})"
			puts"逆順前"#配列を逆順にする（先入先出法の実現）
			p history_x
			p history_y
=end
			history_x =history_x.reverse
			history_y =history_y.reverse
=begin
			puts"逆順後"
			p history_x
			p history_y
			puts"goal(gx,gy):(#{gx},#{gy})"
			puts"goal(ex,ey):(#{ex},#{ey})"
=end
			for rb in 1..T  do #rollback(ここで報酬を分配する。)
				if rb>h
					break
				end
=begin
				puts"rb:#{rb}"
				puts"報酬前"
				puts"ゴールから#{rb-1}ステップ前座標(x,y):(#{history_x[rb-1]},#{history_y[rb-1]})"
				puts"ゴールから#{rb}ステップ前座標(x,y):(#{history_x[rb]},#{history_y[rb]})"
				puts"u:#{u[history_y[rb]][history_x[rb]]}"
				puts"d:#{d[history_y[rb]][history_x[rb]]}"
				puts"r:#{r[history_y[rb]][history_x[rb]]}"
				puts"l:#{l[history_y[rb]][history_x[rb]]}"
				puts"p#{p}"
				puts"T#{T}"
				puts"t#{t}"
=end
				if history_x[rb] ==history_x[rb-1]&&history_y[rb]>history_y[rb-1]#上方向への報酬
					u[history_y[rb]][history_x[rb]] = u[history_y[rb]][history_x[rb]]+p*(T-t+1)/T.to_f
				elsif history_x[rb]==history_x[rb-1]&&history_y[rb]<history_y[rb-1]#下方向への報酬
					d[history_y[rb]][history_x[rb]] = d[history_y[rb]][history_x[rb]]+p*(T-t+1)/T.to_f
				elsif history_x[rb]<history_x[rb-1]&&history_y[rb]==history_y[rb-1]#右方向への報酬
					r[history_y[rb]][history_x[rb]] = r[history_y[rb]][history_x[rb]]+p*(T-t+1)/T.to_f
				else#左方向へ報酬
					l[history_y[rb]][history_x[rb]] = l[history_y[rb]][history_x[rb]]+p*(T-t+1)/T.to_f
				end
				t+=1#エージェントのtステップ前の更新
=begin
				puts""
				puts"p*(T-t+1)/T#{p*(T-t+1)/T.to_f}"
				puts"報酬後"
				puts"ゴールから#{rb-1}ステップ前座標(x,y):(#{history_x[rb-1]},#{history_y[rb-1]})"
				puts"ゴールから#{rb}ステップ前座標(x,y):(#{history_x[rb]},#{history_y[rb]})"
				puts"u:#{u[history_y[rb]][history_x[rb]]}"
				puts"d:#{d[history_y[rb]][history_x[rb]]}"
				puts"r:#{r[history_y[rb]][history_x[rb]]}"
				puts"l:#{l[history_y[rb]][history_x[rb]]}"
				puts"_________________________________"
=begin
				u_h[h]=nil
				d_h[h]=nil
				r_h[h]=nil
				l_h[h]=nil
=end
			end
			t =1#tのリセット
			e_g+=1#ゴールしたエージェントのカウント
			history_x.clear#エージェントの履歴をリセットする。
		    history_y.clear
			#puts"_________________________________エージェント#{e_g}人目ゴール_____________________________"
			break
		end
		if h==elife-1#最後に来たら履歴のリセット
			history_x.clear#エージェントの履歴をリセットする。
		    history_y.clear
		end
	end
end
puts"学習時の"
if e_g==0
	puts"ゴール到達者なし"
else
	puts"ゴールしたエージェントの数(#{enum}人中):#{e_g}人"
end
puts"__________________________________学習完了__________________________________________"
puts""
puts"結果出力"
puts""
puts"矢印を出力します。"
for i in 0..n-1 do
	for j in 0..n-1 do
		puts"(x,y):(#{i},#{j})"
	    puts"u:#{u[j][i]}"
		puts"d:#{d[j][i]}"
	    puts"l:#{l[j][i]}"
		puts"r:#{r[j][i]}"
    end
end
puts"(gx,gy):(#{gx},#{gy})"
puts""
puts""
#__________________________________________________________________________________________________________________
#3.学習
puts"評価を開始します。"
elife_eva =10
enum_eva =10
e_g_eva =0#評価用のゴールしたエージェントの数
puts"ステップ数(規定)：#{elife_eva}回"
puts"繰り返し回数（規定）：#{enum_eva}回"

for eva in 1..enum_eva do #評価を開始。既定のステップ数、繰り返し回数分実行。
	sx_eva =rand(0..n-1)
	sy_eva =rand(0..n-1)
    #puts"start(x,y):(#{sx_eva},#{sy_eva})"
	#startを,グリッドワールドにランダムに格納

	ex_eva =sx_eva
	ey_eva =sy_eva
	#puts"エージェントの座標(ex,ey):(#{ex_eva},#{ey_eva})"
	#エージェントの作成(スタート地点に設置)
	for eva_se in 0..elife_eva-1 do
		#puts"u:#{u[ey_eva][ex_eva]}"
		#puts"d:#{d[ey_eva][ex_eva]}"
	    #puts"l:#{l[ey_eva][ex_eva]}"
		#puts"r:#{r[ey_eva][ex_eva]}"
    	sum = u[ey_eva][ex_eva] + d[ey_eva][ex_eva] + r[ey_eva][ex_eva] + l[ey_eva][ex_eva]
		#puts"sum:#{sum}"

		if ex_eva==gx && ey_eva==gy#スタート地点とゴール地点が同じ場合、終了する。(そのエージェントはゴールする。ただし、報酬なし)
			e_g_eva+=1#ゴールしたエージェントのカウント
			#puts"_________________________________エージェント#{e_g_eva}人目ゴール"
			break
		end

		di =[u[ey_eva][ex_eva],d[ey_eva][ex_eva],r[ey_eva][ex_eva],l[ey_eva][ex_eva]]#di(=direction)に矢印の長さを格納（上：０、下：１、右：２、左：３）
		di_eva =di.each_with_index.select{|num,index|di[index]==di.max}#di_eva(=direction evaluation)に最大値の数値とその数値のインデックスを格納
		#p di
		#p di.max
		#p di.each_with_index.select{|num,index|di[index]==di.max}
		#p di_eva
		#puts"移動前のエージェントの座標(x,y):(#{ex_eva},#{ey_eva})"

		if di_eva.length == 4#最大値が複数ある場合（４）
			ra_eva =rand(0..3)
			if di_eva[ra_eva][1]==0#上に行く
				ey_eva =ey_eva-1
			elsif di_eva[ra_eva][1]==1#下に行く
				ey_eva =ey_eva+1
			elsif di_eva[ra_eva][1]==2#右に行く
				ex_eva =ex_eva+1
			else#左に行く
				ex_eva =ex_eva-1
			end
		elsif di_eva.length ==3#最大値が複数ある場合（３）
			ra_eva =rand(0..2)
			if di_eva[ra_eva][1]==0#上に行く
				ey_eva =ey_eva-1
			elsif di_eva[ra_eva][1]==1#下に行く
				ey_eva =ey_eva+1
			elsif di_eva[ra_eva][1]==2#右に行く
				ex_eva =ex_eva+1
			else#左に行く
				ex_eva =ex_eva-1
			end
		elsif di_eva.length ==2#最大値が複数ある場合（２）
			ra_eva =rand(0..1)
			if di_eva[ra_eva][1]==0#上に行く
				ey_eva =ey_eva-1
			elsif di_eva[ra_eva][1]==1#下に行く
				ey_eva =ey_eva+1
			elsif di_eva[ra_eva][1]==2#右に行く
				ex_eva =ex_eva+1
			else#左に行く
				ex_eva =ex_eva-1
			end
		else#最大値が単数の場合
			if di_eva[0][1]==0#上に行く
				ey_eva =ey_eva-1
			elsif di_eva[0][1]==1#下に行く
				ey_eva =ey_eva+1
			elsif di_eva[0][1]==2#右に行く
				ex_eva =ex_eva+1
			else#左に行く
				ex_eva =ex_eva-1
			end
		end

		#puts"移動後のエージェントの座標(x,y):(#{ex_eva},#{ey_eva})"

		if ex_eva==gx && ey_eva==gy#スタート地点とゴール地点が同じ場合、終了する。(そのエージェントはゴールする。ただし、報酬なし)
			e_g_eva+=1#ゴールしたエージェントのカウント
			#puts"_________________________________エージェント#{e_g_eva}人目ゴール"
			break
		end
	end
end
puts"評価時の"
if e_g_eva==0
	puts"ゴール到達者なし"
else
	puts"ゴールしたエージェントの数(#{enum_eva}人中):#{e_g_eva}人"
end
#puts"__________________________________________________________________________________________________________________"
=begin
for i in 0..n-1 do#矢印の大きさの出力
	for j in 0..n-1 do
		puts"(x,y)=(#{i},#{j})"
		puts"up(上方向)=#{u[j][i]}"
		puts"down(下方向)=#{u[j][i]}"
		puts"right(右方向)=#{u[j][i]}"
		puts"left(左方向)=#{u[j][i]}"
	end
end
=end
puts""
puts"プログラムを終了します。"




