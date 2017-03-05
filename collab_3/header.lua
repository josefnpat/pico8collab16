pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--collab16 cart 3 v%%git_count%%
--1 cart 16 devs so little space!

cartdata"pico8collab163"

state_welcome = {
  _init = function()
    speedrun_srand = 1
    speedrun_game_count = 0
    speedrun_record = dget(0) == 0 and 9999 or dget(0)
    speedrun_current = 0
    speedrun_games={}
    for i,game in pairs(games) do
      game._record = dget(i) == 0 and 9999 or dget(i)
      game._current = 0
      add(speedrun_games,game)
    end
  end,
  _draw = function()
    cls()
    speedrun_art()
    color"10"
    print("\n\n\n\n\n\ncollab16 cart 3\nspeedrun")
    color"9"
    print("time to beat: "..speedrun_record)
    color"7"
  end,
  _update = function()
    srand(speedrun_srand)
    speedrun_srand += 1
    if btnp45() then
      nextgame()
    end
  end
}

state_getready = {
  _init = function()
    speedrun_getready = 90
  end,
  _update = function()
    speedrun_getready -= 1
    if speedrun_getready <= 0 then
      switch_state(state_game)
    end
  end,
  _draw = function()
    cls()
    speedrun_art()

    -- game iconspeedrun_game.icon
    spr(16*flr(speedrun_game.icon/8+2)+speedrun_game.icon%8,0,64)

    print("\n\n\n\n\n\ncurrent time: "..speedrun_current..
    "\ngame "..speedrun_game_count.." of 16\nget ready!\n"..
    speedrun_game.author.." wants you to play:\n\n"..
    "   "..speedrun_game.name..
    "\n\npar: "..speedrun_game.par..
    "\nrecord: "..speedrun_game._record)
    print(stringrep("*",flr(speedrun_getready/6)))
  end
}

state_game = {
  _init = function()
    cls()
  end,
  _update = function()
    speedrun_game._current += 1/30
    speedrun_game:_update()
  end,
  _draw = function()
    speedrun_game:_draw()
  end
}

state_results = {
  _init = function()
    speedrun_results = 1
    if speedrun_record == 0 then
      dset(0,speedrun_current)
    else
      dset(0,min(speedrun_current,speedrun_record))
    end
    for i,game in pairs(games) do
      if game._record == 0 then
        dset(i,game._current)
      else
        dset(i,min(game._record,game._current))
      end
    end
  end,
  _update = function()
    speedrun_results -= 1/30
    if speedrun_results <= 0 and btnp45() then
      run()
    end
  end,
  _draw = function()
    cls()
    print("results")
    for i,game in pairs(games) do
      if game._current < game._record then
        color"11"
      else
        color"8"
      end
      print(i..": "..game._current.." ("..game._record..")")
    end
    if speedrun_current < speedrun_record then
      color"11"
    else
      color"8"
    end
    print("\nyour time: "..speedrun_current..
    "\nrecord: "..speedrun_record)
    color"6"
  end
}

speedrun_art=function()
  sspr(0,0,64,32,32,0)
end

btnp45=function()
 return btnp"4" or btnp"5"
end

stringrep = function(char,n)
  local str = ""
  for i = 1,n do
    str = str .. char
  end
  return str
end

nextgame=function()
  if(speedrun_game) speedrun_current += speedrun_game._current

  speedrun_game = speedrun_games[flr(rnd(#speedrun_games))+1]
  del(speedrun_games, speedrun_game)
  speedrun_game_count += 1

  if speedrun_game then
    switch_state(state_getready)
  else
    switch_state(state_results)
  end
end

function switch_state(state)
  current_state = state
  state:_init()
end

function _init()
  switch_state(state_welcome)
end

function _update()
  current_state:_update()
end

function _draw()
  current_state:_draw()
end

games = {}
