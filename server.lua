local webhookURL = "https://discord.com/api/webhooks/1333592963053518922/-6JQtdfZzv43vGH6LB4SmWKspLNmv-q65fvormft_vevfPG2Mj2JwoJZO0qTTI97XBXo" -- Replace with your Discord Webhook URL

AddEventHandler("chatMessage", function(source, name, message)
    if not message or message == "" then return end
    
    local playerId = source
    local discordId = "Not Linked"
    
    for _, identifier in ipairs(GetPlayerIdentifiers(source)) do
        if string.find(identifier, "discord:") then
            discordId = "<@" .. string.sub(identifier, 9) .. ">"
            break
        end
    end
    
    local embed = {
        {
            ["color"] = 16711680,  -- Red color
            ["title"] = "Chat Logs",
            ["fields"] = {
                { ["name"] = "Player Name", ["value"] = name, ["inline"] = true },
                { ["name"] = "Player ID", ["value"] = tostring(playerId), ["inline"] = true },
                { ["name"] = "Discord", ["value"] = discordId, ["inline"] = false },
                { ["name"] = "Message", ["value"] = message, ["inline"] = false }
            },
            ["footer"] = { ["text"] = "FiveM Chat Logs" },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
    
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({username = "Chat Logger", embeds = embed}), { ['Content-Type'] = 'application/json' })
end)
