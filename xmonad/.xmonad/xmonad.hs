-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                  Imports                                                                                      --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Base
import XMonad
import System.Exit (exitSuccess)                        -- Exit Xmonad
import qualified XMonad.StackSet as W                   -- Manages workspaces added for ScratchPad Support
import qualified Data.Map as M                          -- For Toggling Floats

-- Utils
import XMonad.Util.EZConfig                             -- Easier KeyBindings
import XMonad.Util.SpawnOnce                            -- Startup Applications
import XMonad.Util.NamedScratchpad                      -- ScratchPads

-- Layout
import XMonad.Layout.ResizableTile                      -- Tiled Layout With Resizable Windows
import XMonad.Layout.ThreeColumns                       -- Three Columns Layout
import XMonad.Layout.Accordion                          -- Accordion Layout
import XMonad.Layout.GridVariants (Grid(Grid))          -- Grid Layout
import XMonad.Layout.Spiral                             -- Spiral Layout
import XMonad.Layout.Tabbed                             -- Tabbed Layout

-- Layout Modifiers
import XMonad.Layout.SubLayouts                         -- Layout Combinator used for tabbed layouts
import XMonad.Layout.Simplest                           -- Simple Layout Used for tabbed Layout
import XMonad.Layout.Spacing                            -- Adds Gaps
import XMonad.Layout.LayoutModifier                     -- Modifing Layouts
import XMonad.Layout.Magnifier                          -- Magnifies Focused Window
import XMonad.Layout.NoBorders                          -- For smartBoarders action
import XMonad.Layout.WindowNavigation                   -- Window Navigation
import XMonad.Layout.Renamed                            -- Rename Layouts To Over Ride Functionalities
import XMonad.Layout.WindowArranger                     -- Allows rearrengment of windows
import XMonad.Layout.LimitWindows                       -- A layout modifier that limits the number of windows that can be shown
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle)) -- A module to toggle between two layouts.
import XMonad.Layout.MultiToggle                        -- Dynamically apply and unapply transformers to your window layout. 
import XMonad.Layout.PerWorkspace                       -- Set a default layout for each workspace

-- Actions
import XMonad.Actions.CopyWindow (kill1)                -- Kills Focused Window
import XMonad.Actions.WithAll (sinkAll, killAll)        -- Kills All Windows in a Workspace
import XMonad.Actions.UpdatePointer                     -- Cursor Follows Focus
import XMonad.Actions.CycleWS                           -- Cycle Between Screens
import XMonad.Actions.MouseResize                       -- A layout modifier to resize windows with the mouse by grabbing the window's lower right corner.

-- Hooks
import XMonad.Hooks.ManageHelpers                       -- For The Rules
import XMonad.Hooks.EwmhDesktops                        -- For Some Full Screen Events
import XMonad.Hooks.ManageDocks                         -- Prevents Windows From Overlapping Polybar
import XMonad.ManageHook                                -- Manages hooks added for ScratchPad Support
import XMonad.Hooks.SetWMName                           -- Sets the WM name to a given string, so that it could be detected using _NET_SUPPORTING_WM_CHECK protocol.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                  Variables                                                                                    --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

myFont :: String
myFont = "xft:Ubuntu:Regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask                            -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "kitty"                            -- Sets default terminal

myBrowser :: String
myBrowser = "google-chrome-stable"              -- Sets default browser

myEditor :: String
myEditor = "neovide"                              -- Sets default editor

myFileManager :: String
myFileManager = "nautilus"                       -- Sets default file manager

 

myBorderWidth :: Dimension
myBorderWidth = 0                               -- Sets border width for windows

