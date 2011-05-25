class User < ActiveRecord::Base
  validates_presence_of :role, :name, :email
  validates_format_of :role, :with => /^(Admin)|(User)$/, :message=>"should be Admin or User"
  validates_format_of :email, :with => /^[\w\d]*[@][\w\d]*[\.][\w\d]*$/, :message=>"email is not applicable"
  
  has_many :userprojects
  has_many :projects, :through => :userprojects
  has_many :roles, :through => :userprojects
  has_many :ratings
  has_many :tags
  has_many :stories
  has_many :comments
  has_many :logs
end
