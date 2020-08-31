class Thought < ApplicationRecord
  has_rich_text :content

  validates :name, presence: true
end
