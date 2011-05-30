class Project < ActiveRecord::Base
  has_many :userprojects, :dependent => :destroy
  has_many :users, :through => :userprojects
  has_many :releases, :dependent => :destroy
  has_many :stories, :dependent => :destroy
  has_many :tags, :dependent => :destroy
  has_many :logs, :dependent => :destroy
  validates_presence_of :project_name
  validates_uniqueness_of :project_name
end
