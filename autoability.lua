local v1 = game:GetService("Workspace"):WaitForChild("Game")
local v2 = v1:WaitForChild("Towers")
local v3 = v1:WaitForChild("Enemies")
local v4 = v1:WaitForChild("Map"):WaitForChild("Path")
local v5 = v4:WaitForChild("Spawn1")
local v6 = v4:WaitForChild("End")
local v7 = v4:FindFirstChild("PathHighlight") and v4.PathHighlight:FindFirstChild("Part") 
    or v1.Map:FindFirstChild("Zones") and v1.Map.Zones:FindFirstChild("Path") and v1.Map.Zones.Path:FindFirstChild("Part")
    or v1.Map:FindFirstChild("PathHighlight") and v1.Map.PathHighlight:FindFirstChild("Cube.002")
local v8 = require(game.ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common"):WaitForChild("ResourceManager"))
local v9 = 0

while true do
    local v10 = v2:GetChildren()
    local v11 = #v10
    local v12 = v3:GetChildren()
    local v13
    local v14 = math.huge
    local v15 = -math.huge

    if v11 > v9 then
        v9 = v11
    end

    for _, v16 in ipairs(v12) do
        if v16:FindFirstChild(v16.Name) and v16[v16.Name]:FindFirstChild("Root") then
            if _G.Strongest then
                local v17 = v8.GetEnemyConfig(v16.Name)
                local v18 = v17 and v17.Health or 0

                if v18 > v15 then
                    v15 = v18
                    v13 = v16[v16.Name]
                end
            else
                local v19 = v16[v16.Name].Root.Position
                local v20 = (v19 - v6.Position).magnitude
                if v20 < v14 then
                    v14 = v20
                    v13 = v16[v16.Name]
                end
            end
        end
    end

    if v13 then
        local v21 = v13.Root.Position
        local v22 = CFrame.new(v21.X, v7.Position.Y, v21.Z)
        local v23 = Vector3.new(v21.X, v7.Position.Y, v21.Z)

        for v24 = 1, v9 do
            if _G.Artillery then
                game:GetService("ReplicatedStorage").Remotes.RetargetTower:InvokeServer(v24, v23)
            end
            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v24, 1, v23)
            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v24, 2, v23)
            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v24, 3, v23)
        end
    end
    if _G.Artillery then
        task.wait(0.5)
    end
    task.wait(1)
end