myNormColor :: String
myNormColor   = "#282c34"                       -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#808080"                       -- Border color of focused windows

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                   Startup                                                                                     --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "lxsession &"                             -- For GTK Themeing And Fonts
    spawnOnce "dunst &"                                 -- Starts Notification Daemon
    spawnOnce "~/.fehbg &"                              -- Sets last saved feh wallpaper
    spawnOnce "picom &"         -- Starts picom
    spawnOnce "~/.local/bin/desktop-startup"            -- Starts Polybar and Wallpaper Blur

    -- Guis
    spawnOnce myEditor
    spawnOnce myBrowser
    spawnOnce myTerminal
    -- spawnOnce myFileManager
    -- spawnOnce "ferdi"
    -- spawnOnce "discord"
    -- spawnOnce "slack"
    -- spawnOnce "spotify"
    setWMName "LG3D"                                    -- Sets WM name which required by some functions to work correctly

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                     Rules                                                                                     --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

myManageHook :: ManageHook
myManageHook = composeAll
     [ className =? "confirm"                                 --> doFloat
     , className =? "file_progress"                           --> doFloat
     , className =? "dialog"                                  --> doFloat
     , className =? "download"                                --> doFloat
     , className =? "error"                                   --> doFloat
     , className =? "Gimp"                                    --> doFloat
     , className =? "notification"                            --> doFloat
     , className =? "pinentry-gtk-2"                          --> doFloat
     , className =? "splash"                                  --> doFloat
     , className =? "toolbar"                                 --> doFloat
     , (className =? "myBrowser" <&&> resource =? "Dialog")   --> doFloat
     , className =? "Live Caption"                            --> doFloat
     , className =? "zoom"                                    --> doFloat

     -- Text Editors
     , className =? "neovide"                                 --> doShift ( myWorkspaces !! 0 )
     -- , className =? "jetbrains-studio"                        --> doShift ( myWorkspaces !! 0 )
     -- , className =? "jetbrains-idea-ce"                       --> doShift ( myWorkspaces !! 0 )
     , className =? "code"                                    --> doShift ( myWorkspaces !! 0 )
     , className =? "emacs"                                   --> doShift ( myWorkspaces !! 0 )
     -- Terminal, Steam, Github
     , className =? "kitty"                                   --> doShift ( myWorkspaces !! 1 )
     , className =? "obsidian"                                --> doShift ( myWorkspaces !! 1 )
     , className =? "Github Desktop"                          --> doShift ( myWorkspaces !! 1 )
     , className =? "Steam"                                   --> doShift ( myWorkspaces !! 1 )
     -- Browsers
     , className =? "firefox"                                 --> doShift ( myWorkspaces !! 2 )
     , className =? "Google-chrome"                           --> doShift ( myWorkspaces !! 2 )
     , className =? "Live Caption"                            --> doShift ( myWorkspaces !! 2 )
     -- File Mangers
     , className =? "Thunar"                                  --> doShift ( myWorkspaces !! 3 )
     , className =? "dolphin"                                 --> doShift ( myWorkspaces !! 3 )
     , className =? myFileManager                             --> doShift ( myWorkspaces !! 3 )
     -- Social Media
     , className =? "Ferdi"                                   --> doShift ( myWorkspaces !! 4 )
     , className =? "discord"                                 --> doShift ( myWorkspaces !! 4 )
     , className =? "Slack"                                   --> doShift ( myWorkspaces !! 4 )
     , className =? "whatsapp-nativefier-d40211"              --> doShift ( myWorkspaces !! 4 )
     , className =? "zoom"                                    --> doShift ( myWorkspaces !! 4 )
     -- Spotify
     , className =? "Spotify"                                 --> doShift ( myWorkspaces !! 4 )
     , className =? ""                                        --> doShift ( myWorkspaces !! 4 )

     ]  <+> manageDocks <+> namedScratchpadManageHook myScratchPads
-- Requires Xdotool

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                      Layouts                                                                                  --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Window Gaps
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Floats
toggleFloat w = windows (\s -> if M.member w (W.floating s)
                          then W.sink w s
                          else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))

-- Tabb Theme
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#46d9ff"
                 , inactiveColor       = "#313846"
                 , activeBorderColor   = "#46d9ff"
                 , inactiveBorderColor = "#282c34"
                 , activeTextColor     = "#282c34"
                 , inactiveTextColor   = "#d0d0d0"
                 }

