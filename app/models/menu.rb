class Menu < ApplicationRecord
  belongs_to :category
  has_many :options, dependent: :destroy

  validates :name, :price, presence: true

  STATUSES = { active: "active", inactive: "inactive" }.freeze

  def status_enum
    STATUSES.keys.map(&:to_s)
  end
end
