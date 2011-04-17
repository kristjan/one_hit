class Badge < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :type
  validates_presence_of :user
  validates_uniqueness_of :type, :scope => :user_id

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
