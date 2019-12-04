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
puts"goal(x,y):(#{gx},#{gy})"
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
puts"n-1:#{n-1}"

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

#_________________________________________________________________________________________________________________________

#2.学習
for k in 1..enum do #エージェントの個数分繰り返す。

	sx =rand(0..n-1)
	sy =rand(0..n-1)
    puts"start(x,y):(#{sx},#{sy})"
	#startを,グリッドワールドにランダムに格納

	ex =sx
	ey =sy
	puts"エージェントの座標(ex,ey):(#{ex},#{ey})"
	#エージェントの作成(スタート地点に設置)

	for h in 0..elife-1 do #hはエージェント寿命である。四つの矢印の長さを使って確率的に移動する。もしゴールについたらforから脱出する。
		puts"移動前のエージェントの座補(x,y)=(#{ex},#{ey})"
		puts"u:#{u[ey][ex]}"
		puts"d:#{d[ey][ex]}"
	    puts"l:#{l[ey][ex]}"
		puts"r:#{r[ey][ex]}"

		sum = u[ey][ex] + d[ey][ex] + r[ey][ex] + l[ey][ex]
		puts"sum:#{sum}"

		ra =rand(0..999)/999.to_f
		ra =ra.round(3)
		puts"ra:#{ra}"

		if ex==gx && ey==gy#スタート地点とゴール地点が同じ場合、終了する。(そのエージェントはゴールする。ただし、報酬なし)
			e_g+=1#ゴールしたエージェントのカウント
			puts"_________________________________エージェント#{enum}人目ゴール"
			break
		end
=begin
		u_c =u[ey][ex] / sum
		puts "u_c:#{u_c}"
=end
		if ra<u[ey][ex]/sum#上に行く
			history_x[h] =ex
			history_y[h] =ey #エージェントの経路記録

			#u_h[h]=1#エージェントがどちらに行ったのかの軌跡の記録

			ey =ey-1
		elsif ra < (u[ey][ex]+d[ey][ex]) / sum#下に行く
			history_x[h] =ex
			history_y[h] =ey

			#d_h[h]=1
			ey =ey+1
		elsif ra < (u[ey][ex]+d[ey][ex]+r[ey][ex]) / sum#右に行く
			history_x[h] =ex
			history_y[h] =ey

			#r_h[h]=1

			ex =ex+1
		else#左に行く
			history_x[h] =ex
			history_y[h] =ey

			#l_h[h]=1

			ex =ex-1
		end

		puts"移動前のエージェントの座標(x,y):(#{history_x[h]},#{history_y[h]})(履歴から引用)"
		puts"移動後のエージェントの座標(x,y):(#{ex},#{ey})"
		puts"________*________*____________*_______________*__________"

		if ex==gx && ey==gy
			T =h+1#エージェントの移動距離(エージェントの寿命)
			puts"逆順前"#配列を逆順にする（先入先出法の実現）
			p history_x
			p history_y

			history_x =history_x.reverse
			history_y =history_y.reverse

			puts"逆順後"
			p history_x
			p history_y

			for rb in 0..h  do #rollback(ここで報酬を分配する。)
				if history_x[h] ==history_x[h-1]&&history_y[h]>history_y[h-1]
					u[history_x[h-1]][history_y[h-1]] = u[history_x[h-1]][history_y[h-1]]+p*(T-t+1/T)
				elsif history_x[h]==history_x[h-1]&&history_y[h]<history_y[h-1]
					d[history_x[h-1]][history_y[h-1]] = d[history_x[h-1]][history_y[h-1]]+p*(T-t+1/T)
				elsif history_x[h]>history_x[h-1]&&history_y[h]==history_y[h-1]
					r[history_x[h-1]][history_y[h-1]] = r[history_x[h-1]][history_y[h-1]]+p*(T-t+1/T)
				else
					l[history_x[h-1]][history_y[h-1]] = l[history_x[h-1]][history_y[h-1]]+p*(T-t+1/T)
				end
				t+=1#エージェントのtステップ前の更新
=begin
				u_h[h]=nil
				d_h[h]=nil
				r_h[h]=nil
				l_h[h]=nil
=end
			end
			e_g+=1#ゴールしたエージェントのカウント
			puts"_________________________________エージェント#{e_g}人目ゴール"
			history_x.clear #エージェントの履歴をリセットする。
			history_y.clear
			break
		end
	end
end

puts"ゴールしたエージェントの数:#{e_g}"




