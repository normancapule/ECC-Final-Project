class Story < ActiveRecord::Base
  belongs_to :release
  has_many :comments
  has_many :tags
  has_many :ratings
  belongs_to :user #the creator
  serialize :tag #check for length <= 60
  validates_presence_of :priority, :story_name, :story_description, :status
  validate :count
  

  private
    def count
      if self.story_name.length > 140
        errors[:base] << "Story name has exceeded the limit"
      end
    end
end
