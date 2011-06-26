class Quip < ActiveRecord::Base
  belongs_to :site

  validates_presence_of :site, :unless => :nested
  validates_length_of   :text, :minimum => 1

  attr_accessor :nested
end
