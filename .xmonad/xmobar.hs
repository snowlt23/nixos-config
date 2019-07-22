Config { font = "xft:Migu 1M:size=13,Font Awesome 5 Free Solid:size=13"
       , bgColor = "#1c1c1c"
       , fgColor = "#ffffff"
       , position = Static { xpos = 0, ypos = 0, width = 1728, height = 20 }
       , lowerOnStart = False
       , overrideRedirect = False
       , commands = [ Run Network "wlp1s0" [ "-t"        , " <dev> ⇩<rx> ⇧<tx>"
                                           , "--Low"    , "0"
                                           , "--High"   , "100"
                                           , "-m"       , "4"
                                           , "--normal" , "#b0bdbd"
                                           , "--high"   , "#a5d6a7"
                                           ] 10
                    , Run MultiCpu        [ "-t"       , " <total0>.<total1>.<total2>.<total3>"
                                          , "--Low"    , "0"
                                          , "--High"   , "100"
                                          , "-m"       , "2"
                                          , "--normal" , "#b0bdbd"
                                          , "--high"   , "#ef9a9a"
                                          ] 10

                    , Run Memory          [ "-t"       , " <usedratio>%"
                                          , "--Low"    , "0"
                                          , "--High"   , "100"
                                          , "--normal" , "#b0bdbd"
                                          , "--high"   , "#ef9a9a"
                                          ] 10
                    , Run Battery         [ "--template" , "<acstatus>"
                                          , "--Low"      , "0"
                                          , "--High"     , "100"
                                          , "--low"      , "darkred"
                                          , "--normal"   , "darkorange"
                                          , "--high"     , "darkgreen"
                                          , "--" -- battery specific options
                                          -- discharging status
                                          , "-o"	, "<fc=#ffffff> <left>%</fc>"
                                          -- AC "on" status
                                          , "-O"	, "<fc=#dAA520> <left>%</fc>"
                                          -- charged status
                                          , "-i"	, "<fc=#006000> <left>%</fc>"
                                          ] 50
                    , Run Date "%a %m/%d %H:%M" "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = " %StdinReader% }{ %wlp1s0%     %multicpu%   %memory%   %battery%   <fc=#ece391>%date%</fc> "
}
