class Kit < ApplicationRecord
  belongs_to :manufacturer

  validates :name, :manufacturer_id, presence: true
end
