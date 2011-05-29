require 'set'

module ApplicationHelper
  GOOGLE_FONT_BASE = "http://fonts.googleapis.com/css"

  def add_stylesheet(sheet)
    (@stylesheets ||= Set.new) << sheet
  end

  def stylesheets
    @stylesheets ||= Set.new
  end

  def google_font_link_tag(font)
    font = font.gsub(/\s+/, '+')
    tag(:link,
        :href => "#{GOOGLE_FONT_BASE}?family=#{font}:regular,b,i,bi",
        :rel => 'stylesheet', :type => 'text/css')
  end

  def title(title)
    @title = title
  end

  def oneline(&block)
    haml_concat capture_haml(&block).gsub("\n", '').gsub(/>\s+</, '><')
  end
end
