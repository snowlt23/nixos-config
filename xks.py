import re
from xkeysnail.transform import *

define_keymap(re.compile("Firefox"), {
    K("C-s"): K("C-Shift-TAB"),
    K("C-d"): K("C-TAB"),
    K("C-o"): K("C-Shift-TAB"),
    K("C-e"): K("C-TAB"),
}, "Firefox")
