if (typeof (OneHit) === 'undefined') OneHit = {};

OneHit.Sites = (function() {
  var index = function() {
    $('.examples .cycle_container').cycle({
      fx: 'scrollLeft'
    , easing: 'easeInOutBack'
    , timeout: 8000
    });
  };

  return {
    index: index
  };
})();

$(document).ready(function() {
  OneHit.Sites.index();
});
