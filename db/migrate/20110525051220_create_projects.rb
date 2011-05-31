class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :user_id
      t.string :project_name
      t.string :project_description
      t.string :status, :default => "alive"
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
