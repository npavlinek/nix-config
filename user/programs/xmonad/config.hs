import           Data.Ratio
import           System.Exit
import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Layout.NoBorders
import           XMonad.Util.EZConfig
import qualified Codec.Binary.UTF8.String      as UTF8
import qualified DBus                          as D
import qualified DBus.Client                   as D
import qualified XMonad.StackSet               as W

main :: IO ()
main = do
  dbus <- D.connectSession
  D.requestName
    dbus
    (D.busName_ "org.xmonad.Log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  xmonad $ myConfig dbus

myConfig dbus = docks def { terminal           = "st"
                          , focusFollowsMouse  = False
                          , borderWidth        = 2
                          , workspaces         = myWorkspaces
                          , normalBorderColor  = "#2e3440"
                          , focusedBorderColor = "#81a1c1"
                          , keys               = myKeys
                          , layoutHook         = myLayoutHook
                          , manageHook         = manageDocks <+> myManageHook
                          , logHook = dynamicLogWithPP $ myLogHook dbus
                          }

myWorkspaces = map show [1 .. 9]

myKeys c =
  mkKeymap c
    $  [ ("M-<Return>"  , spawn $ XMonad.terminal c)
       , ("M-p"         , spawn "rofi -show run")
       , ("M-S-c"       , kill)
       , ("M-<Space>"   , sendMessage NextLayout)
       , ("M-S-<Space>" , setLayout $ XMonad.layoutHook c)
       , ("M-n"         , refresh)
       , ("M-j"         , windows W.focusDown)
       , ("M-k"         , windows W.focusUp)
       , ("M-m"         , windows W.focusMaster)
       , ("M-S-<Return>", windows W.swapMaster)
       , ("M-S-j"       , windows W.swapDown)
       , ("M-S-k"       , windows W.swapUp)
       , ("M-h"         , sendMessage Shrink)
       , ("M-l"         , sendMessage Expand)
       , ("M-t"         , withFocused $ windows . W.sink)
       , ("M-,"         , sendMessage (IncMasterN 1))
       , ("M-."         , sendMessage (IncMasterN (-1)))
       , ("M-S-q"       , io (exitWith ExitSuccess))
       , ( "M-q"
         , spawn
           "xmonad --recompile && xmonad --restart && dunstify 'XMonad recompiled!'"
         )
       ]
    ++ [ (m ++ k, windows $ f w)
       | (w, k) <- zip (XMonad.workspaces c) (map show [1 .. 9])
       , (m, f) <- [("M-", W.greedyView), ("M-S-", W.shift)]
       ]

myLayoutHook = avoidStruts $ smartBorders $ layoutHook def

myManageHook =
  let getWorkspaceIdFromPos pos = myWorkspaces !! (pos - 1)
  in  composeAll
        [ appName =? "Places" --> doRectFloat (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 2))
        , className =? "Brave" --> doRectFloat (W.RationalRect (1 % 4) (1 % 4) (1 % 2) (1 % 2))
        , className =? "Brave-browser" --> doShift (getWorkspaceIdFromPos 3)
        , className =? "Chromium-browser" --> doShift (getWorkspaceIdFromPos 3)
        , className =? "Firefox" --> doShift (getWorkspaceIdFromPos 3)
        , className =? "KeePassXC" --> doShift (getWorkspaceIdFromPos 9)
        , className =? "Pavucontrol" --> doFloat
        ]

myLogHook :: D.Client -> PP
myLogHook dbus =
  let polybarColor fg bg s =
          wrap ("%{F" ++ fg ++ "}" ++ "%{B" ++ bg ++ "}") "%{F- B-}" s
      black = "#282828"
      red   = "#fb4934"
      gray  = "#665c54"
      white = "#ebdbb2"
  in  def { ppCurrent = polybarColor black white . pad
          , ppHidden  = pad
          , ppUrgent  = polybarColor black red . pad
          , ppSep     = polybarColor gray black $ pad "|"
          , ppWsSep   = ""
          , ppTitle   = shorten 80
          , ppOutput  = dbusOutput dbus
          }

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
  let signal = (D.signal objectPath interfaceName memberName)
        { D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
  D.emit dbus signal
 where
  objectPath    = D.objectPath_ "/org/xmonad/Log"
  interfaceName = D.interfaceName_ "org.xmonad.Log"
  memberName    = D.memberName_ "Update"
