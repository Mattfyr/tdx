if game.PlaceId == 9503261072 then
while true do
    task.wait(1.5)
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/refresh")
    task.wait(1.5)
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/start")
end
end