
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require "composer"
print 'toto'


function zozo( str,int )
    --local library = require "plugin.library"
    --return "C est coule mec : " .. library.getstr(str)
end

print (zozo('hiu', 555))


-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )



if ( system.getInfo("platformName") == "Android" ) then
        --local androidVersion = string.sub( system.getInfo( "platformVersion" ), 1, 3)
        --if( androidVersion and tonumber(androidVersion) >= 4.4 ) then
        --native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
        --native.setProperty( "androidSystemUiVisibility", "lowProfile" )
        --elseif( androidVersion ) then
        print 'Android'
        native.setProperty( "androidSystemUiVisibility", "default" )
        --end
end




-- include Corona's "widget" library
--local DgltCards = require "DgltCards"
--local DgltViewCards = require ("DgltCards-view")
--local DgltGlobals = require ("DgltGlobals")

composer.gotoScene( "menuscreen" )




