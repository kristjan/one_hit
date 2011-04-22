class Badge::AHundredEyeballs < Badge
  extend Badge::Eyeballs

  DESCRIPTION = <<-TXT
    100 is a lot! That's, like, an entire centureye.
  TXT
  THRESHOLD = 100
end