-- Default Values
nmaster     = 1
ratio       = 1/2
delta       = 5/100

-- Definig Layouts
tiled           = renamed [Replace "tall"]
                  $ smartBorders
                  $ windowNavigation
                  $ limitWindows 12
                  $ mySpacing 8
                  $ ResizableTall nmaster delta ratio []
myTabs          = renamed [Replace "tabs"]
                  $ mySpacing 8
                  $ tabbed shrinkText myTabTheme
magnified         = renamed [Replace "magnify"]
                  $ smartBorders
                  $ windowNavigation
                  $ magnifier
                  $ limitWindows 12
                  $ mySpacing 8
                  $ ResizableTall nmaster delta ratio []
monocle         = renamed [Replace "monocle"]
                  $ smartBorders
                  $ windowNavigation
                  $ limitWindows 20 Full
grid            = renamed [Replace "grid"]
                  $ smartBorders
                  $ windowNavigation
                  $ limitWindows 12
                  $ mySpacing 8
                  $ Grid (16/10)
spirals         = renamed [Replace "spirals"]
                  $ smartBorders
                  $ windowNavigation
                  $ mySpacing 8
                  $ spiral (6/7)
threeCol        = renamed [Replace "tall"]
                  $ smartBorders
                  $ windowNavigation
                  $ limitWindows 7
                  $ mySpacing 8
                  $ ThreeColMid nmaster delta ratio
threeRow        = renamed [Replace "threeRow"]
                  $ smartBorders
                  $ windowNavigation
                  $ limitWindows 7
                  $ mySpacing 8
                  $ Mirror
                  $ ThreeCol nmaster delta ratio
tallAccordion   = renamed [Replace "tallAccordion"]
                  $ mySpacing 8
                  $ Accordion
wideAccordion   = renamed [Replace "wideAccordion"]
                  $ mySpacing 8
                  $ Mirror Accordion

-- myLayout Hook
myLayout =  avoidStruts $ mouseResize $ windowArrange $ onWorkspace "V" myTabs $  myDefaultLayout
               where
                 myDefaultLayout =     tiled
                                   ||| myTabs
                                   ||| magnified
                                   ||| monocle
                                   ||| grid
                                   ||| spirals
                                   ||| threeCol
                                   ||| threeRow
                                   ||| tallAccordion
                                   ||| wideAccordion

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                   WorkSpaces                                                                                  --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WorkSpaces
myWorkspaces :: [String]
myWorkspaces = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
-- myWorkspaces = ["I", "II", "III", "IV", "V"]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                   KeyBindings                                                                                --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

