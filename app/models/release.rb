class Release < ActiveRecord::Base
  belongs_to :project
  has_many :stories, :dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :project_id

  def release_now
    self.date_released = DateTime.now
  end
end
