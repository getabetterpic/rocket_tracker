class User < ApplicationRecord
  include ResourceId

  validates :sub, presence: true, uniqueness: true
  validates :resource_id, presence: true

  def as_json(controller_data = {})
    {
      id: resource_id,
      name: name,
      email: email
    }
  end
end
