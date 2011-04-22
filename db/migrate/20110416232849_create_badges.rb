class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.integer :user_id, :null => false
      t.string  :type,    :null => false

      t.timestamps
    end

    add_index :badges, :user_id
    add_index :badges, :type
  end

  def self.down
    drop_table :badges
  end
end
