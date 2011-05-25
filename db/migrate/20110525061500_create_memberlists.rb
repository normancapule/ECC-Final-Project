class CreateMemberlists < ActiveRecord::Migration
  def self.up
    create_table :memberlists do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :memberlists
  end
end