myKeys :: [(String, X ())]
myKeys =
    -- Xmonadwm Shortcuts
        [ ("M-C-r",             spawn "xmonad --recompile")  -- Recompiles xmonad
        , ("M-S-r",             spawn "xmonad --restart")    -- Restarts xmonad
        , ("M-S-x",             io exitSuccess)              -- Quits xmonad

    -- App Shortcuts
        , ("M-<Return>",        spawn (myTerminal))
        , ("M-b",               spawn (myBrowser))
        , ("M-f",               spawn (myFileManager))
        , ("M-c",               spawn "code")
        , ("M-v",               spawn "neovide")
        , ("M-e",               spawn ("emacs"))
        , ("M-d",               spawn "discord")
        , ("M-o",               spawn "obsidian")

    -- Scratchpad
        , ("M-S-<Return>",      namedScratchpadAction myScratchPads "terminal")
        , ("M-S-o",               namedScratchpadAction myScratchPads "htop")

    -- Menues
        , ("M-x",               spawn "~/.config/rofi/bin/powermenu") -- Power Menu
        , ("M-p",               spawn "~/.config/rofi/bin/launcher") -- App Menu
        -- , ("M-S-p",             spawn "~/.local/bin/polybar/bar-search.sh &") -- Dmenu
        , ("M-s",               spawn "~/.config/rofi/music/music &") -- Dmenu
        , ("M-n",               spawn "networkmanager_dmenu")   --Network

    -- Kill windows
        , ("M-q",               kill1)     -- Kill the currently focused client
        , ("M-S-q",             killAll)   -- Kill all windows on current workspace

    -- Multimedia Keys
        , ("<XF86AudioMute>",           spawn "amixer set Master toggle")
        , ("<XF86AudioLowerVolume>",    spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>",    spawn "amixer set Master 5%+ unmute")
        , ("<XF86MonBrightnessUp>",     spawn "xbacklight -inc 10")
        , ("<XF86MonBrightnessDown>",   spawn "xbacklight -dec 10")
        , ("<Print>",                   spawn "~/.local/bin/screenshot")

    -- Workspaces
        , ("M-<Tab>",           nextScreen)  -- Switch focus to next monitor
        , ("M-S-<Tab>",         prevScreen)  -- Switch focus to prev monitor

    -- Toggle Floats
        , ("M-S-f",                 withFocused toggleFloat) -- Toggles my 'floats' layout

    -- Windows navigation
        , ("M-m",               windows W.focusMaster)  -- Move focus to the master window
        , ("M-j",               windows W.focusDown)    -- Move focus to the next window
        , ("M-k",               windows W.focusUp)      -- Move focus to the prev window
        -- , ("M-l",               windows W.focusDown)    -- Move focus to the next window
        -- , ("M-h",               windows W.focusUp)      -- Move focus to the prev window

    -- Window Swaping
        , ("M-S-m",             windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j",             windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k",             windows W.swapUp)     -- Swap focused window with prev window

    -- Increase/decrease spacing (gaps)
        , ("C-M-j",            decWindowSpacing 4)         -- Decrease window spacing
        , ("C-M-k",            incWindowSpacing 4)         -- Increase window spacing
        , ("C-M-h",            decScreenSpacing 4)         -- Decrease screen spacing
        , ("C-M-l",            incScreenSpacing 4)         -- Increase screen spacing

    -- Window resizing 
    -- TODO: Find out alt key name and replace M1 with it
        -- , ("M-M1-h",               sendMessage Shrink)                   -- Shrink horiz window width
        -- , ("M-M1-l",               sendMessage Expand)                   -- Expand horiz window width
        -- , ("M-M1-j",               sendMessage MirrorShrink)             -- Shrink vert window width
        -- , ("M-M1-k",               sendMessage MirrorExpand)             -- Expand vert window width

    -- Layouts
        , ("M-<Space>",         sendMessage NextLayout)           -- Switch to next layout
        , ("M-S-b",             sendMessage ToggleStruts) -- Toggles noborder/full
        ]


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                  Scratchpad                                                                                   --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

myScratchPads :: [NamedScratchpad]
myScratchPads = [NS "terminal" (myTerminal ++ " --class terminal") (className =? "terminal") (customFloating $ W.RationalRect 0.17 0.15 0.7 0.7)
                ,NS "htop"     (myTerminal ++ " --class htop -e htop") (className =? "htop") (customFloating $ W.RationalRect 0.17 0.15 0.7 0.7)
                ]

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                  Main Function                                                                                --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . docks                    -- For Polybar
     $ myConfig

myConfig = def
    { modMask            = mod4Mask                         -- Rebind Mod to the Super key
    , layoutHook         = myLayout                         -- Use custom layouts
    , manageHook         = myManageHook                     -- Window Rules
    , startupHook        = myStartupHook                    -- Startup Applications
    , workspaces         = myWorkspaces                     -- WorkSpaces
    , logHook            = updatePointer (0.5, 0.5) (0, 0)  -- Move Pointer With Focus
    , borderWidth        = myBorderWidth                    -- Sets Boarder Width
    , normalBorderColor  = myNormColor                      -- Unfocused Window Boarder Color
    , focusedBorderColor = myFocusColor                     -- Focused Window Color
    , terminal           = myTerminal                       -- Default Terminal
    }
  `additionalKeysP` myKeys                                  -- Maps my custom key bindings specified above

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                                                                           EOF                                                                                 --
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
