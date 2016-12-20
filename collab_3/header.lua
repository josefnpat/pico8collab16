pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--collab16 cart 3 v%%git_count%%
--1 cart 16 devs so little space!

cartdata"pico8collab163"

state_welcome = {
  _init = function()
    speedrun_srand = 1
    speedrun_game = 1
    speedrun_record = dget(0) == 0 and 9999 or dget(0)
    speedrun_current = 0
    games_rand = {}
    for i,game in pairs(games) do
      game._record = dget(i) == 0 and 9999 or dget(i)
      game._current = 0
      add(games_rand,game)
    end
    for i,game in pairs(games_rand) do
      local swap = flr(rnd()*(#games_rand))+1
      games_rand[i],games_rand[swap] = games_rand[swap],games_rand[i]
    end
  end,
  _draw = function()
    cls()
    color"10"
    print("\n\n\ncollab16 cart 3")
    print("speedrun")
    color"9"
    print("time to beat: "..speedrun_record)
    color"7"
    speedrun_art()
  end,
  _update = function()
    srand(speedrun_srand)
    speedrun_srand += 1
    if btnp45() then
      switch_state(state_getready)
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
    spr(games_rand[speedrun_game],128-8,0)
    print("\n\n\ncurrent time: "..speedrun_current)
    print("game "..speedrun_game.." of "..#games)
    print("get ready!")
    print(games_rand[speedrun_game].author.." wants you to play")
    print(games_rand[speedrun_game].name)
    print("par: "..games_rand[speedrun_game].par)
    print("record: "..games_rand[speedrun_game]._record)
    print(stringrep("*",flr(speedrun_getready/6)))
    speedrun_art()
  end
}

state_game = {
  _init = function()
    cls()
  end,
  _update = function()
    games_rand[speedrun_game]._current += 1/30
    games_rand[speedrun_game]:_update()
  end,
  _draw = function()
    games_rand[speedrun_game]:_draw()
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
    print("\nyour time: "..speedrun_current)
    print("record: "..speedrun_record)
    color"6"
  end
}

speedrun_art=function()
  sspr(0,0,32,16,0+32,0)
  sspr(0,16,32,16,32+32,0)
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
  speedrun_current += games_rand[speedrun_game]._current
  speedrun_game += 1
  if games_rand[speedrun_game] then
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
