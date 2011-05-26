class Release < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  validates_presence_of :name
  
  def release_now
    self.date_released = DateTime.now
  end
end
