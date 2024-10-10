v1 = game:GetService("Players")
v2 = game:GetService("TextChatService")
v3 = v1.LocalPlayer

if game.PlaceId == 9503261072 then
    while true do
        v5 = v1:GetPlayers()
        v6 = false

        for _, player in ipairs(v5) do
            for _, name in ipairs(getgenv().v4) do
                if player.Name == name then
                    v6 = true
                    break
                end
            end
            if v6 then
                break
            end
        end

        if v6 or (#v5 == 1 and v5[1] == v3) then
            if not v3.PlayerGui.GUI.Leave.Visible then
                v2.TextChannels:WaitForChild("RBXGeneral"):SendAsync("/refresh")
            else
                v2.TextChannels:WaitForChild("RBXGeneral"):SendAsync("/start")
            end
        end
        task.wait(3)
    end
end