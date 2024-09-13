if game.PlaceId == 9503261072 then
    while true do
        if not game:GetService("Players").LocalPlayer.PlayerGui.GUI.Leave.Visible then
            game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):SendAsync("/refresh")
        else
            if game:GetService("Players").LocalPlayer.PlayerGui.GUI.Leave.Visible then
                game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):SendAsync("/start")
            end
        end
        task.wait(3)
    end
end