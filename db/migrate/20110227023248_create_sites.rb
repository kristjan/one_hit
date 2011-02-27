class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string  :name, :null => false
      t.string  :slug, :null => false
      t.integer :creator_id

      t.timestamps
    end

    add_index :sites, :slug, :unique => true
  end

  def self.down
    drop_table :sites
  end
end
