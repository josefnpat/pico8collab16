liquidream = {
author = "liquidream",
  name = "boomshine-8",
  level=1,
  totalscore=0,

  _init = function(self)
    score,_f,gamestate,balls,cx,cy,levelballs,leveltrgts
     =0,0,1,{},60,57,{},{1,2,3,5,7,10,15,21,27,33,44,55}
    for bnum=5,60,5 do
		   add(levelballs,bnum)
	   end
    for x=1,levelballs[self.level] do
     self.add_ball(rnd"115"+5,rnd"115"+5,rnd"15"+1,1)
    end
  end,

  _update = function(self)
    if(btn"2") cy-=2
    if(btn"3") cy+=2
    if(btn"0") cx-=2
    if(btn"1") cx+=2
    if btnp"4" and gamestate==1 then
     self.add_ball(cx,cy,6,2)
     gamestate=2
     sfx"24"
    end
    alldone=true
    for b in all(balls) do
      brad=b.rad
      if b.state==1 then
        b.x+=b.vx
        b.y+=b.vy
        if (b.x+brad>127 or b.x-brad<1) b.vx=b.vx*-1
        if (b.y+brad>127 or b.y-brad<1) b.vy=b.vy*-1
        for ex_b in all(balls) do
         if ex_b.state==2 or ex_b.state==3 then
          dx=ex_b.x-b.x
          dy=ex_b.y-b.y
          dist=sqrt(dx*dx+dy*dy)
          if dist < ex_b.rad+brad+1 then
            b.state=2
            sfx(24+rnd"3")
            score+=1
          end
         end
        end
      elseif b.state==2 then
        brad+=1.0
        brad=min(brad,9)
        b.duration+=1
        if (b.duration > 40) b.state=3
      elseif b.state==3 then
        brad-=1.0
        if (brad<=0) del(balls,b)
      end
      b.rad=brad
      if (b.state>1) alldone=false
    end

    cls()
    lvl=self.level
    if lvl<=12 then
     target=leveltrgts[lvl]
     if (score>=target) cls"5"
     for b in all(balls) do
       circfill(b.x,b.y,b.rad,b.col)
     end
     spr(76,cx,cy)
     color"7"
     if _f<100 then
      print("\n\n\n\n\n\n\n\n          - level "..lvl.." -\n\n\n       goal: "..target.." out of "..levelballs[lvl].."\n\n\n        current score:"..self.totalscore)
      _f+=1
     end
     print(score.."/"..target,5,120,6)
     if alldone and gamestate==2 then
       if (score >= target) self.level+=1 sfx"27" self.totalscore+=score
       if (self.level<=12) self._init(self)
     end
    else
     print("\n\n\n\n\n\n\n\n         y o u   w i n !\n\n\n\n         final score: "..self.totalscore)
    end
  end,

  add_ball=function(in_x,in_y,in_col,in_state)
   angle=rnd"1.0"
   add(balls,
    {
     x=in_x,
     y=in_y,
     rad=2,
     col=in_col,
     vx=0.5*cos(angle),
     vy=0.5*sin(angle),
     state=in_state,
     duration=0
    }
   )
  end
}
add(games,liquidream)
