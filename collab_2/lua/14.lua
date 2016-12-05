add(games,{
 name = "snek over 16",
 author = "lemtzas\nhiscore: " .. dget"42",
 ----------------------- init --
 _init = function(self)
  -- polluting the globals with my data
  t,food = 1,0
  -- snek
  s_dir, s_x,s_y = nil, 10,10
  s_len, s_tail, s_run_id = 3, {}, flr(rnd"32767")

  -- map initialization
  for x=0,63 do
   for y=0,63 do
    sset(x,y,0)
   end
  end
 end,

 update_snek = function(self)
  if s_done then
    local tail_end = s_tail[1]
    del(s_tail,tail_end)
    return tail_end and sset(tail_end.x,tail_end.y,8)
  end

  -- input
  s_dir =
   btn"0" and s_dir ~= 1 and 0 or
   btn"1" and s_dir ~= 0 and 1 or
   btn"2" and s_dir ~= 3 and 2 or
   btn"3" and s_dir ~= 2 and 3 or
   s_dir
  if btn"4" then self:_init() end
  if not s_dir then return end

  local p_x,p_y = s_x,s_y
  s_x =
   s_dir == 0 and s_x - 1 or
   s_dir == 1 and s_x + 1 or
   s_x

  s_y =
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
  local old = s_tail[1]
  local new = s_tail[#s_tail]
  sset(old.x,old.y,0)
  sset(new.x,new.y,6)
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
      s_winning = dget"43" ~= s_run_id and sfx"47" or true
      dset(42,s_len)
      dset(43,s_run_id)
    end
    sfx(s_len % 10 == 0 and 45 or 44)
  elseif
    s_dir ~= nil and
    target ~= 0 then
    sfx"46"
    s_done = true
  end

  sset(s_x,s_y,8)
 end,

 --------------------- update --
 _update = function(self)
  function r_grid()
   return flr(rnd"63")
  end
  t=t+1

  if t % 2 == 0 then
   self:update_snek()
  end

  if t % 30 == 0 and food < 10 then
   local x,y = r_grid(), r_grid()
   sset(x,y,sget(x,y) == 0 and 11 or 0)
   food = food + 1
  end
 end,

------------------------ draw --
 _draw = function(self)
  cls()
  print("hiscore " .. dget"42", 1, 1, s_winning and 12 or 1)
  print("  score " .. s_len, 1, 7, 1)
  sspr(0,0,64,64,0,0,128,128)
 end
})
