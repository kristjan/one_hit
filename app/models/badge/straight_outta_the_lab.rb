class Badge::StraightOuttaTheLab < Badge
  DEADLINE = Date.new(2011,7,1)
  DESCRIPTION = <<-TXT
    Joined up early, when most of the place was on fire and void demons were a
    daily occurence
  TXT

  def self.grant(user)
    return unless Date.today < DEADLINE
    return unless user.is_a?(User)
    self.create(:user => user)
  end
end

