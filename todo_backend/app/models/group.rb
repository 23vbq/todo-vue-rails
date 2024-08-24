class Group < ApplicationRecord
  has_many :to_dos

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {maximum: 20}
end
