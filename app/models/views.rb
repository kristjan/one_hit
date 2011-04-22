class Views < ActiveRecord::Base
  TIME_PERIODS = %w[today this_week all_time].map(&:to_sym).freeze

  belongs_to :site

  validates_presence_of :site

  def self.rollover!
    all.each(&:rollover!)
  end

  def badge_target
    site.creator
  end

  def counts
    TIME_PERIODS.map{|period| send(period)}
  end

  def rollover!
    resets = {:today => 0}
    resets[:this_week] = 0 if Date.today.cwday == 1 # Monday
    update_attributes!(resets)
  end

  def view!
    increments = Hash[TIME_PERIODS.map{|period| [period, 1]}]
    self.class.update_counters self.id, increments
    TIME_PERIODS.map{|period| increment(period)}
    Badge.grant(self) # Can't observe this because after_update doesn't fire
  end
end
