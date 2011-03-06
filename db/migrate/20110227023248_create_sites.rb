class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string  :name, :null => false
      t.string  :url,  :null => false
      t.integer :creator_id

      t.timestamps
    end

    add_index :sites, :url, :unique => true
  end

  def self.down
    drop_table :sites
  end
end
