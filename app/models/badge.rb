class Badge < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :type
  validates_presence_of :user
  validates_uniqueness_of :type, :scope => :user_id

  def self.grant(model, event)
    descendants.each do |badge|
      badge.grant(model, event) unless badge.granted?(model.badge_target)
    end
  end

  def self.granted?(user)
    self.exists?(:user_id => user.id)
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

  class StraightOuttaTheLab < Badge
    DEADLINE = Date.new(2011,7,1)

    def self.grant(model, event)
      return unless Date.today < DEADLINE
      return unless model.is_a?(User)
      self.create(:user => model)
    end
  end
end
