local screen = {guiGetScreenSize()}
local notificationData = {}
local font = dxCreateFont("RobotoB.ttf", 13)
local iconFont = dxCreateFont("FontAwesome.otf", 18)

function createNotification (text,type)
	if (text and type) then
		if (#notificationData >= 8) then return end
		table.insert(notificationData,
			{
				text = text,
				type = type,
				state = "animIn",
				currentTick = getTickCount(),
				endTick = 0,
				currentY = -31
			}
		)

		soundType = "success"

		if (type == "success") then
			soundType = "success"
		elseif (type == "error") then
			soundType = "warning"
		elseif (type == "info") then
			soundType = "success"
		elseif (type == "warning") then
			soundType = "warning"
		elseif (type == "admin") then
			soundType = "success"
		end

		sound = playSound("sounds/"..soundType..".mp3")
		setSoundVolume(sound,0.6)
	end
end
addEvent("createNotification", true)
addEventHandler("createNotification", root, createNotification)

function notificationRender ()
	for k, v in pairs(notificationData) do
		if (v["state"] == "animIn") then
			local animProgress = (getTickCount() - v["currentTick"]) / 800
			local animationState = interpolateBetween(-31, 0, 0, 30, 0, 0, animProgress, "OutBounce")
				
			if (animationState) then
				v["currentY"] = animationState
			else
				v["currentY"] = 30
			end
				
			if (animProgress > 1) then
				v["currentTick"] = getTickCount()
				v["endTick"] = getTickCount()
				v["state"] = "fix"

				setTimer(function()
					v["currentTick"] = getTickCount()
					v["state"] = "animOut"
				end, string.len(v["text"]) * 45 + 5000, 1)
			end
		elseif (v["state"] == "fix") then
			v["currentY"] = 30
		elseif (v["state"] == "animOut") then
			local animProgress = (getTickCount() - v["currentTick"]) / 600
			local animationState = interpolateBetween(30, 0, 0, -31, 0, 0, animProgress, "InQuad")
				
			if (animationState) then
				v["currentY"] = animationState
			else
				v["currentY"] = -31
			end
				
			if (animProgress > 1) then
				notificationData[k] = nil
			end
		end

		local percentage = 100
		if (v["endTick"] ~= 0) then
			if (v["state"] == "animOut") then
				percentage = 0
			else
				percentage = 100-((getTickCount() - v["endTick"])/(string.len(v["text"]) * 45 + 5000))*100
			end
		end

		local szin = {255,255,255}

		local icon = ""
		if (v["type"] == "success") then
			szin = {100, 214, 70}
			icon = ""
		elseif (v["type"] == "error") then
			szin = {214, 62, 62}
			icon = ""
		elseif (v["type"] == "info") then
			szin = {62, 120, 214}
			icon = ""
		elseif (v["type"] == "warning") then
			szin = {207, 192, 60}
			icon = ""
		elseif (v["type"] == "admin") then
			szin = {68, 149, 179}
			icon = ""
		end

		dxDrawRectangle(screen[1]/2-(dxGetTextWidth(v["text"],1,font,false)+20)/2,v["currentY"]*(k)+((k-1)*5),dxGetTextWidth(v["text"],1,font,false)+20,30,tocolor(20,20,20,150),true)
		dxDrawRectangle(screen[1]/2-(dxGetTextWidth(v["text"],1,font,false)+20)/2,v["currentY"]*(k)+((k-1)*5),(dxGetTextWidth(v["text"],1,font,false)+20),3,tocolor(0,0,0,100),true)
		dxDrawRectangle(screen[1]/2-(dxGetTextWidth(v["text"],1,font,false)+20)/2,v["currentY"]*(k)+((k-1)*5),(dxGetTextWidth(v["text"],1,font,false)+20)/100*percentage,3,tocolor(szin[1],szin[2],szin[3],255),true)
		dxDrawText(v["text"],screen[1]/2-(dxGetTextWidth(v["text"],1,font,false)+20)/2,v["currentY"]*(k)+((k-1)*5)+2,dxGetTextWidth(v["text"],1,font,false)+20+screen[1]/2-(dxGetTextWidth(v["text"],1,font,false)+20)/2,v["currentY"]*(k)+((k-1)*5)+30,tocolor(255,255,255,255),1,font,"center","center",false,false,true,true)
	end
end
addEventHandler("onClientRender", root, notificationRender)