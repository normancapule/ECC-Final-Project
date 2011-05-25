class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :stories
  validates_presence_of :tag_content
end
