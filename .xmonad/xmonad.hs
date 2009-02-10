--
-- meqif's xmonad config file.
--
-- Slightly modified default config file, with some stuff from Rob
-- Manea's config.
--

-- XMonad Core
import XMonad

-- Actions
import XMonad.Actions.DwmPromote
import XMonad.Actions.NoBorders
-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
-- Layouts
import XMonad.Layout
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.SimpleFloat
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import XMonad.Layout.CenteredMaster
import XMonad.Layout.ThreeColumnsMiddle
-- Misc
import XMonad.Operations
import XMonad.Util.Run (spawnPipe)

import System.Exit
import System.IO.UTF8 (hPutStrLn)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--------------------------------------------------------------------------------
-- Misc commands
--

dmenu = "dmenu_run -i -fn '" ++ myFont ++
    "' -nb '#222' -nf '#ccc' -sb '#555' -sf '#fff'"
horario = "feh /home/meqif/FCT/horario.png"
horario_mod = "feh /home/meqif/FCT/horario_mod.png"
horario_lena = "feh /home/meqif/.horario_lena.png"

--------------------------------------------------------------------------------
-- Customizations
--

-- Where my dzen bitmaps are stored
myIconDir = "/home/meqif/.icons/dzen_bitmaps/"

-- Default font
myFont = "-*-profont-*-*-*-*-11-*-*-*-*-*-iso8859"

-- Dzen's config
statusBarCmd = "dzen2_multiscreen -w 620 -sa c -fn '" ++ myFont
                ++ "' -e '' -ta l -h 16 -bg '#222222'"

-- The preferred terminal program, which is used in a binding below and
-- by certain contrib modules.
--
myTerminal      = "urxvtc"

-- Width of the window border in pixels.
--
myBorderWidth   = 2

myModMask       = mod1Mask
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
--

myWorkspaceNames :: [String]
myWorkspaceNames = ["main", "web", "im", "code", "doc"] ++ map show [6..9]

myWorkspaces :: [WorkspaceId] -- [String]
myWorkspaces = zipWith (++) (map show [1..]) wsnames
    where wsnames = map ((:) ':') myWorkspaceNames

getWorkspaceId :: String -> WorkspaceId -- String
getWorkspaceId name = case lookup name (zip myWorkspaceNames myWorkspaces) of
      Just wsId -> wsId
      Nothing -> head myWorkspaces

-- Border colors for unfocused and focused windows, respectively.
--
--myMainColor          = "#ff9900"
myMainColor          = "#848484"
myNormalBorderColor  = "#444444"
myFocusedBorderColor = myMainColor

