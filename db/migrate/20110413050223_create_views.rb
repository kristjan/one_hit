class CreateViews < ActiveRecord::Migration
  def self.up
    create_table :views do |t|
      t.integer :site_id,    :null => false
      t.integer :today,      :default => 0
      t.integer :this_week,  :default => 0
      t.integer :all_time,   :default => 0

      t.timestamps
    end

    add_index :views, :site_id, :unique => true
    %w[today this_week all_time].each do |period|
      add_index :views, period
    end

    Site.all.each do |site|
      site.build_views.save!
    end
  end

  def self.down
    drop_table :views
  end
end
