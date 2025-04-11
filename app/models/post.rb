class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, presence: true
  validates :content, presence: true
end
