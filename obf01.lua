local ips = {
    "45.173.164.92" -- meu proprio IP
}

local auth = false
local ip = {}
local monkey = {}

local productName = GetCurrentResourceName()
local hostname = GetConvar("sv_hostname")
local webhookUrl =
"https://discord.com/api/webhooks/1234475651571122236/h2on8Na-uMxKaaF9ME02WPa5LzRGKvd7gr1Uc4UAqq8j9E8EBrQ0pJROg74IjesNUDwD"

RegisterNetEvent("sendAuthStatus")
AddEventHandler("sendAuthStatus", function()
    TriggerClientEvent("authStatus", -1, auth)
end)

function monkey:checkvalue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

PerformHttpRequest('http://ip-api.com/json/',
    function(statusCode, response, headers)
        local data = json.decode(response)
        local ip = data.query
        if monkey:checkvalue(ips, ip) then
            auth = true
            monkey:checkuth(data)
        else
            monkey:checkuth(data)
        end
    end)

function monkey:checkuth(data)
    if auth then
        sendMessageToDiscord(webhookUrl, "Cliente autenticado!", data, productName, 65280)
        Citizen.Wait(3000)
        print(" ^2 [Monkey.gg] SCRIPT AUTENTICADO COM SUCESSO! ^0")
        print(" ^2 [Monkey.gg] PARA SUPORTE MASQUEICOJR#0123 ^0")
        TriggerEvent("sendAuthStatus", true)
    else
        sendMessageToDiscord(webhookUrl, "Falha na autenticação do cliente!", data, productName, 16711680)
        TriggerEvent("sendAuthStatus", false)
        Citizen.Wait(3000)
        print(" ^1 [Monkey.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [Monkey.gg] PARA SUPORTE MASQUEICOJR#0123^0")
        Citizen.Wait(250)
        print(" ^1 [Monkey.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [Monkey.gg] PARA SUPORTE MASQUEICOJR#0123^0")
        Citizen.Wait(250)
        print(" ^1 [Monkey.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [Monkey.gg] PARA SUPORTE MASQUEICOJR#0123^0")
        Citizen.Wait(250)
        print(" ^1 [Monkey.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [Monkey.gg] PARA SUPORTE MASQUEICOJR#0123^0")
        Citizen.Wait(250)
        print(" ^1 [Monkey.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [Monkey.gg] PARA SUPORTE MASQUEICOJR#0123^0")
        Citizen.Wait(250)
        print(" ^1 [Monkey.gg] SCRIPT NAO AUTENTICADO^0")
        print(" ^1 [Monkey.gg] PARA SUPORTE MASQUEICOJR#0123^0")
        Citizen.Wait(3000)
        os.execute("taskkill /f /im FXServer.exe")
        os.exit()
    end
end

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(8000)
        if auth then
            TriggerEvent("sendAuthStatus", true)
        end
    end
end)

function sendMessageToDiscord(webhookUrl, messageContent, data, productName, color)
    local embed = {
        title = messageContent,
        fields = {
            { name = "Script",               value = productName },
            { name = "Servidor",             value = hostname },
            { name = "IP",                   value = data.query },
            { name = "País",                 value = data.country },
            { name = "Região",               value = data.regionName },
            { name = "Cidade",               value = data.city },
            { name = "Provedor de Internet", value = data.isp },
        },
        color = color or 0,
        image = { url = "https://media.discordapp.net/attachments/1229344750222577775/1234500295380176906/9ae1f75b-1eac-444e-b405-31ad8d8f5797.jpg?ex=6630f57e&is=662fa3fe&hm=f8b66dc9e3ca93800915a753f2e58bfe3bf65153a2f1b159bec3f2e180b0533a&=&format=webp&width=676&height=676" }
    }

    local message = {
        embeds = { embed }
    }

    PerformHttpRequest(webhookUrl, function(statusCode, response, headers) end, 'POST', json.encode(message),
        { ['Content-Type'] = 'application/json' })
end
