class Userproject < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  serialize :role
end
