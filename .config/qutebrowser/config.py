# keybindings
config.bind('J', 'tab-prev', mode='normal')
config.bind('K', 'tab-next', mode='normal')
config.bind('gj', 'tab-move -', mode='normal')
config.bind('gk', 'tab-move +', mode='normal')
config.bind('<escape>', 'leave-mode ;; jseval -q document.activeElement.blur()', mode='insert')
config.bind('<ctrl-[>', 'leave-mode ;; jseval -q document.activeElement.blur()', mode='insert')

c.content.host_blocking.lists.append(str(config.configdir) + "/blockedHosts")
