local QBCore = exports['qb-core']:GetCoreObject()

-- VARIABLES
local mathOn = false 
local theAnswer = nil 
local thePrize = nil
local theQuestion = nil 
local currentTimer = 0

-- THREAD 
CreateThread(function() 
    while true do 
        Wait(500)
        if not mathOn then 
            makeRandomCode()
        end 
        Wait(180000) -- CREATE RANDOM MATH EVERY 180s
    end 
end)

CreateThread(function()
    while true do 
        if mathOn then
            local newTimer = GetGameTimer()
            if newTimer - currentTimer >= cfg.mathTime*1000 then
                Wait(50)
                -- DELETE THE MATH AFTER THE TIME GIVEN IF NO ONE ANSWERED CORRECTLY
                TriggerClientEvent("lct-randommath:client:ShowInfo", -1, 'Sorry, no one answered the question correctly. The correct answer is <span style="color:rgb(255, 102, 0);">['..theAnswer..']</span>')
                removeMath()
            end
        end
        Wait(0)
    end 
end)

-- FUNCTIONS
function createMath(theQuestion, theAnswer, thePrize)
    TriggerClientEvent("lct-randommath:client:ShowMath", -1, theQuestion, thePrize, cfg.mathTime*1000)
	mathOn = true
    currentTimer = GetGameTimer()
	theAnswer = theAnswer
	theQuestion = theQuestion
end 

function makeRandomCode()
    if not mathOn then 
        theQuestion, theAnswer =  makeMath(cfg.maxNum)
        thePrize = math.random(cfg.minPrize,cfg.maxPrize)
        if ( tostring(theAnswer) and tostring(theQuestion) and tonumber(thePrize) ) then
            createMath(theQuestion, theAnswer, thePrize)
        end
    end 
end 



function removeMath()
    currentTimer = 0
    theAnswer = nil
	thePrize = nil
	theQuestion = nil
	mathOn = false
end 

-- FORMAT OF THE MATH QUESTION
function makeMath(maxNum)
    local Num_1 = math.floor(math.random(maxNum))
    local Num_2 = math.floor(math.random(maxNum))
    local Num_3 = math.floor(math.random(maxNum))
    local Num_4 = math.floor(math.random(maxNum))
    local Random_Difficult = math.random(1, 3)

    if Random_Difficult == 1 then 
        if tonumber(Num_1) and tonumber(Num_2) then
            local Random_Math = math.random(1, 2)
            if Random_Math == 1 then 
                theAnswer = tonumber(Num_1)+tonumber(Num_2)
                theQuestion = ""..tonumber(Num_1).." + "..tonumber(Num_2)..""
            else 
                theAnswer = tonumber(Num_1)-tonumber(Num_2)
                theQuestion = ""..tonumber(Num_1).." - "..tonumber(Num_2)..""
            end 
        end 
    elseif Random_Difficult == 2 then 
        if tonumber(Num_1) and tonumber(Num_2) and tonumber(Num_3) and tonumber(Num_4) then
            local Random_Math = math.random(1, 3)
            if Random_Math == 1 then 
                theAnswer = tonumber(Num_1)*tonumber(Num_2)
                theQuestion = ""..tonumber(Num_1).." x "..tonumber(Num_2)..""
            elseif Random_Math == 2 then 
                theAnswer = (tonumber(Num_1)*tonumber(Num_2))+tonumber(Num_3)
                theQuestion = ""..tonumber(Num_1).." x "..tonumber(Num_2).." + "..tonumber(Num_3)..""
            else 
                theAnswer = (tonumber(Num_1)*tonumber(Num_2))-tonumber(Num_3)-tonumber(Num_4)
                theQuestion = ""..tonumber(Num_1).." x "..tonumber(Num_2).." - "..tonumber(Num_3).." - "..tonumber(Num_4)..""
            end 
        end
    else
        if tonumber(Num_1) and tonumber(Num_2) and tonumber(Num_3) and tonumber(Num_4) then
            local Random_Math = math.random(1, 4)
            if Random_Math == 1 then 
                theAnswer = tonumber(Num_1)*tonumber(Num_2)*tonumber(Num_3)*tonumber(Num_4)
                theQuestion = ""..tonumber(Num_1).." x "..tonumber(Num_2).." x "..tonumber(Num_3).." x "..tonumber(Num_4)..""
            elseif Random_Math == 2 then 
                theAnswer = (tonumber(Num_1)*tonumber(Num_2))+(tonumber(Num_3)*tonumber(Num_4))
                theQuestion = ""..tonumber(Num_1).." x "..tonumber(Num_2).." + "..tonumber(Num_3).." x "..tonumber(Num_4)..""
            else 
                theAnswer = (tonumber(Num_1)*tonumber(Num_2)*tonumber(Num_3))-tonumber(Num_4)
                theQuestion = ""..tonumber(Num_1).." x "..tonumber(Num_2).." x "..tonumber(Num_3).." - "..tonumber(Num_4)..""
            end 
        end
    end 

    if theAnswer and theQuestion then 
        return theQuestion, theAnswer
    end 
end

RegisterServerEvent('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end
    detectAnswerFromChat(message)
end)

function detectAnswerFromChat(message)
	if (mathOn and message) then
		if tonumber(message) == tonumber(theAnswer) then
			onPlayerWin()
		end
	end
end

function onPlayerWin()
    local Player = QBCore.Functions.GetPlayer(source)
    local playerName = Player.PlayerData.charinfo.firstname
    TriggerClientEvent("lct-randommath:client:ShowInfo", -1, 'Congratulations to the player '..playerName..' for the fastest reply with the answer <span style="color:rgb(255, 102, 0);">['..theAnswer..']</span> and won with the prize <span style="color:rgb(102, 245, 66);">'..thePrize..'$</span>')
    Player.Functions.AddMoney("cash", thePrize)
	removeMath()
end




