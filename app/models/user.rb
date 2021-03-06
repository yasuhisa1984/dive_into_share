class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_many :posts
  has_many :comments

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 280 }

  mount_uploader :image, ImageUploader

  def can_comment?(post)
    teams.exists?(id: post.category.team.id)
  end

  def can_delete_comment?(comment)
    self == comment.user
  end
end
