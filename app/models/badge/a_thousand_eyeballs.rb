class Badge::AThousandEyeballs < Badge
  extend Badge::Eyeballs

  DESCRIPTION = <<-TXT
    1000! Wow! That's quite a collection, even if it's getting a little gross.
  TXT
  THRESHOLD = 1000
end
