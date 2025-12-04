class Option < ApplicationRecord
  belongs_to :menu

  validates :name, :price, presence: true

  STATUSES = { active: "active", inactive: "inactive" }.freeze

  def status_enum
    STATUSES.keys.map(&:to_s)
  end
end
