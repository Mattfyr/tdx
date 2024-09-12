if game.PlaceId == 9503261072 then
while true do
    task.wait(1.5)
    game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):SendAsync("/refresh")
    task.wait(2)
    game:GetService("TextChatService").TextChannels:WaitForChild("RBXGeneral"):SendAsync("/start")
end
end