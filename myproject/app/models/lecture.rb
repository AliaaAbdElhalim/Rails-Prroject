class Lecture < ActiveRecord::Base
  belongs_to :course
  belongs_to :user
  has_many :comments 

mount_uploader :lecattachement, AttachementUploader
  acts_as_votable
  validates :title, presence: true
  
  validates :content, presence: true
  validates :course_id, presence: true
  validates :user_id, presence: true

end
