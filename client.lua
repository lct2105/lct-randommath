RegisterNetEvent("lct-randommath:client:ShowMath", function(theQuestion, thePrize, theTime)
    SendNUIMessage({ 
        action = 'sendpopup',
        title = '📣 RANDOM MATH QUESTION',
        message = 'Question: <span style ="color:yellow;"><strong>'..theQuestion..'</strong></span><br>Prize: <span style = "color:rgb(102, 245, 66);"><strong>'..thePrize..'$</span></strong><br><br>Press T and enter your answer, be the earliest to receive a prize',
        timeout = theTime,
    })
end)


RegisterNetEvent("lct-randommath:client:ShowInfo", function(text)
    SendNUIMessage({ 
        action = 'sendpopup',
        title = '📣 RANDOM MATH QUESTION',
        message = text,
        timeout = 5000,
    })
end)



