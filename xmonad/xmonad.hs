import Data.List
import qualified Data.Map        as M
import Graphics.X11.ExtraTypes.XF86

import XMonad

import qualified XMonad.StackSet as W

import qualified XMonad.Actions.ConstrainedResize as SQR
import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote
import qualified XMonad.Actions.FlexibleResize as FlexR
import XMonad.Actions.GridSelect
import XMonad.Actions.Warp
import XMonad.Actions.WindowMenu

import XMonad.Config.Desktop (desktopLayoutModifiers)

import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog

import XMonad.Layout.NoBorders
import XMonad.Layout.ShowWName
import XMonad.Layout.Tabbed

import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt (XPConfig(..), XPPosition(..), defaultXPConfig)
import XMonad.Prompt.Man
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Ssh
import XMonad.Prompt.Window

import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Scratchpad
import XMonad.Util.Run
import XMonad.Util.WorkspaceCompare

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset
        safeSpawn "notify-send" [show name, "workspace " ++ idx]

myModMask :: KeyMask
myModMask = mod4Mask

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1-emacs", "2-shell", "3-web", "4-fm", "5", "6", "7-ssh",
                "8-vms", "9-mail"]

myTerminal = "urxvtc"

myXmobarPP h = xmobarPP
               { ppOutput = hPutStrLn h
               , ppCurrent = xmobarColor "#f8f8f8" "DodgerBlue4" . wrap " " " "
               , ppVisible = xmobarColor "#f8f8f8" "LightSkyBlue4" . wrap " " " "
               , ppUrgent = xmobarColor "#f8f8f8" "red4" . wrap " " " " . xmobarStrip
               , ppLayout = wrap " |" "" . xmobarColor "DarkOrange" "" . wrap " [" "] "
               , ppTitle = xmobarColor "#61ce3c" "" . shorten 50
               , ppSort = fmap (.scratchpadFilterOutWorkspace) getSortByIndex
               , ppSep = ""
               , ppWsSep = " | "
               }

myManageHook :: ManageHook
myManageHook = scratchpadManageHookDefault <+>composeAll (
    [ manageHook defaultConfig
    , className =? "Firefox"           --> doShift "3-web"
    , className =? "luakit"            --> doShift "3-web"
    , className =? "Emacs"             --> doShift "1-emacs"
    , className =? "Geary"             --> doShift "9-mail"
    , className =? "Thunar"            --> doShift "4-fm"
    , className =? "trayer"            --> doIgnore
    , className =? "stalonetray"       --> doIgnore
    ])

myKeys conf@(XConfig {XMonad.modMask = myModMask}) = M.fromList
             [ ((myModMask, xK_F1),                manPrompt myXPConfig)

             , ((myModMask, xK_g),                 windowPromptGoto myXPConfig { autoComplete = Just 500000, searchPredicate = myFinder, alwaysHighlight = True })
             , ((myModMask .|. shiftMask, xK_g),   windowPromptBring myXPConfig { autoComplete = Just 500000, searchPredicate = myFinder, alwaysHighlight = True })
             , ((myModMask, xK_s),                 goToSelected defaultGSConfig)
             , ((myModMask, xK_o ),                windowMenu)
             , ((myModMask .|. controlMask, xK_h), sshPrompt myXPConfig)

             , ((myModMask, xK_z             ), warpToWindow (0.5) (0.5))

             , ((myModMask .|. shiftMask, xK_p), spawn "xboomx -nb '#000000' -nf '#DCDCCC' -sb '#000000' -sf '#CC5500'")
             , ((myModMask, xK_p), runOrRaisePrompt myXPConfig)

             , ((myModMask, xK_Left),  prevWS)
             , ((myModMask, xK_Right), nextWS)

             -- ,((modMask x, xK_b     ), sendMessage ToggleStruts)

             -- Media keys
             , ((0, xF86XK_AudioRaiseVolume), spawn "pulseaudio-ctl up")
             , ((0, xF86XK_AudioLowerVolume), spawn "pulseaudio-ctl down")
             , ((0, xF86XK_AudioMute),        spawn "pulseaudio-ctl mute")
             , ((0, xF86XK_AudioPlay),        spawn "cmus-remote -u")
             , ((0, xF86XK_AudioStop),        spawn "cmus-remote -s")
             , ((0, xF86XK_AudioNext),        spawn "cmus-remote -n")
             , ((0, xF86XK_AudioPrev),        spawn "cmus-remote -r")

             -- Function key alternates
             , ((0, xF86XK_ScreenSaver), spawn "xautolock -locknow")

             -- Thinkpad tablet buttons
             , ((0, xF86XK_Launch1), spawn "xautolock -locknow")
             , ((0, xF86XK_Launch2), spawn "/usr/local/bin/thinkpad-rotate")
             , ((0, xF86XK_Launch3), spawnSelected defaultGSConfig ["cellwriter --show-window", "easystroke", "xournalpp"])
             , ((0, xF86XK_Launch4), spawn "/usr/local/bin/thinkpad-rotate normal")
             ]

