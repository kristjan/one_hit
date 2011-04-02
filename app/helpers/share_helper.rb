module ShareHelper
  def twitter_share_button(site, opts={})
    @include_twitter_js = true

    style = opts.fetch(:style, 'horizontal')
    url = opts.fetch(:url, site_url(site))
    canonical_url = opts.fetch(:canonical_url, site_url(site))
    recommend = "kripet"

    link_to("Tweet", "http://twitter.com/share",
            :class => 'twitter-share-button',
            'data-count' => style,
            'data-url' => url,
            'data-counturl' => canonical_url,
            'data-related' => recommend)
  end
end
