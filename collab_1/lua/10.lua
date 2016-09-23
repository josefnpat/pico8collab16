sequence = {
 author = "johanp",
 name = "sequence",
 btns={},
 mode=0,
 best=0,
 newgame = function(self)
  self.t = 0
  self.sq={flr(rnd(6)+1)}
  self.sqp=0
  self.sqt=30
  self.score=0
  self.mode=0
 end,
 _init = function(self)
  self.newgame(self)
  px={74,114,94,94,14,39}
  py={64,64,44,84,64,64}
  for i=1,6 do
   add(self.btns,{x=px[i],y=py[i],h=-100,s=1,c=i-1})
  end
 end,
 _update = function(self)
  self.t += 1
  local btns=self.btns
  local sq=self.sq
  local m=self.mode
  if (m<3) then
   for i=1,6 do
    bi=btns[i]
    if (btnp(i-1)) then

     if (m==2) then
      bi.h=1
      bi.s=0
      if (i==sq[self.sqp]) then
       self.sqp+=1
       if (self.sqp>count(sq)) then
         self.sqp=0
         add(sq,flr(rnd(6)+1))
         self.mode=1
         self.sqt=30
         self.score+=1
         if (self.score>self.best) self.best=self.score
       end
      else
       self.mode=3
      end
     end
    else
     if (bi.h<5) then
      bi.h+=1
     else
      bi.s=1
     end
    end
   end

   if (m==1) then
    if (self.sqt==0) then
      self.sqp+=1
      self.sqt=10
      bs=btns[sq[self.sqp]]
      bs.h=1
      bs.s=0

      if (count(sq)==self.sqp) then
       self.sqp=1
       self.mode=2
      end
    else
     self.sqt-=1
    end
   end
   if (m==0 and btnp(5)) self.mode=1
  else
   for i=1,6 do
    bi=btns[i]
    bi.s=2
    if (bi.h>-1 and self.t%4==0) bi.h-=1
   end

   if (btnp(5)) self.newgame(self)
  end
 end,

 _draw = function(self)
  cls()

  drawbtn = function(b)
   local clrs={8,4,11,3,12,13,10,9,14,2,6,5}
   local c = b.c*2+2
   for i=0,b.h do
    circfill(b.x,b.y-i,10,clrs[c])
   end
   circfill(b.x,b.y-b.h-1,10,(b.s>0 and clrs[c-1] or 7))
  end

  print("score:"..self.score.."              best:"..self.best, 0,120,7)

  local m=self.mode
  if (m==3 or m==0) then
   print(m==0 and "sequence              press " or "game over              press ",0,0)
  else
   print(m==1 and "observe..." or " repeat!",50,10)
  end

  foreach(self.btns, drawbtn)

 end


}
add(games,sequence)
