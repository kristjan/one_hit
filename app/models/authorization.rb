class Authorization < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :provider
  validates_presence_of :uid

  validates_uniqueness_of :provider, :scope => :user_id
  validates_uniqueness_of :uid,      :scope => :provider

  def self.build(user, hash)
    user ||= User.create!(:name => hash['user_info']['name'])
    user.authorizations.create!(
      :provider => hash['provider'],
      :uid      => hash['uid'],
      :token    => hash['credentials']['token'],
      :secret   => hash['credentials']['secret']
    )
  end

  def self.find_by_hash(hash)
    return nil if hash['provider'].blank? || hash['uid'].blank?
    self.find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.find_or_build(hash, user)
    find_by_hash(hash) || build(user, hash)
  end
end
