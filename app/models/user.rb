class User < ActiveRecord::Base
  validates_presence_of :role, :name, :email
  validates_format_of :role, :with => /^(Admin)|(User)$/, :message=>"should be Admin or User"
  validates_format_of :email, :with => /^[\w\d]*[@][\w\d]*[\.][\w\d]*$/, :message=>"email is not applicable"
  
  has_many :memberlists
  has_many :roles, :through => :memberlists
  has_many :projects, :through => :memberlists #joined a project "USER"
  has_one :project  #created a project
  has_many :ratings
  has_many :tags
  has_many :stories
  has_many :comments
  has_many :logs
end
