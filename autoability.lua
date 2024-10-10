if game.PlaceId == 11739766412 then
    local v1 = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local v2 = v1:CreateWindow({
        Name = "TDX Script Hub",
        LoadingTitle = "TDX Script Hub",
        LoadingSubtitle = "By newmattf",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "TDX",
            FileName = "Auto Ability"
        },
    })

    local v3 = v2:CreateTab("Auto Ability")
    local v4 = v3:CreateSection("Settings")

    local v5, v6, v7, v8, v9, v10 = false, false, false, false, false, false
    local v11 = false
    local v13 = 93000
    local v14 = 1

    local v15 = v3:CreateToggle({
        Name = "Toggle Auto Ability",
        CurrentValue = false,
        Flag = "ToggleAutoAbility",
        Callback = function(value)
            v5 = value
        end,
    })

    v3:CreateToggle({
        Name = "Use First Ability",
        CurrentValue = false,
        Flag = "FirstAbility",
        Callback = function(value)
            v6 = value
        end,
    })

    v3:CreateToggle({
        Name = "Use Second Ability",
        CurrentValue = false,
        Flag = "SecondAbility",
        Callback = function(value)
            v7 = value
        end,
    })

    v3:CreateToggle({
        Name = "Use Third Ability",
        CurrentValue = false,
        Flag = "ThirdAbility",
        Callback = function(value)
            v8 = value
        end,
    })

    v3:CreateToggle({
        Name = "Aim Artillery",
        CurrentValue = false,
        Flag = "Artillery",
        Callback = function(value)
            v9 = value
        end,
    })

    v3:CreateToggle({
        Name = "Strongest Targeting",
        CurrentValue = false,
        Flag = "Strongest",
        Callback = function(value)
            v10 = value
        end,
    })

    v3:CreateToggle({
        Name = "Use abilities only when enemy has more than picked health",
        CurrentValue = false,
        Flag = "UseAbilitiesOnlyWhenEnemyHasMoreThanHealth1",
        Callback = function(value)
            v11 = value
        end,
    })

    v3:CreateSlider({
        Name = "Use When Health Of Enemy",
        Range = {0, 1000000},
        Increment = 100,
        Suffix = "Health",
        CurrentValue = 93000,
        Flag = "UseAbilitiesOnlyWhenEnemyHasMoreThanHealth",
        Callback = function(value)
            v13 = value
        end,
    })

    v3:CreateSlider({
        Name = "Delay between using abilities",
        Range = {0, 10},
        Increment = 0.1,
        Suffix = "Seconds",
        CurrentValue = 1,
        Flag = "DelayTime",
        Callback = function(value)
            v14 = value
        end,
    })

    local v16 = game:GetService("Workspace").Game
    local v17 = v16.Towers
    local v18 = v16.Enemies
    local v19 = v16.Map.Path
    local v20 = v19.End
    local v21 = require(game.ReplicatedStorage.TDX_Shared.Common.ResourceManager)
    local v22 = 0

    while true do
        if v5 then
            local v23 = v17:GetChildren()
            local v24 = v18:GetChildren()
            local v25, v26 = nil, math.huge
            local v27, v28 = nil, -math.huge
            local v29 = false

            if #v23 > v22 then
                v22 = #v23
            end

            for _, v30 in ipairs(v24) do
                local v31 = v30.Position

                if v31 then
                    local v33 = v21.GetEnemyConfig(v30.Name)
                    local v34 = v33 and v33.Health or 0

                    if v11 then
                        if v34 > v13 then
                            v29 = true
                        end
                    else
                        v29 = true
                    end

                    if v10 then
                        if v34 > v28 then
                            v28 = v34
                            v27 = v31
                        end
                    else
                        local v35 = (v31 - v20.Position).Magnitude
                        if v35 < v26 then
                            v26 = v35
                            v25 = v31
                        end
                    end
                end
            end

            local v36 = v10 and v27 or v25
            if v36 and v29 then
                local v37 = v36
                local v38, v39 = nil, math.huge

                for _, v40 in ipairs(v16.Map.Zones.Path:GetChildren()) do
                    if v40.Name == "Part" then
                        local v41 = (v40.Position - v37).Magnitude
                        if v41 < v39 then
                            v39 = v41
                            v38 = v40
                        end
                    end
                end

                if v38 then
                    local v42 = Vector3.new(v37.X, v38.Position.Y, v37.Z)

                    if v9 then
                        for v43 = 1, v22 do
                            coroutine.wrap(function()
                                game:GetService("ReplicatedStorage").Remotes.RetargetTower:InvokeServer(v43, v42)
                            end)()
                        end
                    end

                    for v43 = 1, v22 do
                        coroutine.wrap(function()
                            if v6 then
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v43, 1, v42)
                            end
                            if v7 then
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v43, 2, v42)
                            end
                            if v8 then
                                game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v43, 3, v42)
                            end
                        end)()
                    end
                end
            end

            task.wait(v14)
        else
            task.wait(1)
        end
    end
end
