class ToDo < ApplicationRecord
  belongs_to :group
  has_many :attachments
end
