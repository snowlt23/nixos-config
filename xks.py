import re
from xkeysnail.transform import *

define_keymap(re.compile("Firefox"), {
    K("C-o"): K("C-Shift-TAB"),
    K("C-e"): K("C-TAB"),
}, "Firefox")

define_keymap(re.compile("Brave-browser"), {
    K("C-o"): K("C-Shift-TAB"),
    K("C-e"): K("C-TAB"),
}, "Brave")
