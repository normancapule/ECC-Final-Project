class Story < ActiveRecord::Base
  belongs_to :release
  has_many :comments, :tags, :ratings
  belongs_to :user #the creator
end
