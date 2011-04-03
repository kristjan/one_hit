module ShareHelper
  TWEET_URL = "http://twitter.com/share"
  LIKE_SRC  = "http://www.facebook.com/plugins/like.php"

  def like_button(site, opts={})
    @include_fb_js = true

    layout = opts.fetch(:layout, 'button_count')
    faces  = opts.fetch(:faces, false)
    width  = opts.fetch(:width, 75)

    content_tag('fb:like', nil, :href => site_url(site), :class => 'fb_like',
                :layout => layout, :show_faces => faces)
  end

  def tweet_button(site, opts={})
    @include_twitter_js = true

    style = opts.fetch(:style, 'horizontal')
    url = opts.fetch(:url, site_url(site))
    canonical_url = opts.fetch(:canonical_url, site_url(site))
    recommend = "kripet"

    link_to("Tweet", TWEET_URL,
            :class => 'twitter-share-button',
            'data-count' => style,
            'data-url' => url,
            'data-counturl' => canonical_url,
            'data-related' => recommend)
  end
end
