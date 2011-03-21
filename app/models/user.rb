class User < ActiveRecord::Base
  attr_accessor :password

  has_many :authorizations

  before_save :encrypt_password!

  validates_uniqueness_of :email, :allow_blank => true

  def self.encrypt_password(password)
    Digest::SHA1.hexdigest(password)
  end

  def self.find_by_login(info)
    return nil if info[:email].blank?
    user = User.find_by_email(info[:email])
    return nil unless user
    if user.password_matches?(info[:password])
      return user
    else
      return User.new(:email => info[:email])
    end
  end

  def claim_sites(urls)
    sites = urls.map{|url| Site.fetch(url)}
    sites.each {|site| site.update_attributes(:creator_id => self.id)}
  end

  def encrypt_password!
    unless password.blank?
      self.crypted_password = User.encrypt_password(password)
    end
  end

  def password_matches?(pass)
    User.encrypt_password(pass) == self.crypted_password
  end
end
