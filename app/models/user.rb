class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password!

  validates_uniqueness_of :email, :allow_blank => true

  def claim_sites(urls)
    sites = urls.map{|url| Site.fetch(url)}
    sites.each {|site| site.update_attributes(:creator_id => self.id)}
  end

  def encrypt_password!
    unless password.blank?
      self.crypted_password = Digest::SHA1.hexdigest(password)
    end
  end
end
