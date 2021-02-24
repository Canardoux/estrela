

local FOOTER_HEIGHT = 35
local MARGIN = 3
local SCORE_HEIGHT = 22
local STATUS_HEIGHT = 10
local BTN_WIDTH = 70
local STACK_HEIGHT = 13
local QUESTION_HEIGHT = 80
local CHECK_WIDTH = 50
local CHECK_BTN_SIZE = 15
local GRAM_WIDTH = 40
local EXAMPLE_HEIGHT = 80
local ANSWER_HEIGHT = 92


local widget = require "widget"
local composer = require "composer"
local globals = require 'DgltGlobals'
local flutterEngine = require 'estrela.flutter.engine'
local flutterLib = require 'estrela.flutter'
local scene = composer.newScene()

--local library = require "plugin.library"

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Hide the status bar
----display.setStatusBar( display.HiddenStatusBar )
    local parambtn =
    {
        id = 'myBtn',
        x = 0,
        y = 0,
        label = 'totox',
        labelAlign = 'center',
        emboss = true,
        labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
        textOnly = false,
        --defaultFile="button2.png",
        --overFile="button2-down.png",
        width = display.contentWidth/2 - 4*MARGIN,
        height = FOOTER_HEIGHT - 4* MARGIN ,
        fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } },
        --strokeColor = { default={ 0, 1, 0 }, over={ 0.4, 0.1, 0.2 } },
        --strokeWidth = FOOTER_HEIGHT - 2*MARGIN,
        shape = 'roundedRect',
        --onPress=onFirstView,
        --selected=true
    }

nullFn= function ()
    print('NULL\n')
end,

-- Set the background to white
display.setDefault( "background", 1 )    -- white

-- Require the widget & Composer libraries

    local halfW = display.contentCenterX
    local halfH = display.contentCenterY
    local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)

    -- Create title bar at top of the screen
    local titleGradient = {
        type = 'gradient',
        color1 = { 189/255, 203/255, 220/255, 1 },
        color2 = { 89/255, 116/255, 152/255, 1 },
        direction = "down"
    }

local backgroundGrp = display.newGroup()
    sceneGroup:insert( backgroundGrp )
    --backgroundGrp.y =50

    local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
    background:setFillColor( 0.5, 0.5, 1 )  -- lila
    backgroundGrp:insert( background )

    local top = 0
    if ( system.getInfo("platformName") ~= "macos") and  (system.getInfo("platformName") ~= "win32") then
        top = STATUS_HEIGHT
    end


    -- Create the two BrowseFooters for Teacher
    -- Create the two BrowseFooters for regular student
    local totalWidth = display.contentWidth - 4 * MARGIN

    CenterGrp = display.newGroup()
    backgroundGrp:insert(CenterGrp)
    CenterGrp.x = display.contentWidth / 2
    CenterGrp.y =  display.contentHeight /2
    parambtn.id = 'plus1'
    parambtn.label = counter
    parambtn.onPress= function()
        counter = counter + 1
        local currScene = composer.getSceneName( "current" )
        composer.gotoScene( currScene )
    end

    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local btn = widget.newButton( parambtn )
    CenterGrp:insert (btn)


    TeacherBrowseFooterGrp = display.newGroup()
    backgroundGrp:insert(TeacherBrowseFooterGrp)

    TeacherBrowseFooterGrp.x = MARGIN/2
    TeacherBrowseFooterGrp.y =  display.contentHeight  - (FOOTER_HEIGHT ) + 2 * MARGIN - MARGIN/2
    local TeacherBrowseFooterPanel = display.newRect( display.contentCenterX - MARGIN/2, 0,     display.contentWidth - (2 * MARGIN),     2 * FOOTER_HEIGHT - 5 * MARGIN)
    TeacherBrowseFooterPanel:setFillColor( 0, 0, 0.3 )
    TeacherBrowseFooterGrp:insert(TeacherBrowseFooterPanel)

    TeacherBrowse1FooterGrp= display.newGroup()
    TeacherBrowse1FooterGrp.x = MARGIN + MARGIN/2 -- Hack ?
    TeacherBrowse1FooterGrp.y =  (-FOOTER_HEIGHT /2 + MARGIN + MARGIN/2) -- Hack ?
    TeacherBrowseFooterGrp:insert(TeacherBrowse1FooterGrp)

    TeacherBrowse2FooterGrp= display.newGroup()
    TeacherBrowse2FooterGrp.x =  MARGIN + MARGIN/2 -- Hack ?
    TeacherBrowse2FooterGrp.y =    (FOOTER_HEIGHT /2 - MARGIN - MARGIN/2)
    TeacherBrowseFooterGrp:insert(TeacherBrowse2FooterGrp)

    parambtn.id = 'Dyglot'
    parambtn.label = 'Dyglot'
    parambtn.x =  totalWidth/10
    parambtn.onPress=nullFn
       --parambtn.onPress=function() composer.gotoScene( "DgltCards-view" ); end
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local firstBtn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(firstBtn)

    parambtn.id = 'Flutter'
    parambtn.label = 'Flutter'
    parambtn.x =  totalWidth/10+ totalWidth/5
    parambtn.onPress=nullFn
       --parambtn.onPress=function() library.show( "FUCK!!!!" ); end
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local firstBtn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(firstBtn)

    parambtn.id = 'Dyna'
    parambtn.label = 'Dyna'
    parambtn.x =  totalWidth/10 + 2*totalWidth/5
    parambtn.onPress=nullFn
       --parambtn.onPress=DgltCards.OnM50Pressed
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local m50Btn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(m50Btn)

    parambtn.id = 'Show'
    parambtn.label = 'Show'
    parambtn.x =  totalWidth/10 + 3*totalWidth/5
    parambtn.onPress=function() flutterEngine.show( "zozo" ); end
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local p50Btn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(p50Btn)

    parambtn.id = 'Swap'
    parambtn.label = 'Swap'
    parambtn.x =  totalWidth/10 + 4*totalWidth/5
    parambtn.onPress=function() flutterLib.swap( ); end
    parambtn.width = totalWidth/5 -  MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local lastBtn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(lastBtn)

    --

    parambtn.id = 'Pop'
    parambtn.label = 'Pop'
    parambtn.x =  totalWidth/10
    parambtn.onPress=function() flutterLib.pop( ); end
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local subBtn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(subBtn)

    parambtn.id = 'Push'
    parambtn.label = 'Push'
    parambtn.x =  totalWidth/10 + totalWidth/5
    parambtn.onPress=function() flutterLib.push( ); end
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local gotoLeft2Btn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(gotoLeft2Btn)

    parambtn.id = 'modal'
    parambtn.label = 'Modal'
    parambtn.x =  totalWidth/10 + 2*totalWidth/5
    parambtn.onPress=function() flutterLib.modal( ); end
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local lookupBtn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(lookupBtn)

    parambtn.id = 'TagBtn2'
    parambtn.label = ''
    parambtn.x =  totalWidth/10 + 3*totalWidth/5
    parambtn.onPress=nullFn
    parambtn.width = totalWidth/5 - MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local tag2Btn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(tag2Btn)

    parambtn.id = 'GotoRight2'
    parambtn.label = ''
    parambtn.x =  totalWidth/10 + 4*totalWidth/5
    parambtn.onPress=nullFn
    parambtn.width = totalWidth/5 -  MARGIN
    parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
    local gotoRight2Btn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(gotoRight2Btn)



 end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
-- -----------------------------------------------------------------------------------

return scene
