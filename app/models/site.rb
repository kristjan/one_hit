class Site < ActiveRecord::Base
  validates_length_of :name, :minimum => 1
  validates_format_of :slug, :with => /^[-_a-z1-9]+$/i

  def to_param
    slug
  end
end
