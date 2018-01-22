class Event < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 30 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :event_date, presence: true
  validates :size, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :image, presence: true
  has_many :tickets
end
