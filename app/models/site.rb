class Site < ActiveRecord::Base
  has_many :quips, :dependent => :destroy
  accepts_nested_attributes_for :quips, :allow_destroy => true

  validates_length_of :name, :minimum => 1
  validates_format_of :slug, :with => /^[-_a-z1-9]+$/i
  validates_uniqueness_of :slug

  def to_param
    slug
  end
end
