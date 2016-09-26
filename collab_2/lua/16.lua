add(games,{
name="\nb\76\79\66\66\89 b\79\66\66\89 a\78\68\nt\72\69 b\73\71 b\82\69\65\75\79\85\84",
author="@seansleblanc",
_init = function()
 t,l,
 p_x,p_y,p_z,
 p_vx,p_vy,p_vz,
 camera=
 0,10,
 0,0,0.6,
 0,0,0,
 cameralib.new()
 camera.z=0xffffff
 
 blobs={}
 for i=1,8 do
  add(blobs,{})
 end
 music"60"
end,
_draw = function()
 --cls
 for i=1,666 do
  print("-\152-",rnd"131"-8,rnd"131",2)
 end
 
 if btn"0" then p_vx+=0.0625 end
 if btn"1" then p_vx-=0.0625 end
 if btn"2" then p_vy+=0.03125 end
 if btn"3" then p_vy-=0.03125 end
 if btn"4" then p_vz-=0.001 end
 
 
 --bg
 color"8"
 
 camera:line({0xfffffd,0xffffff.4,1},{0xfffffd,0xffffff.4,99})
 camera:line({3,0xffffff.4,1},{3,0xffffff.4,99})
 camera:line({3,2,1},{3,2,99})
 camera:line({0xfffffd,2,1},{0xfffffd,2,99})
 
 for i=1,2,0.0625 do
  local d=(i+p_z)%1*99
 
  camera:line({0xfffffd,0xffffff.4,d},{0xfffffd,2,d})
  camera:line({3,0xffffff.4,d},{3,2,d})
  camera:line({0xfffffd,0xffffff.4,d},{3,0xffffff.4,d})
  camera:line({0xfffffd,2,d},{3,2,d})
 end
 
 --blobs
 for i,b in pairs(blobs) do
  
  local z,seed2=b.z or 0,
  i/max(1,30+p_z)+p_z
  local p1={sin(seed2/2.123),cos(seed2/2.321),(i+p_z)%1*99}
  p2,b.z=camera:_coordstopx(camera:_perspective(p1)),p1[3]
  
  --collision
  if b.z-z > 0 then
   if abs(p1[1]-p_x)+abs(p1[2]-p_y) < 1 then
    rectfill(0,0,127,127)
    sfx"61"
    l-=1
   else
    sfx"60"  
   end
  end
 
  local x,y,z=p2[1],p2[2],min(100,10/sqrt(b.z))
  circfill(x,y,z,2)
  circ(x,y,z-1,8)
 end
 
 
 --player
 
 a_tx,p_p2=p_x*6,camera:_coordstopx(camera:_perspective({p_x,p_y,1}))
 
 camera.theta=a_tx/0xffff6a
 local px,py,r=p_p2[1],p_p2[2],24-abs(a_tx)
 circfill(px,py,r,2)
 circ(px,py,r,8)
 circfill(px+a_tx,py+5*p_y,r/2.5)

 print("\nd:"..max(p_z*0xfffff6).."\nt:"..t.."\nl:"..l,1,1)
 
 if l>0 then
  --gameon
  t+=1
  p_z+=p_vz
  p_x+=p_vx
  p_y+=p_vy
  
  p_vz*=0.97
  p_vx*=0.9
  p_vy*=0.9
  
  p_x*=0.7
  p_y*=0.8 
 else
  --gameover
  print"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n           you lost!\n\n     press \151 to continue"
  if btnp"5" then run() end
 end
end}) -- game 16
