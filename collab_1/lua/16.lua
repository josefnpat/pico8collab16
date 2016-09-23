lilprince = {
  author = "catnipped",
  name = "lil'trash prince",
  _init = function()
    princemirror = false
    princex = 64
    princey = 0
    princez = 300
    princespeedz = 0
    princespeedx = 0
    ballsize = 7
    ballgarbage = {}
    garbage = {}
    frames = 0
    seconds = 0
    for a = 1,200 do
      local item = {}
      item.sprite = rnd(200)
      while fget(item.sprite,7) == false do
        item.sprite -= rnd(200)
      end
      item.x = rnd(360)
      item.z = 200+rnd(90)
      add(garbage,item)
    end
    music(60)
  end,
  _update = function()
    if #garbage > 0 then
      frames += 1
      if btn(1,0) then princespeedx -= 0.03
      elseif btn(0,0) then princespeedx += 0.03
      else princespeedx = princespeedx*0.8 end
      if btn(3,0) then princespeedz -= 0.05
      elseif btn(2,0) then princespeedz += 0.05
      else princespeedz = princespeedz*0.8 end

      princespeedx = mid(-0.5,princespeedx,0.5)
      princespeedz = mid(-1,princespeedz,1)

      for item in all(garbage) do
        item.x -= princespeedx
      end

      princez += princespeedz
      princez = mid(290,princez,200)
      princey = 340-princez

      if princespeedx > 0 then
       princemirror = true
      else
       princemirror = false
      end

      for item in all(garbage) do
        if item.x%360 > 85 and item.x%360 < 95 and item.z < princez+ballsize and item.z > princez-1 then
          local sticky = {}
          srand(frames)
          sticky.sprite = item.sprite
          sticky.x = rnd(360)
          sticky.z = rnd(1)
          add(ballgarbage,sticky)
          del(garbage,item)
          ballsize += 0.2
          sfx(0)
        end
      end
      for item in all(ballgarbage) do
        item.x = item.x - princespeedx * 30
      end
      seconds = flr(frames/30)
    elseif seconds < dget(60) or dget(60) == 0 then
      dset(60,seconds)
    end

  end,
  _draw = function()
    cls()

    for x = 1,400 do
      srand(x)
      pset(rnd(128),rnd(128),rnd(17))
    end
    circfill(64,340,300,5)

    for a in all(garbage) do
      local x = 64+a.z*cos(a.x/360)
      local y = 340+a.z*sin(a.x/360)
      spr(a.sprite,x,y)
    end

    circ(princex,princey-ballsize,ballsize,15)
    for item in all(ballgarbage) do
      local z = ballsize*item.z
      local x = princex+z*sin(item.x/360)
      local y = princey+z*cos(item.x/360)
      spr(item.sprite,x-3,y-3-ballsize)
    end

    spr(44,(princex+princespeedx*20)-3,princey-6,1,1,princemirror)

    camera(princespeedx*-10,princey/5)

    print(#garbage.."/200 time:"..seconds.." best:"..dget(60),25,princey/4,15)

  end
}
add(games,lilprince)
