module ResourceId
  extend ActiveSupport::Concern

  PREFIX = {
    'User' => 'USR'
  }.freeze

  included { before_validation :assign_resource_id, on: :create }

  private

  def assign_resource_id
    prefix = PREFIX[self.class.base_class.to_s]
    id = loop do
      id = "#{prefix}#{SecureRandom.uuid.gsub('-', '')}"
      break id unless self.class.where(resource_id: id).exists?
    end
    self.resource_id = id
  end
end
