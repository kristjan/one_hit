class Quip < ActiveRecord::Base
  belongs_to :site

  validates_presence_of :site
  validates_length_of   :text, :minimum => 1
end
