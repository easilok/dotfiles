-- The xmonad configuration of Derek Taylor (DistroTube)
-- http://www.youtube.com/c/DistroTube
-- http://www.gitlab.com/dwt1/

------------------------------------------------------------------------
---IMPORTS
------------------------------------------------------------------------
    -- Base
-- import XMonad
import XMonad hiding ( (|||) )  -- don't use the normal ||| operator
import XMonad.Config.Desktop
import Data.Monoid
import Data.Maybe (isJust)
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Utilities
import XMonad.Util.Loggers
import XMonad.Util.EZConfig (additionalKeysP, additionalMouseBindings, additionalKeys)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn, unsafeSpawn, runInTerm, spawnPipe)
import XMonad.Util.SpawnOnce

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksStartupHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat) 
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work
import XMonad.Hooks.InsertPosition
-- xmonad def { manageHook = insertPosition Below Newer <+> myManageHook }

    -- Actions
import XMonad.Actions.Minimize 
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.CopyWindow (kill1, copyToAll, killAllOtherCopies, runOrCopy)
import XMonad.Actions.WindowGo (runOrRaise, raiseMaybe)
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen, toggleWS) 
import XMonad.Actions.GridSelect
import XMonad.Actions.DynamicWorkspaces (addWorkspacePrompt, removeEmptyWorkspace)
import XMonad.Actions.MouseResize
import qualified XMonad.Actions.ConstrainedResize as Sqr

    -- Layouts modifiers
import XMonad.Layout.PerWorkspace (onWorkspace) 
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing (spacing) 
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import XMonad.Layout.LayoutCombinators   -- use the one from LayoutCombinators instead

    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.ZoomRow (zoomRow, zoomIn, zoomOut, zoomReset, ZoomMessage(ZoomFullToggle))
import XMonad.Layout.IM (withIM, Property(Role))
import XMonad.Layout.Minimize 
import qualified XMonad.Layout.BoringWindows as BW

    -- Prompts
import XMonad.Prompt (defaultXPConfig, XPConfig(..), XPPosition(Top), Direction1D(..))

------------------------------------------------------------------------
---CONFIG
------------------------------------------------------------------------
myFont          = "xft:Roboto:medium:pixelsize=10"
myModMask       = mod4Mask  -- Sets modkey to super/windows key
myTerminal      = "termite" -- Sets default terminal
myBrowser       = "brave"   -- Sets default browser
myTextEditor    = "vim"     -- Sets default text editor
myBorderWidth   = 1         -- Sets border width for windows
windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.xmonad/xmobar/xmobarrc0"
    -- xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.xmonad/xmobar/xmobarrc0"
    -- xmproc2 <- spawnPipe "xmobar -x 2 /home/dt/.config/xmobar/xmobarrc1"
    -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh desktopConfig
        -- { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
        { manageHook = insertPosition Below Newer <+> (isFullscreen --> doFullFloat) <+> myManageHook <+> manageHook desktopConfig <+> manageDocks
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc0 x  -- >> hPutStrLn xmproc1 x  >> hPutStrLn xmproc2 x
                        , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#F07178" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#d0d0d0" "" . shorten 80     -- Title of active window in xmobar
                        , ppSep =  "<fc=#9AEDFE> : </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook 
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = "#292d3e"
        , focusedBorderColor = "#bbc5ff"
        , focusFollowsMouse = False
        } `additionalKeysP`         myKeys

------------------------------------------------------------------------
---AUTOSTART
------------------------------------------------------------------------
myStartupHook = do
            spawnOnce "$HOME/.xmonad/autorun.sh"
          --spawnOnce "emacs --daemon &"
          --spawnOnce "nitrogen --restore &" 
          -- spawn "/home/luis/.config/awesome/autostart.sh" 
          --spawnOnce "exec /usr/bin/trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --transparent true --alpha 0 --tint 0x292d3e --height 19 &"
          --spawnOnce "/home/dt/.xmonad/xmonad.start" -- Sets our wallpaper
          
------------------------------------------------------------------------
---GRID SELECT
------------------------------------------------------------------------

myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                  (0x31,0x2e,0x39) -- lowest inactive bg
                  (0x31,0x2e,0x39) -- highest inactive bg
                  (0x61,0x57,0x72) -- active bg
                  (0xc0,0xa7,0x9a) -- inactive fg
                  (0xff,0xff,0xff) -- active fg
                  
-- gridSelect menu layout
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 30
    , gs_cellwidth    = 200
    , gs_cellpadding  = 4
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }
    
