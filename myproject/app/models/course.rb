class Course < ActiveRecord::Base
  belongs_to :user
  has_many :lectures
  # mount_uploader :picture, PictureUploader

  validates :title, presence: true, uniqueness: true
  validates :user_id, presence: true



end
