$.namespace("OneHit.Sites").Form = (function() {
  var init = function() {
    $('#new_site .name input').keyup(updateURL);
    $('#new_site .url input').alphanumeric({
      allow : '-', // Allow dash
      nchars: ' ', // Disallow space
      nocaps: true
    });
  };

  var updateURL = function() {
    var name = $(this);
    var url = name.closest('form').find('input#site_url');
    url.val(name.val().toLowerCase().replace(/[^-_a-z0-9]+/g, ''));
  };

  return {
    init: init
  };
})();

$(document).ready(function() {
  OneHit.Sites.Form.init();
});
