class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :story_id
      t.string :content
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
