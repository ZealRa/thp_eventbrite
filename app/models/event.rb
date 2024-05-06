class Event < ApplicationRecord
  validates :start_date, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, divisible_by: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true

  belongs_to :admin, class_name: "User", foreign_key: "admin_id"
  has_many :attendances
  has_many :participants, through: :attendances, source: :user
end
