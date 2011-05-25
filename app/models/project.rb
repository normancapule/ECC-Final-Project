class Project < ActiveRecord::Base
  belongs_to :user
  has_many :memberlists
  has_many :users, :through => :memberlists
  has_many :releases
end
