$.namespace('OneHit.Sites').Index = (function() {
  var init = function() {
    $('.examples .cycle_container').cycle({
      fx: 'scrollUp'
    , easing: 'easeInOutBack'
    , timeout: 8000
    });

    $('#new_site .name input, #new_site .quip input').tooltip({
      position: 'center left'
    , effect: 'fade'
    , offset: [0, -5]
    });
    $('#new_site .url input').tooltip({
      position: 'center left'
    , effect: 'fade'
    , offset: [0, -106]
    });
  };

  return {
    init: init
  };
})();

$(document).ready(function() {
  OneHit.Sites.Index.init();
});
