add(games,{
  name="game 1",author="tbd",par=1,
  _init=function(self)end,
  _update=function(self)if btnp45() then nextgame()end end,
  _draw=function(self) cls() print"push a button!" end,
})
