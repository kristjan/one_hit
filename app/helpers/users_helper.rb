module UsersHelper
  TWITTER_LOGIN_IMAGE =
    'http://si0.twimg.com/images/dev/buttons/sign-in-with-twitter-l.png'

  def login_with_twitter
    link_to image_tag(TWITTER_LOGIN_IMAGE), auth_path(:twitter)
  end

  def auth_path(provider)
    "/auth/#{provider}"
  end
end
