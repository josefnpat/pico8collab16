bhell = {
name="butterfly hell",
author="cheepicus",

b_to_top=function(b)
 b.x=flr(rnd"148")-10
 b.y=-30
 b.sn=flr(rnd"15")
 b.sfh=rnd"1">0.5
 b.sfv=rnd"1">0.5
 b.xv=rnd"1"-0.5
 b.v=rnd"1"+0.5
end,

b_add=function(g)
 b={sz=flr(rnd"8"+8)}
 g.b_to_top(b)
 b.y -= rnd(60)
 add(_b,b)
end,

_init=function(g)
 _dead=true
	_x=64 _y=96 _d=0.25
	_v=1  _wd=_d+0.25
 _fc=0  _score=0
 _xo={} _yo={} _b={}


 for i=1,15 do
  _xo[i]=_x _yo[i]=_y
  g.b_add(g)
 end
end,

_update=function(g)
 if _dead then
  if btn"5" then
   g._init(g)
   _dead=false
   music(16,10000)
  end
  return
 end

 if btn"1" then _d-=0.03125 _wd-=0.03125 end
 if btn"0" then _d+=0.03125 _wd+=0.03125 end
 if btn"2" or btn"4" then _v+=0.2 end
 _v =mid(0.5,_v-0.05,2)
 _x+=cos(_d)*_v
 _y+=sin(_d)*_v
 _y+=0.6
 for b in all(_b) do
  b.y += b.v
  b.x += b.xv
  if b.y>178 then
   _score+=1
   b.sz+=1
   if _score%10==0 then
    g.b_add(g)
   end
   g.b_to_top(b)
  end
 end
end,
_draw=function(g)
 _fc+=1
 memset(0x6000,204,0x2000)
 sspr(56,56,8,8,0,0,129,8+_score)
 for b in all(_b) do
  sspr(32+(b.sn%4)*8,
       32+flr(b.sn/4)*8,
       8,8,
       b.x,b.y,
       b.sz,b.sz,
       b.sfh,b.sfv
       )
 end
 p = pget(_x,_y)
 if not _dead and (_x<0 or _x>127 or _y<0 or _y>127
   or not (p==12 or p==13)) then
  _dead = true
  music"-1"
  sfx"41"
  memset(0x6000,136,0x2000)
 end

 print(_score,59,2,14)
 print(_score,59,1,7)

 if _dead then
  print("~ butterfly hell ~",29,25,7)
  print("press \151 to play",32,40,_fc%15)
  return
 end

 _wd+=0.5
 circfill(_x+2.5*cos(_wd),
   _y+2.5*sin(_wd),
   2,10)
 circfill(_x,_y,1.5,14)

 for i=15,1,-1 do
  pset(_xo[i],_yo[i],8-i/8)
  if _fc%3==0 then
   _xo[0]=_x
   _yo[0]=_y
   _xo[i]=_xo[i-1]
   _yo[i]=_yo[i-1]+1
  end
 end
end
}
add(games,bhell)
