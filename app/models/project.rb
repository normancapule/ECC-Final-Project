class Project < ActiveRecord::Base
  has_many :userprojects
  has_many :users, :through => :userprojects
  has_many :releases
end
