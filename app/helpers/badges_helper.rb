module BadgesHelper
  BADGE_SIZE = 75

  def badge_tag(badge)
    image_tag badge.image_path, :alt => badge.to_s, :title => badge.to_s,
      :width => BADGE_SIZE, :height => BADGE_SIZE
  end
end
