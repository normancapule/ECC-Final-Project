class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :release_id
      t.integer :user_id
      t.integer :project_id
      t.string :priority
      t.string :story_name
      t.string :story_description
      t.string :status, :default => "start"
      t.string :tag

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