spawnGridSelector :: [(String, String)] -> X ()
spawnGridSelector lst = gridselect conf lst >>= flip whenJust spawn
    where conf = defaultGSConfig
    
------------------------------------------------------------------------
---WORKSPACES
------------------------------------------------------------------------

xmobarEscape = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]
        
wsList = map xmobarEscape $ ["1.\xf120", "2.\xf121", 
					"3.\xf1fe", "4.\xf269", 
					"5.\xf008", "6.\xf07c", 
					"7.\xf007", "8.\xf1d8", 
					"9.\xf044", "0.\xf49e"]

myNormalWorkspaces :: [String]   
-- myNormalWorkspaces = clickable . (map xmobarEscape) 
--                     $ wsList
myNormalWorkspaces = clickable wsList
  where                                                                      
        clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..9] l,                                        
                      let n = i ] 

-- myExtraWorkspaces = [("0", wsList !! 9)] -- list of (key, name)
myExtraWorkspacesList = [("0", wsList !! 9)] -- list of (key, name)

myExtraWorkspaces = clickable myExtraWorkspacesList
    where
        clickable l = ["<action=xdotool key super+" ++ show(n) ++ ">" ++ ws ++ "</action>" |
                      (n,ws) <- l ]

myWorkspaces :: [String]   
-- myWorkspaces = myNormalWorkspaces ++ (map snd myExtraWorkspaces) 
myWorkspaces = myNormalWorkspaces ++ myExtraWorkspaces 


