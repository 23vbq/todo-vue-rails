class ToDo < ApplicationRecord
  belongs_to :group
  has_many :attachments

  validates :group, :date_creation, :title, presence: true
end
