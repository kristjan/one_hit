$.namespace("OneHit.Sites").New = (function() {
  var init = function() {
    $('#new_site .name input, #new_site .quip input').tooltip({
      position: 'top center'
    , effect: 'fade'
    , opacity: 0.9
    , offset: [-5, 92]
    });
    $('#new_site .url input').tooltip({
      position: 'top center'
    , effect: 'fade'
    , opacity: 0.9
    , offset: [-5, 15]
    });
  };

  return {
    init : init
  }
})();

$(document).ready(function() {
  OneHit.Sites.New.init();
});
