class BadgeObserver < ActiveRecord::Observer
  observe :user

  def after_create(model)
    Badge.grant(model, :create)
  end
end
