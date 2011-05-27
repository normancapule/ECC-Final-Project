class Project < ActiveRecord::Base
  has_many :userprojects
  has_many :users, :through => :userprojects
  has_many :releases
  has_many :stories
  has_many :tags
  validates_presence_of :project_name
  validates_uniqueness_of :project_name
end
