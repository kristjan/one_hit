class Authorization < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :provider
  validates_presence_of :uid

  validates_uniqueness_of :provider, :scope => :user_id
  validates_uniqueness_of :uid,      :scope => :provider
end
