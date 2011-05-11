module SitesHelper
  def tip(name)
    image_tag("tips/#{name}.png", :class => 'tip')
  end
end