------------------------------------------------------------------------
---KEYBINDINGS
------------------------------------------------------------------------
myKeys =
        [
    --- Xmonad
          ("M-C-r", spawn "xmonad --recompile")      -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")        -- Restarts xmonad
        , ("M-S-<F4>", io exitSuccess)                  -- Quits xmonad
        -- , ("M-0", windows $ W.greedyView (wsList !! 9))
        -- , ("M-S-0", windows $ W.shift (wsList !! 9))
        , ("M-0", windows $ W.greedyView (myExtraWorkspaces !! 0))
        , ("M-S-0", windows $ W.shift (myExtraWorkspaces !! 0))
    
    --- Windows
        , ("M-S-c", kill1)                           -- Kill the currently focused client
        , ("M-S-a", killAll)                         -- Kill all the windows on current workspace
     	, ("M-n", withFocused minimizeWindow)
       	, ("M-S-n", withLastMinimized maximizeWindowAndFocus)

    --- Floating windows
        , ("M-<Delete>", withFocused $ windows . W.sink)  -- Push floating window back to tile.
        , ("M-S-<Delete>", sinkAll)                  -- Push ALL floating windows back to tile.


    --- Grid Select
        , (("M-S-o"), spawnGridSelector
            [("Browser", myBrowser)
          , ("Gimp", "gimp")
          , ("LibreOffice Writer", "lowriter")
          , ("PCManFM", "pcmanfm")
          , ("Terminal", myTerminal)
          , ("Teams", "teams")
          , ("Element", "element-desktop")
          , ("VirtualBox", "virtualbox")
          , ("TrueStudio", "TrueSTUDIO")
          ])

        , ("M-S-g", goToSelected $ mygridConfig myColorizer)
        , ("M-S-b", bringSelected $ mygridConfig myColorizer)

    --- Windows navigation
        , ("M-m", windows W.focusMaster)             -- Move focus to the master window
        , ("M-j", windows W.focusDown)               -- Move focus to the next window
        -- , ("M-<Right>", windows W.focusDown)						 -- Move focus to the next windox
        , ("M-k", windows W.focusUp)                 -- Move focus to the prev window
        -- , ("M-<Left>", windows W.focusUp)						 -- Move focus to the prev windox
        -- , ("M-S-m", windows W.swapMaster)            -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)              -- Swap the focused window with the next window
        , ("M-S-k", windows W.swapUp)                -- Swap the focused window with the prev window
        , ("M-<Backspace>", promote)                 -- Moves focused window to master, all others maintain order
        -- , ("M1-S-<Tab>", rotSlavesDown)              -- Rotate all windows except master and keep focus in place
        -- , ("M1-C-<Tab>", rotAllDown)                 -- Rotate all the windows in the current stack
        , ("M-M1-s", windows copyToAll)  
        , ("M-C-s", killAllOtherCopies) 
        
        -- , ("M-C-M1-<Up>", sendMessage Arrange)
        -- , ("M-C-M1-<Down>", sendMessage DeArrange)
        -- , ("M-S-<Up>", sendMessage (IncreaseUp 10))       --  Increase size of focused window up
        -- , ("M-S-<Down>", sendMessage (IncreaseDown 10))   --  Increase size of focused window down
        -- , ("M-S-<Right>", sendMessage (IncreaseRight 10)) --  Increase size of focused window right
        -- , ("M-S-<Left>", sendMessage (IncreaseLeft 10))   --  Increase size of focused window left
        -- , ("M-C-<Up>", sendMessage (DecreaseUp 10))       --  Decrease size of focused window up
        -- , ("M-C-<Down>", sendMessage (DecreaseDown 10))   --  Decrease size of focused window down
        -- , ("M-C-<Right>", sendMessage (DecreaseRight 10)) --  Decrease size of focused window right
        -- , ("M-C-<Left>", sendMessage (DecreaseLeft 10))   --  Decrease size of focused window left

    --- Layouts
        , ("M-<Space>", sendMessage NextLayout)                              -- Switch to next layout
        , ("M-S-t", sendMessage ToggleStruts)                          -- Toggles struts
        , ("M-M1-n", sendMessage $ Toggle NOBORDERS)                          -- Toggles noborder
        , ("M-S-C-t", sendMessage (Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
        , ("M-S-f", sendMessage (T.Toggle "float"))
        , ("M-S-x", sendMessage $ Toggle REFLECTX)
        , ("M-S-y", sendMessage $ Toggle REFLECTY)
        , ("M-S-m", sendMessage $ Toggle MIRROR)
        , ("M-<KP_Multiply>", sendMessage (IncMasterN 1))   -- Increase number of clients in the master pane
        , ("M-<KP_Divide>", sendMessage (IncMasterN (-1)))  -- Decrease number of clients in the master pane
        , ("M-<F1>", sendMessage $ JumpToLayout "tall")
		, ("M-<F2>", sendMessage $ JumpToLayout "lay")
        , ("M-<F3>", sendMessage $ JumpToLayout "monocle")    
        -- , ("M-S-<KP_Multiply>", increaseLimit)              -- Increase number of windows that can be shown
        -- , ("M-S-<KP_Divide>", decreaseLimit)                -- Decrease number of windows that can be shown

        , ("M-C-h", sendMessage Shrink)
        , ("M-C-l", sendMessage Expand)
        , ("M-S-h", sendMessage (IncMasterN 1))
        , ("M-S-l", sendMessage (IncMasterN (-1)))
        , ("M-C-j", sendMessage MirrorShrink)
        , ("M-C-k", sendMessage MirrorExpand) -- This increase the height of client window
        , ("M-S-;", sendMessage zoomReset)    -- tgus decrease the height of client window
        , ("M-;", sendMessage ZoomFullToggle)

    --- Workspaces
        , ("M-C-<Right>", moveTo Next nonNSP)                                -- Go to next workspace
        , ("M-C-<Left>", moveTo Prev nonNSP)                           -- Go to previous workspace
        , ("M-S-<Right>", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next workspace
        , ("M-S-<Left>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to previous workspace
        , ("M-z", toggleWS)
        , ("M-.", nextScreen)  -- Switch focus to next monitor         
        , ("M-,", prevScreen)  -- Switch focus to prev monitor

    --- Scratchpads
        , ("M-C-<Return>", namedScratchpadAction myScratchPads "terminal")
        , ("M-C-S-c", namedScratchpadAction myScratchPads "speedcrunch")
        
    --- Open Terminal
        , ("M-<Return>", spawn myTerminal)

    --- My Dmenu
        , ("M-d", spawn "dmenu-simple")
        , ("M-S-d", spawn "dmenu-edit-configs")
        , ("M-S-s", spawn "dmenu-surfraw")
        , ("M-C-<Escape>", spawn "dmenu-power")

    --- My Applications (Super+Alt+Key)
        , ("M-C-x", spawn "betterlockscreen -l dim")
        , ("M-M1-e", spawn (myTerminal ++ " -e neomutt"))
        -- , ("M-M1-f", spawn (myTerminal ++ " -e sh ./.config/vifm/scripts/vifmrun"))
        -- , ("M-M1-i", spawn (myTerminal ++ " -e irssi"))

    --- Multimedia Keys
        , ("M-<F5>", spawn "pulsemixer --toggle-mute")
        , ("M-<F6>", spawn "pulsemixer --change-volume +5 --unmute")
        , ("M-<F7>", spawn "pulsemixer --change-volume -5 --unmute")
        , ("M-<F9>", spawn "playerctl play-pause")
        , ("M-<F10>", spawn "playerctl previous")
        , ("M-<F11>", spawn "playerctl next")
        , ("<XF86AudioMute>",   spawn "pulsemixer --toggle-mute")  -- Bug prevents it from toggling correctly in 12.04.
        , ("<XF86AudioMicMute>",   spawn "pulsemixer --id source-1 --toggle-mute")
        , ("<XF86AudioLowerVolume>", spawn "pulsemixer --change-volume -5 --unmute")
        , ("<XF86AudioRaiseVolume>", spawn "pulsemixer --change-volume +5 --unmute")
        ] where nonNSP          = WSIs (return (\ws -> W.tag ws /= "nsp"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))
                
myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     [
        className =? "Firefox"					--> doShift (myWorkspaces !! 3)
      , className =? "firefox"					--> doShift (myWorkspaces !! 3)
      , className =? "Navigator"				--> doShift (myWorkspaces !! 3)
      , className =? "Firefox-esr"			    --> doShift (myWorkspaces !! 3)
      , className =? "qutebrowser"			    --> doShift (myWorkspaces !! 3)
      , className =? "Qutebrowser"			    --> doShift (myWorkspaces !! 3)
      , className =? "vivaldi-stable"		    --> doShift (myWorkspaces !! 3)
      , className =? "Vivaldi-stable"		    --> doShift (myWorkspaces !! 3)
      , className =? "brave-browser"		    --> doShift (myWorkspaces !! 3)
      , className =? "Brave-browser"		    --> doShift (myWorkspaces !! 3)
      , className =? "Qutebrowser"			    --> doShift (myWorkspaces !! 3)
      , className =? "pcmanfm"					--> doShift (myWorkspaces !! 5)
      , className =? "Pcmanfm"					--> doShift (myWorkspaces !! 5)
      , className =? "remmina"					--> doShift (myWorkspaces !! 7)
      , className =? "Remmina"					--> doShift (myWorkspaces !! 7)
      , className =? "telegram-desktop"         --> doFloat
      , className =? "TelegramDesktop"	        --> doFloat
      , className =? "speedcrunch"			    --> doFloat
      , className =? "SpeedCrunch"			    --> doFloat
      , className =? "skype"					--> doFloat
      , className =? "Skype"					--> doFloat
      , className =? "mpv"						--> doFloat
      , className =? "Xfce4-appfinder"			--> doFloat
      , className =? "vlc"	            		--> doFloat
      -- , className =? "microsoft teams - preview"	--> (doIgnore <+> doFullFloat)
      -- , className =? "Microsoft Teams - Preview"	--> (doIgnore <+> doFullFloat)
      , appName	  =? "Microsoft Teams Notification" --> (doIgnore <+> doFullFloat)
	  , title	  =? "Microsoft Teams Notification" --> (doIgnore <+> doFullFloat)
      , className =? "Gimp"							--> doShift (myWorkspaces !! 8)
      , className =? "Inkscape"					    --> doShift (myWorkspaces !! 8)
	  , className =? "stalonetray"                  --> doIgnore
      , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat  -- Float Firefox Dialog
      , (className =? "Gimp" <&&> resource =? "Dialog") --> doFloat  -- Float GIMP Dialog
      , (className =? "brave-browser" <&&> role =? "pop-up") --> doFloat  -- pop-up brave Dialog
      , (className =? "Brave-browser" <&&> role =? "pop-up") --> doFloat  -- pop-up brave Dialog
	  , isDialog									--> doF W.swapUp
	  , isFullscreen                                --> (doF W.focusDown <+> doFullFloat)
     ] <+> namedScratchpadManageHook myScratchPads
         where role = stringProperty "WM_WINDOW_ROLE"

------------------------------------------------------------------------
---LAYOUTS
------------------------------------------------------------------------

myLayoutHook = smartBorders $ avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $ 
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where 
                 myDefaultLayout = tall ||| lay ||| grid ||| oneBig ||| minimized ||| noBorders monocle ||| floats
                 -- myDefaultLayout = tall ||| grid ||| threeCol ||| threeRow ||| oneBig ||| noBorders monocle ||| space ||| floats


tall       = renamed [Replace "tall"]     $ limitWindows 6 $ spacing 2 $ ResizableTall 1 (3/100) (1/2) []
lay        = renamed [Replace "lay"]			$ limitWindows 6 $ spacing 2 $ Mirror (ResizableTall 1 (3/100) (1/2) [])
grid       = renamed [Replace "grid"]     $ limitWindows 6 $ spacing 2 $ mkToggle (single MIRROR) $ Grid (16/10)
-- threeCol   = renamed [Replace "threeCol"] $ limitWindows 3  $ ThreeCol 1 (3/100) (1/2) 
-- threeRow   = renamed [Replace "threeRow"] $ limitWindows 3  $ Mirror $ mkToggle (single MIRROR) zoomRow
oneBig     = renamed [Replace "oneBig"]   $ limitWindows 6  $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (5/9) (8/12)
monocle    = renamed [Replace "monocle"]  $ limitWindows 20 $ Full
-- space      = renamed [Replace "space"]    $ limitWindows 4  $ spacing 5 $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
floats     = renamed [Replace "floats"]   $ limitWindows 20 $ simplestFloat
minimized   = renamed [Replace "minimize"] $ (Tall 1 (3/100) (1/2))

------------------------------------------------------------------------
---SCRATCHPADS
------------------------------------------------------------------------

myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "speedcrunch" spawnSpeed findSpeed manageSpeed  
                ]

    where
    spawnTerm  = myTerminal ++  " -n scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnSpeed	= "speedcrunch"
    findSpeed   = resource =? "speedcrunch"
    manageSpeed = customFloating $ W.RationalRect l t w h
                 where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
