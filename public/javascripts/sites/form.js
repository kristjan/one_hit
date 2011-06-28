$.namespace("OneHit.Sites").Form = (function() {
  var init = function() {
    $('form#new_site #site_name').keyup(updateURL);
    $('form#new_site #site_url').alphanumeric({
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
