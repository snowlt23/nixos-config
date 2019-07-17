local settings = require "settings"
local select = require "select"
local follow = require "follow"
local theme = require "theme"
local engines = settings.window.search_engines

settings.window.home_page = "https://duckduckgo.com"
engines.default = settings.window.search_engines.duckduckgo

select.label_maker = function ()
    local chars = charset("asdfqwerzxcv")
    return trim(sort(reverse(chars)))
end
follow.pattern_maker = follow.pattern_styles.match_label

follow.stylesheet = [[
#luakit_select_overlay {
    position: absolute;
    left: 0;
    top: 0;
    z-index: 2147483647; /* Maximum allowable on WebKit */
}
#luakit_select_overlay .hint_overlay {
    display: block;
    position: absolute;
    background-color: ]] .. (theme.hint_overlay_bg     or "rgba(255,255,153,0.3)") .. [[;
    border:           ]] .. (theme.hint_overlay_border or "1px dotted #000")       .. [[;
}
#luakit_select_overlay .hint_label {
    display: block;
    position: absolute;
    background-color: ]] .. (theme.hint_bg     or "#000088")                             .. [[;
    border:           ]] .. (theme.hint_border or "1px dashed #000")                     .. [[;
    color:            ]] .. (theme.hint_fg     or "#fff")                                .. [[;
    font:             ]] .. (theme.hint_font   or "10px monospace, courier, sans-serif") .. [[;
}
#luakit_select_overlay .hint_selected {
    background-color: ]] .. (theme.hint_overlay_selected_bg     or "rgba(0,255,0,0.3)") .. [[ !important;
    border:           ]] .. (theme.hint_overlay_selected_border or "1px dotted #000")   .. [[;
  }
]]
