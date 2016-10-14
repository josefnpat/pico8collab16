add(games,
{
 name="tank",
 author="mimick",
 _init = function()
  players=
  {
   {7, -- x
    64, -- y
    0, -- angle
    0   -- timer for shooting
   },
   {120, -- x
    64, -- y
    0.5, -- angle
    0   -- timer for shooting
   }
  }
  win,t=nil,nil
  for k,p in pairs(players) do
   p.player=k-1
   function p:draw()
    local a,p,timer = self[3],self.player,self[4]
    local rx,ry=self[1]+cos(a),self[2]-sin(a)

    timer=max(timer-1,0)
    if btn(1,p) then a+=1/128 end
    if btn(0,p) then a-=1/128 end
    if btn(2,p) then
     sfx"5"
     if pget(rx,ry)!=5 then
      self[1]=rx
      self[2]=ry
     end
    end 
    if btnp(4,p) and timer==0 then
     sfx"3"
     timer=100
     add(bullet,{rx,ry,a,p==0 and 6 or 1,100})
    end
    self[3]=a
    self[4]=timer
   
    local x,y=self[1],self[2]
    local ca,sa=cos(a),sin(a)
    for i=-4,3 do
     local ci,si=i*ca,i*sa
     for j=-4,3 do
      local col=sget(100+i,68+j)
      if (col!=0) pset(x+(j*sa+ci),y+(j*ca-si),col) 
     end
    end
   end
  end
  bullet={}
 end,
 _draw = function()
  if not win then
   for i=#bullet,1,-1 do
    local b=bullet[i]
    local x,y,ra,col,t=b[1],b[2],b[3],b[4],b[5]
    local ca,sa=cos(ra),sin(ra)
    if t==0 then
     del(bullet,b)
    else
     local rx,ry,boundx,boundy
     =ca*2+x,-sa*2+y,1,1
     if pget(rx,y)==5 then
      sfx"1"
      boundx=-1 
      rx=x
     end
     if pget(x,ry)==5 then
      sfx"1"
      boundy=-1 
      ry=y
     end
     if pget(rx,ry)==(col==1 and 7 or 0) then
      sfx"2"
      win=(col==1 and "\n\n\n\n\n\n\n\n\n\n\n\n          player 2" or "\n\n\n\n\n\n\n\n\n\n\n\n          player 1").." win"
     end
     ra=atan2(ca*boundx,sa*boundy)
     bullet[i]={rx,ry,ra,col,t-1}
    end
   end
  
   cls()
   rectfill(0,0,127,127,5)
   rectfill(2,2,125,125,13)
   rectfill(30,40,40,87,5)
   rectfill(87,40,97,87,5)
   for k,p in pairs(players) do
    if k==2 then pal(7,0) else pal() end
    p:draw()
   end
   for b in all(bullet) do
    pset(b[1],b[2],b[4])
   end
   if (win) then 
    print(win)
    t=10
   end
  else
   t=max(t-1,0)
   if btnp"4" and t==0 then
    run()
   end
  end
 end 
}) -- game 11
