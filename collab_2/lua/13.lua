add(games,
{
 name="boogie bash",
 author="jamish",
 _init = function()
  music"20"
  
  if highscore == nil then highscore = 0 end
  frame,
  score,
  offset,
  t,
  next,
  playerx,
  gameover,
  flips,
  obstacles, --heightmap of obstacles
  gaps, --heightmap of gaps in the obstacle
  timeline = -- very scientific way of getting the perfect slam animation ;) it is reverse order
   0, 
   0, 
   0, 
   0, 
   120, --next
   5, --playerx
   false, --gameov er
   false, --flips
   {}, --obstacles
   {}, --gaps
   {0,2,8,20,31,32,32,32,32,32,32,10,5,2} --timeline

  function randomize(level)
   level = min(level,4)
   height = 0
   for i=1,8 do
    height += flr(rnd"5"-2) -- move the height by -2 to 2 units per iteration
    obstacles[i], gaps[i] = height, 0
   end
   color_floor, color_ceiling, color_bg = rnd"8"+8, rnd"8"+8, rnd"6"

   -- throw in 1 to 4 gaps at random locations with a height of 1 or 2
   for i=4,level,-1 do
    gaps[flr(rnd"8")+1] = flr(rnd"2")+1
   end
  end

  function text(str, x, y)
   print(str, x, y+1, 1)
   print(str, x, y, color_text)
  end

  randomize()
 end,
 _update = function()
  if gameover then
   if btnp"4" then cgame:_init() end
   return
  end

  if next < t then 
   randomize(flr(score/10)+1)
   score += 1
   next, highscore = t + max(80-score,35), max(score, highscore)
  end
  
  remaining = next-t
  if remaining < 14 then
   offset = timeline[remaining+1]
  elseif remaining < 30 then
   offset = t%2*2
  end
  if remaining == 10 then
    sfx"2"
  end

  if 4 < remaining and remaining < 11 then
   frame = 32 -- strike a pose
   if gaps[playerx] < 2 then
    frame = 33 --lookin good m8
   end
   if gaps[playerx] < 1 then
    --get dead, kid
    music"-1" 
    gameover = true
   end
  else 
   --movement
   if btnp"0" then
    playerx -= 1
   elseif btnp"1" then
    playerx += 1
   end
   --animate player
   if t%3 < 1 then
   --randomize the 4 frames in the col, then add the row offset
    frame, flips = rnd"4"+16*flr(rnd"2"), rnd"2" < 1
   end
  end
  --wrap player around the screen
  playerx = (playerx-1)%8+1
  t+=1
 end,
 _draw = function()
  --background
  rectfill(0,0,128,128,color_bg)

  --bars
  for j=0,128 do for i=0,7 do
   line_x = i*16
   obstacle_y = obstacles[i+1]*4
   line_y_ceiling, line_y_floor = 48-obstacle_y-gaps[i+1]*8+offset-j, 80-obstacle_y+j
   temp_color_ceiling, temp_color_floor = color_ceiling, color_floor
   if j<4 and j~=2 then 
    temp_color_ceiling -= 1
    temp_color_floor -= 1 
    color_text = temp_color_ceiling
   end
   line(line_x, line_y_floor, line_x+15, line_y_floor, temp_color_floor)
   line(line_x, line_y_ceiling, line_x+15, line_y_ceiling, temp_color_ceiling)
  end end 

  --player and text
  color(color_text)
  playery = 72-obstacles[playerx]*4
  if gameover then
   frame = 34
   playery += 5
   text("press \x8e/z to restart", 23, 110)
  end
  -- draw player
  spr(136+frame, playerx*16-12, playery, 1, 1, flips)
  text("score: "..score.."\n high: "..highscore, 2, 2)
 end
}) -- game 13