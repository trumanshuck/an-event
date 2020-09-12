class Email < ApplicationRecord
  has_rich_text :content
  validates :email, presence: true
end
