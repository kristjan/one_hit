class Views < ActiveRecord::Base
  belongs_to :site

  validates_presence_of :site
end
