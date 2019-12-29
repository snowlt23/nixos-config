settings.smoothScroll = false;
settings.defaultSearchEngine = "d";

map('o', 'go');
map('O', 't');

map('H', 'S');
map('L', 'D');
map('J', 'E');
map('K', 'R');

function dispatchHint(element, event) {
  Hints.dispatchMouseClick(element, event);
  scrollNodes = null;
  initScrollIndex();
  if (scrollNodes.length > 0) {
    var scrollNode = scrollNodes[scrollIndex];
    _highlightElement(scrollNode);
  }
}

mapkey('f', '', function() {
  Hints.create("", dispatchHint);
});

mapkey('F', '', function() {
  Hints.create("", dispatchHint, {tabbed: true});
});
