{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

import XMonad hiding (focus)

import XMonad.Layout.TwoPane
import XMonad.Layout.Tabbed
import XMonad.Layout.OneBig
import XMonad.Layout.Simplest
import XMonad.Layout.Circle
import XMonad.Layout.Combo
import XMonad.Layout.Column
import XMonad.Layout.PerWorkspace
import XMonad.Layout.WindowNavigation
import XMonad.Layout.SubLayouts
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.BoringWindows

import XMonad.Operations hiding (focus)
import XMonad.Util.EZConfig
import XMonad.Layout.Spacing
import XMonad.Hooks.FadeInactive
import Control.Arrow ((***), second)

import qualified XMonad.StackSet as W

newtype Flip l a = Flip (l a) deriving (Show, Read)

instance LayoutClass l a => LayoutClass (Flip l) a where
    runLayout (W.Workspace i (Flip l) ms) r = (map (second flipRect) *** fmap Flip)
                                                `fmap` runLayout (W.Workspace i l ms) (flipRect r)
                                         where screenWidth = fromIntegral $ rect_width r
                                               flipRect (Rectangle rx ry rw rh) = Rectangle (screenWidth - rx - (fromIntegral rw)) ry rw rh
    handleMessage (Flip l) = fmap (fmap Flip) . handleMessage l
    description (Flip l) = "Flip "++ description l

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 0.9

subTallLayout = windowNavigation
              $ subTabbed
              $ boringWindows
              $ Flip
              $ Tall 1 (10/100) (1/3)
defaultLayout = simpleTabbed ||| subTallLayout
layout = onWorkspace "Util" (TwoPane (10/100) (70/100))
       $ onWorkspace "Web" simpleTabbed
       $ onWorkspace "Dev" subTallLayout
       $ onWorkspace "Work" subTallLayout
       $ defaultLayout

modm = mod4Mask

main = xmonad $ defaultConfig
  { terminal = "urxvt"
  , modMask = modm
  , borderWidth = 0
  , logHook = myLogHook
  , workspaces = ["Util", "Web", "Dev", "Work", "Other"]
  , layoutHook = spacingRaw True (Border 0 8 8 8) True (Border 8 8 8 8) True $
                 layout
  }
  `additionalKeysP`
  [ ("M-c", kill)
  , ("M-t", spawn "luakit")
  ]
  `additionalKeys`
  [ ((modm .|. controlMask, xK_h), sendMessage $ pullGroup L)
  , ((modm .|. controlMask, xK_l), sendMessage $ pullGroup R)
  , ((modm .|. controlMask, xK_k), sendMessage $ pullGroup U)
  , ((modm .|. controlMask, xK_j), sendMessage $ pullGroup D)
 
  , ((modm .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
  , ((modm .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))
 
  , ((modm .|. controlMask, xK_period), onGroup W.focusUp')
  , ((modm .|. controlMask, xK_comma), onGroup W.focusDown')
  ]
