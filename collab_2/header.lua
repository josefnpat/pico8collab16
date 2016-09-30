pico-8 cartridge // http://www.pico-8.com
version 8
__lua__
--collab16 cart n, date
--1 cart 16 devs so little space!

cartdata"pico8collab162"
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

cameralib = {
  new = function(init)
    init = init or {}
    local self = {}
    self.z = init.z or -3
    self.focallength = init.focallength or 5
    self.fov = init.fov or 45
    self.theta = init.theta or 0
    self.width = init.width or 128
    self.height = init.height or 128
    -- public
    self.line = cameralib.line
    self.point = cameralib.point
    -- private
    self._perspective = cameralib._perspective
    self._tan = cameralib._tan
    self._coordstopx = cameralib._coordstopx
    self._map = cameralib._map
    return self
  end,
  line = function(self, p1, p2)
    local px_1 = self:_coordstopx(self:_perspective(p1))
    local px_2 = self:_coordstopx(self:_perspective(p2))
    line(px_1[1], px_1[2], px_2[1], px_2[2])
  end,
  point = function(self, p)
    local px = self:_coordstopx(self:_perspective(p))
    pset(px[1],px[2])
  end,
  _perspective = function(self, p)
    local x,y,z = p[1],p[2],p[3]
    local x_rot = x * cos(self.theta) - z * sin(self.theta)
    local z_rot = x * sin(self.theta) + z * cos(self.theta)
    local dz = z_rot - self.z
    local out_z = self.z + self.focallength
    local m_xz = x_rot / dz
    local m_yz = y / dz
    local out_x = m_xz * out_z
    local out_y = m_yz * out_z
    return { out_x, out_y }
  end,
  _map = function(v, a, b, c, d)
    local partial = (v - a) / (b - a)
    return partial * (d - c) + c
  end,
  _tan = function(v)
    return sin(v) / cos(v)
  end,
  _coordstopx = function(self,coords)
    local x = coords[1]
    local y = coords[2]
    local radius = self.focallength * self._tan(self.fov / 2 / 360)
    local pixel_x = self._map(x, -radius, radius, 0, self.width)
    local pixel_y = self._map(y, -radius, radius, 0, self.height)
    return { pixel_x, pixel_y }
  end
}
