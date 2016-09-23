bubble_rush = {
  author = "misato",
  name = "bubble rush",
  _init = function(self)
    power_up_counter = 50
    score = 0
    status_counter = 0
    score_counter = 10
    player = {
      x = 62,
      y = 110,
      status = 1
    }
    enemy_speed = 1
    enemy_list = {}
    power_up_list = {}
    lasttime = time()
  end,

  _update = function(self)

      local new_entity = function()
        return {
            x = flr(rnd(120)),
            y = -8
        }
      end

      local spawn = function(list)
        add(list,new_entity())
      end

      local update_enemies = function()
        for enemy in all(enemy_list) do
            enemy.y += enemy_speed
            if enemy.y > 128 then
                del(enemy_list,enemy)
            end
        end
      end

      local player_size = function()
        if (player.status == 1) return 5
        return 5 + player.status
      end

      local player_intersects = function(entity,size)
        return entity.x < player.x + player_size() and player.x < entity.x + size
            and entity.y < player.y + player_size() and player.y < entity.y + size
      end

      local update_power_ups = function()
        for power_up in all(power_up_list) do
            power_up.y += enemy_speed
            if power_up.y > 128 then
                del(power_up_list, power_up)
            else
                if player_intersects(power_up, 3) then
                    score += 5
                    del(power_up_list, power_up)
                    sfx(20)
                    if player.status < 3 then
                        player.status += 1
                    end
                end
            end
        end
      end

      local handle_player_input = function()
        if btn(0) then
            player.x -= 1
            if player.x < 0 then
                player.x = 0
            end
        end
        if btn(1) then
            player.x += 1
            if player.x > 128-player_size() then
                player.x = 128-player_size()
            end
        end
        if btn(2) then
            player.y -= 1
            if player.y < 0 then
                player.y = 0
            end
        end
        if btn(3) then
           player.y += 1
            if player.y > 128 then
                player.y = 128
            end
        end
      end

      local update_status = function()
        status_counter += 1
        if status_counter == 20 then
            status_counter = 0
        end
      end


    local game_over = function()
        sfx(23)

        for enemy in all(enemy_list) do
            del(enemy_list, enemy)
        end

        for power_up in all(power_up_list) do
            del(power_up_list, power_up)
        end

        power_up_counter = 50
        score = 0
        status_counter = 0
        score_counter = 10

        player.x = 62
        player.y = 110
        player.status = 1

        enemy_speed = 1
      end

     local check_collisions = function()
        for enemy in all(enemy_list) do
            if player_intersects(enemy,8) then
                if player.status > 1 then
                    sfx(21)
                    player.status -= 1
                else
                    game_over()
                end
            end
        end
      end

    local update_game = function()
        if time() - lasttime > 0.1 then
            enemy_speed += 0.01
            spawn(enemy_list)
            lasttime = time()
        end

        power_up_counter += 1
        if power_up_counter > 50 then
            power_up_counter = 0
            spawn(power_up_list)
        end

        update_enemies()
        handle_player_input()

        if status_counter == 0 then
            check_collisions()
        else
            update_status()
        end
        update_power_ups()
      end

    update_game()
    update_game()
  end,

  _draw = function(self)
    cls()
    rectfill(0,0,128,128,1)
    for enemy in all(enemy_list) do
        spr(75,enemy.x, enemy.y)
    end

    for power_up in all(power_up_list) do
        spr(88, power_up.x, power_up.y)
    end

    spr(71+player.status, player.x, player.y)
    print(score, 2,2,7)
  end
}
add(games, bubble_rush)
