class Stop < ApplicationRecord
  has_one_attached :splash
  has_many :posts

  validates :name, :from, :to, :lat, :lng, :slug, presence: true

  delegate :to_param, to: :slug

  def self.previous(stop)
    where(arel_table[:to].lt(stop.to)).order(from: :desc).first
  end

  def self.next(stop)
    where(arel_table[:to].gt(stop.to)).order(from: :asc).first
  end
end
