$.namespace("OneHit.Sites").New = (function() {
  var init = function() {
    var form = $('.new_site, .edit_site');
    form.find('.name input, .quip input').tooltip({
      position: 'top center'
    , effect: 'fade'
    , opacity: 0.9
    , offset: [-5, 92]
    });
    form.find('.url input').tooltip({
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
