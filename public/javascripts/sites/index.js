$.namespace('OneHit.Sites').Index = (function() {
  var init = function() {
    $('.examples .cycle_container').cycle({
      fx: 'scrollUp'
    , easing: 'easeInOutBack'
    , timeout: 8000
    });
  };

  return {
    init: init
  };
})();

$(document).ready(function() {
  OneHit.Sites.Index.init();
});
