pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--1 cart 16 devs so little space!
--september, 2016, with love

cgame = {
  _draw = function(self)
    cls()
    sspr(0,0,32,32,32,32,64,64)
    local x = self.sel%4-1
    local y = flr(self.sel/4)
    local rx = 64+(x-1)*16-1
    local ry = 64+(y-2)*16-1
    color"1"
    rect(rx,ry,rx+17,ry+17)
    color"7"
    rect(rx-1,ry-1,rx+18,ry+18)
    local cur = games[self.sel+1]
    spr(104,32,8,8,2)
    --color"8"
    --cursor(37,24)
    --print"pico8-collab16"
    color"7"
    cursor(32,97)
    if cur then
      print("game: "..cur.name.."\nauthor: "..cur.author)
    end
    cursor(0,0)
    color"15"
  end,
  _update = function(self)
    self.sel = self.sel or 0
    if btnp"0" then self.sel -= 1 sfx"0" end
    if btnp"1" then self.sel += 1 sfx"0" end
    if btnp"2" then self.sel -= 4 sfx"0" end
    if btnp"3" then self.sel += 4 sfx"0" end
    self.sel %= 16
    if btnp"4" then self.sel = flr(rnd"16") sfx"2" end
    if btnp"5" and games[self.sel+1] then
      sfx"1"
      cgame = games[self.sel+1]
      if cgame._init then cgame:_init() end
    end
  end,
}

cartdata"pico8collab16"

function _draw() if cgame._draw then cgame:_draw() end end
function _update() if cgame._update then cgame:_update() end end

games = {}

