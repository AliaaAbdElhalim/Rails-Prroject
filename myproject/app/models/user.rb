class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    mount_uploader :userimage, ImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    
  acts_as_voter

  has_many :courses
  has_many :comments
  has_many :lectures

  # validates_processing_of:picture
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :status, presence: true
  validates :dob, presence: true
  
end
	