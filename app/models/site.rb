require 'array_extensions'

class Site < ActiveRecord::Base
  has_many :quips, :dependent => :destroy
  accepts_nested_attributes_for :quips, :allow_destroy => true

  validates_length_of :name,  :minimum => 1
  validates_length_of :url,   :minimum => 1
  validates_format_of :url,   :with => /^[-_a-z1-9]+$/i,  :allow_blank => true,
    :message => "can include letters, numbers, dashes and underscores"
  validates_uniqueness_of :url

  def self.random
    first :order => 'random()'
  end

  def random_quip
    quips.rand
  end

  def singleton?
    quips.size <= 1
  end

  def to_param
    url
  end
end
