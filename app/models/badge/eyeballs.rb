module Badge::Eyeballs
  def grant(views)
    return unless views.is_a?(Views)
    return unless views.all_time == threshold
    self.create(:user => views.badge_target)
  end

  def threshold
    self::THRESHOLD
  end
end
