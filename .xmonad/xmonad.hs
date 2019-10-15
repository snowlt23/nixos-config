{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

import XMonad

import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Layout.TwoPane
import XMonad.Actions.GridSelect
import XMonad.Actions.WindowBringer

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W

colorBlue      = "#868bae"
colorGreen     = "#00d700"
colorRed       = "#ff005f"
colorGray      = "#666666"
colorWhite     = "#bdbdbd"
colorNormalbg  = "#1c1c1c"
colorfg        = "#a8b6b8"

fadeLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor colorRed     colorNormalbg . \s -> s
                , ppUrgent          = xmobarColor colorGray    colorNormalbg . \s -> s
                , ppVisible         = xmobarColor colorRed     colorNormalbg . \s -> s
                , ppHidden          = xmobarColor colorGray    colorNormalbg . \s -> s
                , ppHiddenNoWindows = xmobarColor colorGray    colorNormalbg . \s -> s
                , ppTitle           = xmobarColor colorWhite     colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = " "
                , ppSep             = "  "
                }
myLogHook h = composeAll [dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }, fadeLogHook]

myLayout = TwoPane (3/100) (1/2)

myBorderWidth = 1 
myFocusedBorderColor = "#ffffff"
myNormalBorderColor = "#aaaaaa"

modm = mod4Mask
myWsBar = "xmobar $HOME/.xmonad/xmobar.hs"

myManageHook = composeAll [ className =? "Chromium" --> doShift "web"
                          , className =? "Firefox"  --> doShift "Web"
                          , resource  =? "desktop_window" --> doIgnore
                          , className =? "stalonetray"    --> doIgnore
                          , isFullscreen --> doFullFloat
                          ]

myConfig bar = def
  { terminal = "$HOME/.xmonad/open-terminal.sh"
  , modMask = modm
  , borderWidth = myBorderWidth
  , focusedBorderColor = myFocusedBorderColor
  , normalBorderColor = myNormalBorderColor
  , logHook = myLogHook bar
  , handleEventHook = fullscreenEventHook
  , workspaces = ["\xf109", "\xf2d2", "\xf121", "4", "5", "6", "7", "8", "9"]
  , layoutHook = (spacingRaw False (Border 8 8 8 8) True (Border 8 8 8 8) True
                $ gaps [(U,20)]
                $ myLayout)
             ||| (gaps [(U,20)]
                $ noBorders (fullscreenFull Full))

  , manageHook = manageDocks <+> myManageHook <+> fullscreenManageHook
  }
  `additionalKeysP`
  [ ("M-c", kill)
  , ("M-t", spawn "brave")
  , ("<XF86AudioMute>", spawn "$HOME/.xmonad/vctl.sh -t")
  , ("<XF86AudioLowerVolume>", spawn "$HOME/.xmonad/vctl.sh -d 5")
  , ("<XF86AudioRaiseVolume>", spawn "$HOME/.xmonad/vctl.sh -i 5")
  ]
  `additionalKeys`
  [ ((modm, xK_f), goToSelected defaultGSConfig)
  ]

main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ myConfig wsbar
