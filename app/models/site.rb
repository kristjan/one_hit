require 'array_extensions'

class Site < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User'
  has_many   :quips, :dependent => :destroy
  has_one    :views, :dependent => :destroy

  accepts_nested_attributes_for :quips

  before_validation :downcase_url

  validates_length_of :name,  :minimum => 1
  validates_length_of :url,   :minimum => 1
  validates_format_of :url,   :with => /^[-_a-z0-9]+$/,  :allow_blank => true,
    :message => "can include letters, numbers, dashes and underscores"
  validates_uniqueness_of :url

  after_initialize :initialize_views

  def self.fetch(url)
    find_by_url(url.to_s.downcase) if url
  end

  def self.random(n=1)
    sites = all :limit => n, :order => 'random()', :conditions => "url <> '404'"
    n > 1 ? sites : sites.first
  end

  def editable_by?(user)
    creator.nil? || creator == user
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

  def view!
    views.view!
  end

private

  def downcase_url
    self.url.downcase! if url
  end

  def initialize_views
    build_views(:site => self) if new_record?
  end
end
