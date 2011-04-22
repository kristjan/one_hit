class Badge < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :type
  validates_presence_of :user
  validates_uniqueness_of :type, :scope => :user_id

  def self.description
    const_get('DESCRIPTION').squish
  end

  def self.grant(model)
    descendants.each do |badge|
      badge.grant(model) unless badge.granted?(model.badge_target)
    end
  end

  def self.require_descendants
    Dir[File.join(File.dirname(__FILE__), 'badge', '*')].each do |badge|
      require badge
    end
  end

  def self.granted?(user)
    self.exists?(:user_id => user.id)
  end

  def description
    self.class.description
  end

  def image_path
    "badges/#{to_s(:underscore)}.png"
  end

  def to_s(format=nil)
    case format
    when nil: self.class.model_name.human.titleize
    when :underscore: self.class.model_name.split('::').last.underscore
    else; super()
    end
  end
end

Badge.require_descendants
