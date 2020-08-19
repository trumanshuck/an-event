class Post < ApplicationRecord
  belongs_to :stop
  has_rich_text :content

  delegate :to_param, to: :slug
end
