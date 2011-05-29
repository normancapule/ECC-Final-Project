class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :name, :traverse_project_id
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
  
  scope :admin, where(:role => 'Admin')
  scope :user, where(:role => 'User')
  
  def project_role?(project_id)
    userp = userprojects.where(:project_id=>project_id, :user_id=>self.id)
    temp = []
    userp.each do |inside|
      temp << inside.role.downcase
    end
    temp
  end
  
  def check_role?(input_role)
    project_role?(self.traverse_project_id).include?(input_role.to_s.downcase)
  end
  
  def role?(input_role)
    role.downcase == input_role.to_s.downcase
  end
  
end
