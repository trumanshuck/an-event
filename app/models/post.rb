class Post < ApplicationRecord
  belongs_to :stop
  has_rich_text :content

  validates :title, :slug, presence: true

  delegate :to_param, to: :slug
end
