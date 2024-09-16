if game.PlaceId == 11739766412 then
    local v1 = game:GetService("Workspace").Game
    local v2 = v1.Towers
    local v3 = v1.Enemies
    local v4 = v1.Map.Path
    local v5 = v4.Spawn1
    local v6 = v4.End
    
    local v7 = require(game.ReplicatedStorage.TDX_Shared.Common.ResourceManager)
    local v8 = 0

    while true do
        local v9 = v2:GetChildren()
        local v10 = #v9
        local v11 = v3:GetChildren()
        local v12
        local v13 = math.huge
        local v14 = -math.huge
        local v15 = false
        local v16 = nil
        local v17 = math.huge

        if v10 > v8 then
            v8 = v10
        end

        for _, v18 in ipairs(v11) do
            if v18:FindFirstChild(v18.Name) and v18[v18.Name]:FindFirstChild("Root") then
                local v19 = v7.GetEnemyConfig(v18.Name)
                local v20 = v19 and v19.Health or 0

                if _G.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth then
                    if v20 > (_G.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth or 30000) then
                        v15 = true
                    end
                end

                if _G.Strongest then
                    if v20 > v14 then
                        v14 = v20
                        v12 = v18[v18.Name]
                    end
                else
                    local v21 = v18[v18.Name].Root.Position
                    local v22 = (v21 - v6.Position).Magnitude
                    if v22 < v13 then
                        v13 = v22
                        v12 = v18[v18.Name]
                    end
                end
            end
        end

        if v12 then
            local v23 = v12.Root.Position

            for _, v24 in ipairs(v1.Map.Zones.Path:GetChildren()) do
                local v25 = (v24.Position - v23).Magnitude
                if v25 < v17 then
                    v17 = v25
                    v16 = v24
                end
            end

            if v16 then
                local v26 = CFrame.new(v23.X, v16.Position.Y, v23.Z)
                local v27 = Vector3.new(v23.X, v16.Position.Y, v23.Z)

                if _G.Artillery then
                    for v28 = 1, v8 do
                        coroutine.wrap(function()
                            game:GetService("ReplicatedStorage").Remotes.RetargetTower:InvokeServer(v28, v27)
                        end)()
                    end
                end

                if _G.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth then
                    if v15 then
                        for v28 = 1, v8 do
                            coroutine.wrap(function()
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v28, 1, v27)
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v28, 2, v27)
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v28, 3, v27)
                            end)()
                        end
                    end
                else
                    for v28 = 1, v8 do
                        coroutine.wrap(function()
                            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v28, 1, v27)
                            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v28, 2, v27)
                            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v28, 3, v27)
                        end)()
                    end
                end
            end
        end

        if _G.Artillery then
            task.wait(0.2)
        else
            task.wait(1)
        end
    end
end