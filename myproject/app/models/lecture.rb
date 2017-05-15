class Lecture < ActiveRecord::Base
  belongs_to :Course
  belongs_to :Lecture
  has_many :comments 
  mount_uploader :attachement, AttachmentUploader
  acts_as_votable

end
