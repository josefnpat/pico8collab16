add(games,{
 name = "snek over 16",
 author = "lemtzas\nhiscore: " .. dget"42",
 ----------------------- init --
 _init = function(self)
  -- polluting the globals with my data
  t,food,s_dir,s_x,s_y,s_len,s_tail,s_run_id,s_done,input= 1,0,nil,10,10,3, {}, flr(rnd"32767"),false,{}

  -- map initialization
  for x=0,63 do
   for y=0,63 do
    sset(x,y,0)
   end
  end
 end,

 update_snek = function(self,input)
  if s_done then
    local tail_end = s_tail[1]
    del(s_tail,tail_end)
    return tail_end and sset(tail_end.x,tail_end.y,8)
  end

  if input then
    s_dir = input

    p_x,p_y,s_x,s_y =
      s_x,s_y,
      s_dir == 0 and s_x - 1 or
      s_dir == 1 and s_x + 1 or
      s_x,
      s_dir == 2 and s_y - 1 or
      s_dir == 3 and s_y + 1 or
      s_y

    -- pausing on walls
    if s_x < 0 or s_x > 63 or
       s_y < 0 or s_y > 63 then
     s_x,s_y = p_x,p_y
     return
    end

    -- sliding
    s_tail[#s_tail+1] =
      {
        x = p_x,
        y = p_y
      }
    sset(s_tail[1].x,s_tail[1].y,0)
    sset(s_tail[#s_tail].x,s_tail[#s_tail].y,6)
    if #s_tail > s_len then
      for i=1,#s_tail do
        s_tail[i] = s_tail[i+1]
      end
    end

    local target = sget(s_x,s_y)
    if target == 11 then
      s_len = s_len + 1
      food = food - 1
      if s_len > dget"42" then
        if dget"43" ~= s_run_id then sfx"47" end
        dset(42,s_len)
        dset(43,s_run_id)
      end
      sfx(s_len % 10 == 0 and 45 or 44)
    else
      s_done = s_dir ~= nil and target ~= 0 and not sfx"46"
    end

    sset(s_x,s_y,8)
  end
 end,

 --------------------- update --
 _update = function(self)
  t=t+1
  -- input
  s_pdir = s_ndir
  s_ndir =
    btn"0" and s_pdir ~= 1 and 0 or
    btn"1" and s_pdir ~= 0 and 1 or
    btn"2" and s_pdir ~= 3 and 2 or
    btn"3" and s_pdir ~= 2 and 3 or
    s_ndir
  if s_pdir ~= s_ndir then add(input, s_ndir) end

  if t % 2 == 0 then
    self:update_snek(input[1] or s_dir)
    self:update_snek(input[2])

    input = {}
  end

  if t % 30 == 0 and food < 10 then
   local x,y = flr(rnd"63"),flr(rnd"63")
   sset(x,y,sget(x,y) == 0 and 11 or 0)
   food = food + 1
  end
 end,

------------------------ draw --
 _draw = function(self)
  cls()
  print("hiscore " .. dget"42", 1, 1, dget"43" == s_run_id and 12 or 1)
  print("  score " .. s_len, 1, 7, 1)

  if s_done then
    if btn"4" or btn"5" then self:_init() end
    print("— to restart", 37, 122, 8)
  end

  sspr(0,0,64,64,0,0,128,128)
 end
})
