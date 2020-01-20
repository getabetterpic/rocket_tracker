class Manufacturer < ApplicationRecord
  has_many :kits
  has_many :motors
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
