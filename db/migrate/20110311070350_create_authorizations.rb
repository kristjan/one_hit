class CreateAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :authorizations do |t|
      t.integer :user_id,  :null => false
      t.string  :provider, :null => false
      t.string  :uid,      :null => false
      t.string  :token
      t.string  :secret

      t.timestamps
    end

    add_index :authorizations, :user_id
    add_index :authorizations, [:provider, :uid], :unique => true
  end

  def self.down
    drop_table :authorizations
  end
end
