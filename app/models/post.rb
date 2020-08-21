class Post < ApplicationRecord
  belongs_to :stop
  has_rich_text :content

  validates :title, :slug, presence: true

  delegate :to_param, to: :slug

  scope :in_order, -> { order(created_at: :desc) }

  def self.first_at(stop)
    where(stop: stop).in_order.last
  end

  def self.last_at(stop)
    where(stop: stop).in_order.first
  end

  def self.next(post)
    where(stop: post.stop)
      .where(arel_table[:created_at].gt(post.created_at))
      .in_order
      .last
  end

  def self.previous(post)
    where(stop: post.stop)
      .where(arel_table[:created_at].lt(post.created_at))
      .in_order
      .first
  end
end
