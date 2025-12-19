local max_supply_modifier = 1.0

function setup_scenario (simulation)
end

function setup_player (simulation, player)
end

function post_game_load (simulation)

    for key,value in pairs(simulation) do
        print("found simulation member " .. key);
    end

    for index, player in pairs(simulation.players) do
        if not player.is_human then

            for key,value in pairs(player) do
                print("found player member " .. key);
            end

--             player:set_max_supply(max_supply_modifier)
        end
    end
end

