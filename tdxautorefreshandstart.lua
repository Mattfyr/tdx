while true do
    task.wait(1.5)
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/refresh")
    task.wait(1.5)
    game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("/start")
end