class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :story_id
      t.integer :user_id
      t.string :tag_content

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
