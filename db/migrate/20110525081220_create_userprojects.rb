class CreateUserprojects < ActiveRecord::Migration
  def self.up
    create_table :userprojects do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :role
      t.string :role_description

      t.timestamps
    end
  end

  def self.down
    drop_table :userprojects
  end
end
