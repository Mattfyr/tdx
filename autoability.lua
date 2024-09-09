local v1 = game:GetService("Workspace").Game
local v2 = v1.Towers
local v3 = v1.Enemies
local v4 = v1.Map.Path
local v5 = v4.Spawn1
local v6 = v4.End
local v7 = v4:FindFirstChild("PathHighlight") and v4.PathHighlight:FindFirstChild("Part") 
    or v1.Map:FindFirstChild("Zones") and v1.Map.Zones:FindFirstChild("Path") and v1.Map.Zones.Path:FindFirstChild("Part")
    or v1.Map:FindFirstChild("PathHighlight") and v1.Map.PathHighlight:FindFirstChild("Cube.002")

local v8 = 0

while true do
    local v9 = v2:GetChildren()
    local v10 = #v9
    local v11 = v3:GetChildren()
    local v12
    local v13 = math.huge

    if v10 > v8 then
        v8 = v10
    end

    for _, v14 in ipairs(v11) do
        if v14:FindFirstChild(v14.Name) and v14[v14.Name]:FindFirstChild("Root") then
            local v15 = v14[v14.Name].Root.Position
            local v16 = (v15 - v6.Position).magnitude

            if v16 < v13 then
                v13 = v16
                v12 = v14[v14.Name]
            end
        end
    end

    if v12 then
        local v17 = v12.Root.Position
        local v17_CFrame = CFrame.new(Vector3.new(v17.X, v7.Position.Y, v17.Z))
        local v17_Vector3 = Vector3.new(v17.X, v7.Position.Y, v17.Z)

        for v19 = 1, v8 do
            if _G.Artillery then
            game:GetService("ReplicatedStorage").Remotes.RetargetTower:InvokeServer(v19, v17_CFrame)
            end
            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v19, 1)
            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v19, 2)
            if _G.CommanderAirstrike then
            game:GetService("ReplicatedStorage").Remotes.TowerUseAbilityRequest:InvokeServer(v19, 3, v17_Vector3)
        end
    end
end
task.wait(1)
end