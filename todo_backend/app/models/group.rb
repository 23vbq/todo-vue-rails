class Group < ApplicationRecord
  has_many :to_dos

  validates :name, presence: true
  validates :name, uniqueness: { message: 'Group with %{value} name already exists'}
  validates :name, length: {maximum: 20}
end
