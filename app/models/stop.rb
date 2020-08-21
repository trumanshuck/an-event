class Stop < ApplicationRecord
  has_one_attached :splash
  has_many :posts

  validates :name, :from, :to, :lat, :lng, :slug, presence: true

  delegate :to_param, to: :slug
end
