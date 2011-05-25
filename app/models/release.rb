class Release < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  validates_presence_of :name
end
