class Badge::TenEyeballs < Badge
  extend Badge::Eyeballs

  DESCRIPTION = <<-TXT
    You got 10 eyes on your site! Well, 10 pairs, so 20 eyes. They were
    probably mostly you, huh? At any rate, keep up the good work.
  TXT
  THRESHOLD = 10
end
