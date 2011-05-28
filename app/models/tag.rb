class Tag < ActiveRecord::Base
  belongs_to :project
  belongs_to :story
  validate :cannot_be_shared
  validates_length_of :content, :maximum => 60
  
  private
    def cannot_be_shared
      if Tag.where("content=? AND project_id!=?", self.content, self.project_id).count>0
        errors[:base] << %Q{#{self.content} already exist in another project}
      end
    end
end