--------------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modMask,               xK_p     ), spawn dmenu)

    -- launch firefox
    , ((modMask .|. shiftMask, xK_w     ), spawn "firefox")

    -- shows my schedule
    , ((mod4Mask,              xK_h     ), spawn horario)
    , ((mod4Mask .|. shiftMask,  xK_h     ), spawn horario_mod)
    , ((mod4Mask,               xK_l    ), spawn horario_lena)

    -- multimedia keys / MPD control
    , ((0,                 0x1008ff14   ), spawn "mpc toggle")
    , ((0,                 0x1008ff15   ), spawn "mpc stop > /dev/null")
    , ((0,                 0x1008ff16   ), spawn "mpc prev > /dev/null")
    , ((0,                 0x1008ff17   ), spawn "mpc next > /dev/null")

    -- close focused window
    , ((modMask .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modMask,               xK_Return), dwmpromote)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    , ((modMask,               xK_g     ), withFocused toggleBorder )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    ,((modMask               , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modMask              , xK_q     ), spawn "xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++
    -- mod-{a,o} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{a,o} %! Move client to screen 1, 2, or 3
    [((m .|. mod4Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_1, xK_2] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

--------------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
    ]

--------------------------------------------------------------------------------
-- Layouts:

myLayout = onWorkspace (getWorkspaceId "im") imL
         $ onWorkspace (getWorkspaceId "code") codeL
         $ onWorkspace (getWorkspaceId "doc") docL
         $ onWorkspace (getWorkspaceId "8") gimpL
         $ restL
         where
             tiled   = Tall nmaster delta ratio
             nmaster = 1
             ratio   = 1/2
             delta   = 3/100

             mtile   = Mirror (Tall 1 (3/100) (62/100))

             centerd = centerMaster Grid

             imL     = avoidStruts $ simpleFloat
             codeL   = avoidStruts $ smartBorders $ layoutHints
                                   $ (Tall nmaster delta (56/100) ||| mtile ||| Full)
             docL    = avoidStruts $ smartBorders $ layoutHints
                                   $ (Full ||| tiled ||| mtile)
             restL   = avoidStruts $ smartBorders $ layoutHints
                                   $ (tiled ||| mtile ||| Full ||| centerd ||| simpleFloat)
             gimpL   = avoidStruts $ ThreeColMid 1 (3/100) (2/3)

--------------------------------------------------------------------------------
-- Window rules:

myManageHook = composeAll . concat $
    [ [ className =? c --> doFloat | c <- myFloats ]
    , [ title     =? t --> doFloat | t <- myOtherFloats ]
    , [ className =? webC  --> doF (W.shift $ getWorkspaceId "web" ) | webC  <- web  ]
    , [ className =? imC   --> doF (W.shift $ getWorkspaceId "im")   | imC   <- im   ]
    , [ className =? docC  --> doF (W.shift $ getWorkspaceId "doc")  | docC  <- doc  ]
    , [ className =? codeC --> doF (W.shift $ getWorkspaceId "code") | codeC <- code ]
    , [ className =? "Qwit"           --> (ask >>= doF . W.sink) ]
    , [ className =? "stalonetray"    --> doIgnore ] ]
    where
        code = [ "Eclipse", "Eclipse SDK", ".", "Kate" ]
        doc  = [ "Kile" ]
        web  = [ "Gran Paradiso", "Firefox", "Opera" ]
        im   = [ "Pidgin", "gajim.py" ]
        myFloats = ["MPlayer", "mplayer", "Sonata", "feh", "fbpanel",
                    "Pidgin", "gajim.py", "gens", "Skype", "Nitrogen",
                    "Save a Bookmark", "emesene", "Eclipse SDK", ".", "Dia"]
        myOtherFloats = ["Gran Paradiso - Restore Previous Session", "Add-ons",
                         "Downloads", "Gajim", "gens", "Wicd Manager",
                         "Nitrogen", "Save a Bookmark", "emesene",
                         "VLC media player"]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

--------------------------------------------------------------------------------
-- Logging

myPP h = defaultPP
    { ppCurrent = dzenColor "white" myMainColor . pad
    , ppVisible = wrap "<" ">"
    , ppHidden  = dzenColor "white" "" . pad
    , ppUrgent  = wrap "^fg(red)^bg() zomg" " ^fg()^bg()"
    , ppSep     = " "
    , ppLayout  = dzenColor "#FFFFFF" "" .
        (\x -> case x of
            "Hinted Tall"        -> "^i(" ++ myIconDir ++ "tall2.xbm)"
            "Tall"               -> "^i(" ++ myIconDir ++ "tall2.xbm)"
            "Hinted Mirror Tall" -> "^i(" ++ myIconDir ++ "mtall2.xbm)"
            "Hinted Full"        -> "^i(" ++ myIconDir ++ "full.xbm)"
            "Hinted Simple Float" -> "><>"
            "Simple Float"        -> "><>"
            _ -> x
        )
    , ppTitle   = dzenColor "white" "" . wrap "< " " >"
    , ppOutput  = System.IO.UTF8.hPutStrLn h
}

--------------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    din <- spawnPipe statusBarCmd
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook <+> manageDocks,
        logHook            = dynamicLogWithPP $ myPP din
    }
