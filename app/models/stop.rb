class Stop < ApplicationRecord
  has_one_attached :splash
  has_many :posts

  delegate :to_param, to: :slug
end
