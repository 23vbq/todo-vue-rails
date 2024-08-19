class Attachment < ApplicationRecord
  belongs_to :to_do

  validates :to_do_id, :data, presence: true
end