myLayout = smartBorders $ showWName' mySWNConfig $
           desktopLayoutModifiers
           (tiled ||| mirrorTiled ||| tabbed shrinkText myTabConfig |||  Full)
    where
      tiled       = Tall nmaster delta ratio
      nmaster     = 1
      ratio       = 1/2
      delta       = 3/100
      mirrorTiled = Mirror tiled

myBorderWidth         = 1
myBgColor             = "#000000"
myFgColor             = "DarkOrange"
myHighlightedBgColor  = myBgColor
myHighlightedFgColor  = "#FFA000"
myFocusedBorderColor   = myHighlightedFgColor
myNormalBorderColor = "#89CFF0"

myTabConfig :: Theme
myTabConfig = defaultTheme {
                activeBorderColor   = myBgColor
              , activeTextColor     = myHighlightedFgColor
              , activeColor         = myBgColor
              , inactiveBorderColor = myBgColor
              , inactiveTextColor   = "#EEEEEE"
              , inactiveColor       = myBgColor
              , decoHeight          = 14
}

mySWNConfig :: SWNConfig
mySWNConfig = defaultSWNConfig {
                swn_color   = myFocusedBorderColor
              , swn_fade    = 1.5
              , swn_bgcolor = myBgColor}

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
                { bgColor               = myBgColor
                , fgColor               = myFgColor
                , bgHLight              = myHighlightedBgColor
                , fgHLight              = myHighlightedFgColor
                , position              = Top
                , promptBorderWidth     = 0
                }

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
    , ((modMask, button3),               (\w -> focus w >> FlexR.mouseResizeWindow w))
    , ((modMask .|. shiftMask, button3), (\w -> focus w >> SQR.mouseResizeWindow w True ))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Finder for window prompts. By default they only match
-- the start of the window title. This also matches the
-- middle of the title.
myFinder :: String -> String -> Bool
myFinder = isInfixOf

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--

main = do
  xmobar <- spawnPipe "/usr/bin/xmobar"
  xmonad
    $ withUrgencyHook LibNotifyUrgencyHook
    $ defaultConfig
             { terminal           = myTerminal
             , focusFollowsMouse  = myFocusFollowsMouse
             , borderWidth        = myBorderWidth
             , modMask            = myModMask
             -- , numlockMask        = myNumlockMask
             , workspaces         = myWorkspaces
             , normalBorderColor  = myNormalBorderColor
             , focusedBorderColor = myFocusedBorderColor

             -- key bindings
             , keys               = myKeys <+> keys defaultConfig
             , mouseBindings      = myMouseBindings

             -- hooks, layouts
             , layoutHook         = myLayout
             , manageHook         = myManageHook
             , logHook            = dynamicLogWithPP $ myXmobarPP xmobar
             , startupHook        = myStartupHook
             }
             `additionalKeys`
             [ ((myModMask, xK_d), AL.launchApp myXPConfig { defaultText = "~" } "thunar" )
             ]
