class Views < ActiveRecord::Base
  TIME_PERIODS = %w[today this_week all_time].map(&:to_sym).freeze

  belongs_to :site

  validates_presence_of :site

  def counts
    TIME_PERIODS.map{|period| send(period)}
  end

  def view!
    increments = Hash[TIME_PERIODS.map{|period| [period, 1]}]
    self.class.update_counters self.id, increments
    TIME_PERIODS.map{|period| increment(period)}
  end
end
