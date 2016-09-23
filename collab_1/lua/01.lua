pickitty = {
  author = "josefnpat",
  name = "pickitty",
  _init = function()
    score = 0
    food = {}
    fooddt = 0
    foodt = 2
    count = 0
    sprite = 20
  end,
  _draw = function()
    count += 1
    frame = flr(count/10)%2
    cls()
    print("score:"..score.."\nbest:"..dget(0,best))
    spr(sprite+frame,28,96)
    for i,v in pairs(food or {}) do
      spr(
        (v.t < 4 and 36 or 52-4)+v.t,
        v.x,
        (v.y or 96)+32*sin((v.x-32)/96/2)
      )
    end
    if not food then
      print"\n\n\n\n\ng a m e   o v e r\n\nreset cart for new game"
    end
  end,
  _update = function()
    if food then
      fooddt -= 1/30
      if fooddt < 0 then
        fooddt = rnd()+foodt
        add(food,{x=128,t=flr(rnd"8")})
        foodt = max(0.125,foodt - 1/25)
      end
    end
    for i,v in pairs(food or {}) do
      v.x -= 1
      if v.y then
        v.y -= 10
        if v.x < 0 then
          del(food,v)
        end
      else
        if v.x < 48 then

          if btn"5" or btn"4" then
            if v.t < 4 then
              score -= 1
              sfx"0"
            else
              score += 1
              sfx"2"
            end
            v.y = 96
            sprite = 20
          end

          if v.x < 32 then
            del(food,v)
            if v.t < 4 then
              sfx"2"
              score += 1
              sprite = 22
            else
              sfx"3"
              dset(0,max(score,dget"0"))
              food = nil
              sprite = 4
            end
          end

        end

      end
    end
  end
}
add(games,pickitty)
