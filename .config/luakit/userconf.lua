local modes = require "modes"

modes.add_binds({"normal"}, {
    {"v", "Open video to mpv", function (w)
        local view = w.view
        local uri = view.hovered_uri or view.uri
        if uri then
            luakit.spawn(string.format("mpv %s", uri))
        end
    end},
})
