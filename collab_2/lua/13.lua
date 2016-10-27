add(games,
{
 name="boogie bash",
 author="jamish",
 _init = function()
  music"20"
  t = 0
  next = 120
  gameover = false
  --heightmap of obstacles
  obstacles = {}
  --heightmap of gaps in the obstacle
  gaps = {}
  -- very scientific way of getting the correct slam animation ;) it is reverse order
  timeline = {0,2,8,20,31,32,32,32,32,32,32,10,5,2}
  playerx = 5
  score = 0 
  if highscore == nil then highscore = 0 end
  frame = 0
  flips = false
  colors = {}
  offset = 0

  function randomize(level)
   level = min(level,4)
   height = 0
   for i=1,8 do
    height += flr(rnd"4"-2) -- move the height by -2 to 2 units per iteration
    obstacles[i] = height
    gaps[i] = 0
    colors[i] = rnd"8" -- we only use 1 to 3 but reusing loop saves tokens
   end
   -- throw in 1 to 4 gaps at random locations with a height of 1 or 2
   for i=4,level,-1 do
    gaps[flr(rnd"8")+1] = flr(rnd"2")+1
   end
  end

  --function text(str, x, y)
  -- print(str, x+1, y+1, 1)
  -- print(str, x, y, 7)
  --end

  randomize()
 end,
 _update = function()
  if gameover then
   if btnp"4" then cgame:_init() end
   return
  end

  if next < t then 
   randomize(flr(score/10)+1)
   next = t + max(80-score,30)
   score += 1
   highscore = max(score, highscore)
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
    frame = rnd"4"+16*flr(rnd"2") --randomize the 4 frames in the col, then add the row (i.e., *16)
    flips = rnd"2" < 1
   end
  end
  --wrap player around the screen
  playerx = (playerx-1)%8+1
  t+=1
 end,
 _draw = function()
  --background
  rectfill(0,0,128,128,max(colors[1]-2,0))

  --bars
  for j=0,128 do for i=0,7 do
   line_x = i*16
   obstacle_y = obstacles[i+1]*4
   line_y_ceiling = 48-obstacle_y-gaps[i+1]*8+offset-j
   line_y_floor = 80-obstacle_y+j
   color_ceiling = colors[2]+8
   color_floor = colors[3]+8
   if j<4 and j~=2 then 
    color_ceiling -= 1
    color_floor -= 1 
    color_text = color_ceiling
   end
   line(line_x, line_y_floor, line_x+15, line_y_floor, color_floor)
   line(line_x, line_y_ceiling, line_x+15, line_y_ceiling, color_ceiling)
  end end 

  --player and text
  color(color_text)
  playery = 72-obstacles[playerx]*4
  if gameover then
   frame = 34
   playery += 5
   print("press \x8e/z to restart", 23, 110)
  end
  -- draw player
  spr(136+frame, playerx*16-12, playery, 1, 1, flips)
  print("score: "..score, 2, 2)
  print(" high: "..highscore, 2, 9)
 end
}) -- game 13
