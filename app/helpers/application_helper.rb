require 'set'

module ApplicationHelper
  def add_stylesheet(sheet)
    (@stylesheets ||= Set.new) << sheet
  end

  def stylesheets
    @stylesheets ||= Set.new
  end

  def title(title)
    @title = title
  end

  def oneline(&block)
    haml_concat capture_haml(&block).gsub("\n", '').gsub(/>\s+</, '><')
  end
end
