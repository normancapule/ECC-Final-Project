class Tag < ActiveRecord::Base
  belongs_to :project
  belongs_to :story
  validates_uniqueness_of :content, :scope => :project_id
  validates_length_of :content, :maximum => 60
end
