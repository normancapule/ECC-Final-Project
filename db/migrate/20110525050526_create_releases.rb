class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.integer :project_id
      t.string :name
      t.datetime :date_released

      t.timestamps
    end
  end

  def self.down
    drop_table :releases
  end
end
