class Stop < ApplicationRecord
  has_one_attached :splash
  has_many :posts

  validates :name, :from, :to, :lat, :lng, :slug, presence: true

  delegate :to_param, to: :slug

  scope :past, -> {where(arel_table[:to].lteq(Date.today))}

  def self.previous(stop)
    past.where(arel_table[:to].lt(stop.to)).order(from: :desc).first
  end

  def self.next(stop)
    past.where(arel_table[:to].gt(stop.to)).order(from: :asc).first
  end
end
