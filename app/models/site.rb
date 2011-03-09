require 'array_extensions'

class Site < ActiveRecord::Base
  has_one  :creator, :class_name => 'User'
  has_many :quips, :dependent => :destroy

  before_validation :downcase_url

  validates_length_of :name,  :minimum => 1
  validates_length_of :url,   :minimum => 1
  validates_format_of :url,   :with => /^[-_a-z0-9]+$/,  :allow_blank => true,
    :message => "can include letters, numbers, dashes and underscores"
  validates_uniqueness_of :url

  def self.fetch(url)
    find_by_url(url.to_s.downcase) if url
  end

  def self.random
    first :order => 'random()', :conditions => "url <> 404"
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

private

  def downcase_url
    self.url.downcase! if url
  end
end
