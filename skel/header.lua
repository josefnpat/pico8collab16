pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--collab16 cart n, date
--1 cart 16 devs so little space!

cartdata"pico8collab16"
function _draw() if cgame._draw then cgame:_draw() end end
function _update() if cgame._update then cgame:_update() end end

games = {}

menu = {
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
    --spr(104,32,8,8,2)
    color"8"
    cursor(33,24)
    print"pico8-collab16-2"
    color"7"
    cursor(32,97)
    print("game: "..cur.name.."\nauthor: "..cur.author)
    cursor(0,0)
    color"10"
    for i = 0,15 do
      if games[i+1] and games[i+1].win then
        cursor(i%4*16+33,flr(i/4)*16+33)
        print"\146"
      end
    end
  end,
  _update = function(self)
    self.sel = self.sel or 0
    if btnp"0" then self.sel -= 1 sfx"0" end
    if btnp"1" then self.sel += 1 sfx"0" end
    if btnp"2" then self.sel -= 4 sfx"0" end
    if btnp"3" then self.sel += 4 sfx"0" end
    self.sel %= 16
    if btnp"5" or btnp"4" then
      sfx"1"
      cgame = games[self.sel+1]
      if cgame._init then cgame:_init() end
    end
  end,
}
cgame = menu

function win()
  cgame.win = true
  cgame = menu
end

function lose()
  cgame = menu
end
