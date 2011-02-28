class CreateQuips < ActiveRecord::Migration
  def self.up
    create_table :quips do |t|
      t.integer :site_id
      t.string :text
      t.timestamps
    end

    add_index :quips, :site_id
  end

  def self.down
    drop_table :quips
  end
end
