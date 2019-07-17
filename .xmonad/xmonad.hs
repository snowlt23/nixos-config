{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

import XMonad

import XMonad.Layout.Tabbed
import XMonad.Layout.OneBig
import XMonad.Layout.Combo
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Hooks.FadeInactive

import qualified XMonad.StackSet as W

colorBlue      = "#868bae"
colorGreen     = "#00d700"
colorRed       = "#ff005f"
colorGray      = "#666666"
colorWhite     = "#bdbdbd"
colorNormalbg  = "#1c1c1c"
colorfg        = "#a8b6b8"

fadeLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.9

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

defaultLayout = Tall 1 (10/100) (2/3)
            ||| OneBig (3/4) (3/4)
            ||| simpleTabbed

myLayout = defaultLayout

modm = mod4Mask
myWsBar = "xmobar $HOME/.xmonad/xmobar.hs"

myConfig bar = def
  { terminal = "$HOME/.xmonad/open-terminal.sh"
  , modMask = modm
  , borderWidth = 0
  , logHook = myLogHook bar
  , workspaces = ["\xf109", "\xf2d2", "\xf121", "4", "5", "6", "7", "8", "9"]
  , layoutHook = avoidStruts
               $ spacingRaw True (Border 8 8 8 8) True (Border 8 8 8 8) True
               $ gaps [(U,20)]
               $ myLayout
  , manageHook = manageDocks
  }
  `additionalKeysP`
  [ ("M-c", kill)
  , ("M-t", spawn "brave")
  , ("<XF86AudioMute>", spawn "$HOME/.xmonad/vctl.sh -t")
  , ("<XF86AudioLowerVolume>", spawn "$HOME/.xmonad/vctl.sh -d 5")
  , ("<XF86AudioRaiseVolume>", spawn "$HOME/.xmonad/vctl.sh -i 5")
  ]

main = do
  wsbar <- spawnPipe myWsBar
  xmonad $ myConfig wsbar
