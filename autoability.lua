if game.PlaceId == 11739766412 then
    local v32 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sigmanic/ROBLOX/main/ModificationWallyUi", true))()
local v33 = v32:CreateWindow("TDX Auto Ability")
v33:Section("Toggle Auto Ability")
v33:Toggle("Auto Ability", {flag = "AutoAbility", default = true})
v33:Section("Settings")
v33:Toggle("Aim Artillery", {flag = "Artillery", default = true})
v33:Toggle("Strongest Targetting", {flag = "Strongest", default = true})
v33:Section("Use When Health Of Enemy")
v33:TypeBox("Use When Health Of Enemy", {flag = "UseAbilitiesOnlyWhenEnemyHasMoreThanHealth", default = 1000})
v33:Section("Artillery Reload Time")
v33:TypeBox("Artillery Reload Time", {flag = "ArtilleryReloadTime", default = 0.2})
    local v1 = game:GetService("Workspace").Game
    local v2 = v1.Towers
    local v3 = v1.Enemies
    local v4 = v1.Map.Path
    local v5 = v4.Spawn1
    local v6 = v4.End
    local v7 = require(game.ReplicatedStorage.TDX_Shared.Common.ResourceManager)
    local v8 = 0

    while true do
        if v33.flags.AutoAbility then
        local v9 = v2:GetChildren()
        local v10 = #v9
        local v11 = v3:GetChildren()
        local v12 = nil
        local v13 = math.huge
        local v14 = -math.huge
        local v15 = false
        local v16 = nil
        local v17 = math.huge

        if v10 > v8 then
            v8 = v10
        end

        for _, v18 in ipairs(v11) do
            local v19 = nil
            local v20 = v18:GetDescendants()

            for _, v21 in ipairs(v20) do
                if v21:IsA("Part") and (v21.Name == "Root" or v21.Name == "RootPart") then
                    v19 = v21
                    break
                end
            end

            if v19 then
                local v22 = v7.GetEnemyConfig(v18.Name)
                local v23 = v22 and v22.Health or 0

                if v33.flags.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth then
                    if v23 > (tonumber(v33.flags.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth) or v33.flags.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth == "" and 1000) then
                        v15 = true
                    end                    
                end

                if v33.flags.Strongest then
                    if v23 > v14 then
                        v14 = v23
                        v12 = v19
                    end
                else
                    local v24 = v19.Position
                    local v25 = (v24 - v6.Position).Magnitude
                    if v25 < v13 then
                        v13 = v25
                        v12 = v19
                    end
                end
            end
        end

        if v12 then
            local v26 = v12.Position

            for _, v27 in ipairs(v1.Map.Zones.Path:GetChildren()) do
                if v27.Name == "Part" then
                local v28 = (v27.Position - v26).Magnitude
                if v28 < v17 then
                    v17 = v28
                    v16 = v27
                end
            end
        end

            if v16 then
                local v29 = CFrame.new(v26.X, v16.Position.Y, v26.Z)
                local v30 = Vector3.new(v26.X, v16.Position.Y, v26.Z)

                if v33.flags.Artillery then
                    for v31 = 1, v8 do
                        coroutine.wrap(function()
                            game:GetService("ReplicatedStorage").Remotes.RetargetTower:InvokeServer(v31, v30)
                        end)()
                    end
                end

                if v33.flags.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth then
                    if v15 then
                        for v31 = 1, v8 do
                            coroutine.wrap(function()
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v31, 1, v30)
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v31, 2, v30)
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v31, 3, v30)
                            end)()
                        end
                    end
                else
                    for v31 = 1, v8 do
                        coroutine.wrap(function()
                            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v31, 1, v30)
                            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v31, 2, v30)
                            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v31, 3, v30)
                        end)()
                    end
                end
            end
        end

        if v33.flags.ArtilleryReloadTime then
            task.wait(v33.flags.ArtilleryReloadTime)
        else
            task.wait(1)
        end
    else
        task.wait(1)
    end
end
end