class Customer < ApplicationRecord
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :registered_at, presence: true

end
