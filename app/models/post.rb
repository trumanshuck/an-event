class Post < ApplicationRecord
  belongs_to :stop
  has_rich_text :content
end
