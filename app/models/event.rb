class Event < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 30 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :event_date, presence: true
  validates :size, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :image, presence: true
  validate :valid_date?
  has_many :tickets

  def valid_date?
    if event_date.past?
      errors.add(event_date.to_s, "- invalid date, date can not be set in past!");
    end
  end

end
