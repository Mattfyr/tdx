if game.PlaceId == 11739766412 then
    local v1 = game:GetService("Workspace").Game
    local v2 = v1.Towers
    local v3 = v1.Enemies
    local v4 = v1.Map.Path
    local v5 = v4.Spawn1
    local v6 = v4.End
    print("got start and end of the map")
    local v7 = v4:FindFirstChild("PathHighlight") and v4.PathHighlight:FindFirstChild("Part") 
        or v1.Map:FindFirstChild("Zones") and v1.Map.Zones:FindFirstChild("Path") and v1.Map.Zones.Path:FindFirstChild("Part")
        or v1.Map:FindFirstChild("PathHighlight") and v1.Map.PathHighlight:FindFirstChild("Cube.002")
        or v1.Map:FindFirstChild("Zones") and v1.Map.Zones:FindFirstChild("Path") and v1.Map.Zones.Path:FindFirstChild("path1")
    
    print("got path")
    local v8 = require(game.ReplicatedStorage.TDX_Shared.Common.ResourceManager)
    local v9 = 0
    while true do
        print("running loop")
        local v10 = v2:GetChildren()
        local v11 = #v10
        local v12 = v3:GetChildren()
        local v13
        local v14 = math.huge
        local v15 = -math.huge
        local v16 = false
    
        if v11 > v9 then
            v9 = v11
            print("changed number of towers")
        end
    
        for _, v17 in ipairs(v12) do
            if v17:FindFirstChild(v17.Name) and v17[v17.Name]:FindFirstChild("Root") then
                print("found enemy")
                local v18 = v8.GetEnemyConfig(v17.Name)
                local v19 = v18 and v18.Health or 0
    
                if _G.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth then
                    if v19 > (_G.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth or 30000) then
                        v16 = true
                        print("enemy with more than health")
                    end
                end
    
                if _G.Strongest then
                    print("strongest is true")
                    if v19 > v15 then
                        v15 = v19
                        v13 = v17[v17.Name]
                        print("changed targetting to strongest")
                    end
                else
                    print("no strongest")
                    local v20 = v17[v17.Name].Root.Position
                    local v21 = (v20 - v6.Position).magnitude
                    print("got end of the base")
                    if v21 < v14 then
                        v14 = v21
                        v13 = v17[v17.Name]
                        print("changed targetting to first enemy")
                    end
                end
            end
        end
    
        if v13 then
            print("v13 is true")
            local v22 = v13.Root.Position
            local v23 = CFrame.new(v22.X, v7.Position.Y, v22.Z)
            local v24 = Vector3.new(v22.X, v7.Position.Y, v22.Z)
    
            if _G.Artillery then
                print("artillery is true")
                for v25 = 1, v9 do
                    game:GetService("ReplicatedStorage").Remotes.RetargetTower:InvokeServer(v25, v24)
                    print("fired artillery remote")
                end
            end
    
            if _G.UseAbilitiesOnlyWhenEnemyHasMoreThanHealth then
                print("useabilities is true")
                if v16 then
                    print("v16 is true")
                    for v25 = 1, v9 do
                        game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v25, 1, v24)
                        game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v25, 2, v24)
                        game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v25, 3, v24)
                        print("fired remotes")
                    end
                end
            else
                for v25 = 1, v9 do
                    game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v25, 1, v24)
                    game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v25, 2, v24)
                    game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v25, 3, v24)
                    print("fired remotes 2")
                end
            end
        end
    
        if _G.Artillery then
            print("artillery is true, changed task wait to 0.5")
            task.wait(0.5)
        else
            print("isnt true, changed to 1")
            task.wait(1)
        end
    end
end