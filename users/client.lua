
local screenWidth, screenHeight = guiGetScreenSize()

local page = "http://mta/users/index.html"
local initBrowser = guiCreateBrowser(0, 0, screenWidth, screenHeight, true, false, false)
local theBrowser = guiGetBrowser(initBrowser)
addEventHandler("onClientBrowserCreated", theBrowser, 
	function()
		loadBrowserURL(source, page)
		showCursor(true)	
        startIntro()
	end
)

addEvent("onClientPlayerLogin", true)
addEventHandler("onClientPlayerLogin", root,
	function()
		destroyElement(initBrowser)
		showCursor(false)
		destroyElement(IntroSong)
	end
)

function cmsg(email, username, password)
	triggerServerEvent("register", getLocalPlayer(), getLocalPlayer(), email, username, password)
end
addEvent("cmsg", true)
addEventHandler("cmsg", root, cmsg)

function ssj(username, password)
	triggerServerEvent("login", getLocalPlayer(), getLocalPlayer(), username, password)
end
addEvent("ssj", true)
addEventHandler("ssj", root, ssj)


function cm(cod)
	if (cod == "gu") then
		destroyElement(initBrowser)
	    showCursor(false)
		destroyElement(IntroSong)
	end
end
addEvent("cm", true)
addEventHandler("cm", root, cm)

function startIntro()
	if isElement(IntroSong) then destroyElement(IntroSong) end
	IntroSong = playSound("intro.MP3")
	setSoundVolume(IntroSong, 0.5)
end