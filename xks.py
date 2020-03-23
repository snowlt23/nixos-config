import re
from xkeysnail.transform import *

define_keymap(re.compile("Firefox"), {
    K("C-s"): K("C-Shift-TAB"),
    K("C-d"): K("C-TAB"),
}, "Firefox")

define_keymap(re.compile("Brave-browser"), {
    K("C-s"): K("C-Shift-TAB"),
    K("C-d"): K("C-TAB"),
}, "Brave")
