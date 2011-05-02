OneHit::Application.configure do
  config.cache_classes                          = false
  config.whiny_nils                             = true
  config.consider_all_requests_local            = true
  config.action_view.debug_rjs                  = true
  config.action_controller.perform_caching      = false
  config.action_mailer.raise_delivery_errors    = false
  config.active_support.deprecation             = :log
  config.action_dispatch.best_standards_support = :builtin
end

ENV['TWITTER_OAUTH_TOKEN']     = '291425853-UC3VCjeOZjOyYFnloV5IXUTgVP2tt92DZkcKF4ou'
ENV['TWITTER_OAUTH_SECRET']    = '9lxGLNT5LVwEUFERpqxczNOtBF0yflL82y9bkogvPfc'
