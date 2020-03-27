settings.smoothScroll = false;
addSearchAliasX('g', 'DuckDuckGo', 'https://duckduckgo.com/?q=');
map('J', 'E');
map('K', 'R');
map('H', 'S');
map('L', 'D');

mapkey('f', 'Overrided hit-a-hint', function() {
  Hints.create("", (element, event) => {
    Hints.dispatchMouseClick(element, event);
    Normal.refreshScrollableElements();
  });
});
mapkey('F', 'Overrided hit-a-hint (tabbed)', function() {
  Hints.create("", (element, event) => {
    Hints.dispatchMouseClick(element, event);
    Normal.refreshScrollableElements();
  }, {tabbed: true});
});
