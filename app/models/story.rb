class Story < ActiveRecord::Base
  belongs_to :release
  belongs_to :project
  has_many :comments
  has_many :tags
  has_many :ratings
  belongs_to :user #the creator
  validates_presence_of :priority, :story_name, :story_description, :status
  validates_uniqueness_of :story_name, :scope => :release_id
  validates_length_of :story_name, :maximum => 140
end
