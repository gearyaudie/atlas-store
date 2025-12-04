class Category < ApplicationRecord
  has_many :menus, dependent: :destroy

  validates :name, presence: true

  STATUSES = { active: "active", inactive: "inactive" }.freeze

  def status_enum
    STATUSES.keys.map(&:to_s)
  end
end
