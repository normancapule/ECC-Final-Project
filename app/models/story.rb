class Story < ActiveRecord::Base
  belongs_to :release
  has_many :comments
  has_many :tags
  has_many :ratings
  belongs_to :user #the creator
  serialize :tag
  validates_presence_of :priority, :story_name, :story_description, :status
end
