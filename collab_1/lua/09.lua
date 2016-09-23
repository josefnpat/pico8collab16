stuck = {
 name="stuck!",
 author="elgregos",
_init=function(sf)
 g_s,pxs,pys,lvls=0,{-1,1,0,0},{0,0,-1,1},{
  {"415welcome","p1.1.1.2.2.2.1.       ,       ...... .  . . ..  . . . .  . ... . . . .  ..  . . . . .  . ... .  ..  . . .       ,       .1.2.3.4.3.2.1."},
  {"611unsorted steps","p.  ... 123 1    1   4 1  .12 .23 1    . .  ...,...,..."},
  {"5 7lucky clover","121 111111 2111122211  2p2  1222211242 112121 111"},
  {"4 9symmetries","2223221112  2 1  12  2 1  23222 1113p       23211 11122  2 1  12  2 1  1221222111"},
  {"6 6flowering"," 111   1,211111p,11,2111112,1   111 "},
  {"4 9square in diamond","    p       121     11.11   11   11 .31   13. 11   11   11111     121       .    "},
  {"4 9diamond in square","1111.11111111p11111111 1111111   1111.     .1111   1111111 11111111.1111111111111"},
  {"610nespad","111111111121 13p11111   21111122 121 1 11211121111"},
  {"411invader","  .     .     1   1     1211121   11 111 11 111122211221 2221121 2p .     . 1   .. ..   "},
  {"313room cleaning","111  111  1111 1111 1  1 1121  121  121 1    1    2  1    1    2 122  121  1211 2111p2111 1111  111  121           1            1 111  112  1111.1112 2112 2121  111  222"},
  {"410eightly yours","    p4        44      441144    441144  44111111444411111144  441144    441144      44        44    "},
  {"312blossom","   222        22 2111     2  1  222  121111 1 22 1  1 211  2 1 11p2 11222211 1111 1 2  111 1  1 22 1 111121  222  1  2     1112 22        222   "},
  {"410creepy","111.11.111111111111111  11  1111  11  111121  p211111    111111    111111 11 11111114421111111222111"},
  {"5 5ring",",.1, .  . . 131p 111. 111.  . ,.1, "},
  {"311720 kb","1111111111111111111111111111111111111212111111111 111111111 , 111111111 111111111211111111    11 11p1    11 1111    11 11"},
  {"311unclear paths","111 111 1112.211.211.1111 121 121 1   1   2 111 111 1312.212p312.1121 111 121 2   1   1 121 131 1211.212.112.1111 111 111"},
  {"515\"insert coin\"","  1111    111   111111  11111 11p11,, 1,11,111111,,,,1,11,111111,,,,111111111111,, 1112111 111111 2222222  1111  1 1 1 1"},
  {"315let's play!","1112111 1112111,  2  1 1  2  ,1112121122121121  1 1   1 1  22222 11 11 2222   1  1 1  1   1112112121121111  1  1 1  1  1,1 2122p1112 2, 1 2 1   1 1 2 1222 11 11 11211     1 1     1111111211111111"},
  {"1 5a step higher",",,,,,,   ,1   12...12   22   22...22   22   22...22   22   22.p.21   1,   ,"},
  {"415congratulations!","p1             11   11 11     1111 11 11     11 1222 11     11 12 2221 111 11 11   2221 211211  122 1111           12              221 "},
  {"1 1reset cart to quit","1"}
 }
 l_nh=min(max(dget(32),1),#lvls)
 l_n=l_nh
 sf.l_init(sf)
end,

_update=function(sf)
 if btnp(5) then
  g_s=1-g_s
  sf.l_sel(sf)
 end
 if g_s==0 then
  for bn=1,4 do
   if btnp(bn-1) then
    sf.p_move(sf,pxs[bn],pys[bn])
   end
  end
 else
  if btnp(0) then
   l_n=max(l_n-1,1)
  end
  if btnp(1) then
   l_n=min(l_n+1,l_nh)
  end
  sf.l_init(sf)
 end
 sf.l_draw(sf)
end,

l_sel=function(sf)
 sf.l_init(sf)
end,

l_init=function(sf)
 l_nh=max(l_nh,l_n)
 dset(32,l_nh)
 p_x,p_y,lvl=20,20,lvls[l_n]
 l_w,l_cs=sub(lvl[1],2,3),lvl[2]
 l_xo,l_yo,cs_tot=flr(8.5-l_w/2),sub(lvl[1],1,1),0
 for ly=0,16 do
  for lx=0,16 do
   mset(lx,ly,148)
  end
 end
 for cn=0,#l_cs-1 do
  cx,cy,c_sp,c_st=cn%l_w,flr(cn/l_w),149,sub(l_cs,cn+1,cn+1)
  if c_st>="1" and c_st<="4" then
   c_sp=163+c_st
   cs_tot+=1
  elseif c_st==" " then
   c_sp=148
  elseif c_st=="," then
   c_sp=150
  elseif c_st=="p" then
   p_x,p_y=cx+l_xo,cy+l_yo
   c_sp=151
  end
  mset(cx+l_xo,cy+l_yo,c_sp)
 end
 sf.l_draw(sf)
end,

l_draw=function(sf)
 map(0,0,-4,-4,17,17)
 rectfill(0,5,127,11,1-g_s)
 print(sub(lvls[l_n][1],4),4,6,9-g_s)
 print(" retry",90,6,4)
 spr(132,
 (p_x-0.5)*8,
 (p_y-0.5)*8)
end,

p_move=function(sf,px,py)
 m_sp=mget(p_x,p_y)
 if fget(mget(p_x+px,p_y+py),0) then
  if fget(m_sp,1) then
   m_sp-=1
   if m_sp<164 then
    cs_tot-=1
    m_sp=148
    sfx(33)
   else
    sfx(32)
   end
   mset(p_x,p_y,m_sp)
  end
  p_x+=px
  p_y+=py
 end
 if cs_tot<=0 then
  sfx(34)
  l_n+=1
  sf.l_init(sf)
 end
end,
}
add(games,stuck)
