class Stop < ApplicationRecord
  has_one_attached :splash

  delegate :to_param, to: :slug
end
