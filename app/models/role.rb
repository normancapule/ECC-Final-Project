class Role < ActiveRecord::Base
  has_many :memberlists
  has_many :users, :through => :memberlists
end
