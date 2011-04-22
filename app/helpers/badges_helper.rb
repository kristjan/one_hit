module BadgesHelper
  BADGE_SIZE = 75

  def badge_image(badge)
    image_tag badge.image_path, :alt => badge.to_s, :title => '',
      :width => BADGE_SIZE, :height => BADGE_SIZE
  end
end
