add(games, {
 name = "pikoban",
 author = "iko",

 ---------------------------------------
 -------------------------------- init
 _init = function(self)

  ----------------------------
  --------------------- vars
  cubes = {}
  playerfacing, curlevel = 101, 0

  ----------------------------------------------
  -------------------------- internal functions

  getspritecoords, drawthing, loadlevel =

  --------------------------------
  function(i)--getspritecoords
   
   if i==101 or i==102 then --player
    return 46,49,5,15
   elseif i>102 then --player 
    return 51,49,5,15
   elseif i==5 then         --floor
    return 32,49,14,9
   elseif i<4 then --cube
    return 32,32,17,17
   end
   --elseif i==4 then --ramps
    return 49,32,15,17
   --end

  end,

  --------------------------------
  function(x,y,n)--drawthing
   
   --xy to iso
   local finalx, finaly = 56 + 8*x - 8*y, 24 + 4*x + 4*y
   local sx, sy, sw, sh = getspritecoords(n)

   finaly -= sh

   if n<4 then finalx -=1 finaly -=1 end

   if n > 100 then
    finalx += 5 
    finaly -= 2
    if playerh then finaly -= 10 end
   end --correct player coords

   if n == 2 then
    pal(7,15)
    pal(6,9)
    pal(13,4)
   end 

   --draw
   sspr(sx,sy,sw,sh,finalx,finaly,sw,sh,
    n == 102 or n == 103)--flipx

   pal()

   --doorway to exit
   if n==3 then 
    sspr(56,49,8,15,finalx+8,finaly-12)
   end 
  end,

  -------------------------------- 
  function(lvl) --loadlevel

   playerx, playery, playerh, curlevel = 8, 8, false, lvl

   for x=1, 8 do
    cubes[x] = {}
    for y=1, 8 do
     cubes[x][y] = mget((lvl%4)*8+x+31,flr(lvl/4)*8+y-1)
    end
   end
  end

  --menuitem(1,"restart level",function() loadlevel(curlevel) end)

  loadlevel(0)

 end,
 ----------------------------------------------
 -------------------------------- draw
 _draw = function()

 ----------------------------------------------
 -------------------------------- update
 --_update = function()

  local deltax, deltay  = 0, 0

  if     btnp "0" then deltax -= 1 playerfacing = 103
  elseif btnp "1" then deltax += 1 playerfacing = 101 
  elseif btnp "2" then deltay -= 1 playerfacing = 104
  elseif btnp "3" then deltay += 1 playerfacing = 102 
  elseif btnp "5" then loadlevel(curlevel) end --restart button

  local intendedx, intendedy, moveplayerintended = 
   mid(1,playerx+deltax,8),
   mid(1,playery+deltay,8),  
   false

  local intendedcubeindex = cubes[intendedx][intendedy]

  --collisions

  if intendedcubeindex==4 and deltay!=0 then --ramp y (both levels)

   playery, playerh = intendedy+deltay, not playerh

  elseif playerh then --level above 

   moveplayerintended = intendedcubeindex<3 

   --level up!
   if intendedcubeindex==3 then
    loadlevel(curlevel+1)
   end

  else --level ground
  
   if intendedcubeindex==5 then --walk into nothing

    moveplayerintended = true

   elseif intendedcubeindex==2 then --walk into movecube

    local intplusx, intplusy = intendedx+deltax, intendedy+deltay

    if intplusx < 9 and intplusx > 0 and
       intplusy < 9 and intplusy > 0 and
       cubes[intplusx][intplusy] == 5 then

     cubes[intplusx][intplusy] = 2
     cubes[intendedx][intendedy] = 5
     moveplayerintended = true

    end
   end
  end

  if moveplayerintended then
   playerx, playery = intendedx, intendedy 
  end

  --end,--update

  cls()

  print(curlevel<15 and "picoban           level "..curlevel or "!congratulations the end!",13,0,13)

  for x=1,8 do for y=1,8 do
    drawthing(x,y,cubes[x][y])

   if x==playerx and y==playery then
    drawthing(playerx,playery,playerfacing)
    end

  end end --end x,y
   
 end,
}
)
