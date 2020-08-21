class Post < ApplicationRecord
  belongs_to :stop
  has_rich_text :content

  validates :title, :slug, presence: true

  delegate :to_param, to: :slug

  def self.first_at(stop)
    where(stop: stop).order(created_at: :asc).first
  end

  def self.last_at(stop)
    where(stop: stop).order(created_at: :desc).first
  end

  def self.next(post)
    where(stop: post.stop)
      .where(arel_table[:created_at].gt(post.created_at))
      .order(created_at: :asc)
      .first
  end

  def self.previous(post)
    where(stop: post.stop)
      .where(arel_table[:created_at].lt(post.created_at))
      .order(created_at: :desc)
      .first
  end
end
