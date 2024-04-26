class Pesan < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :text, presence: true
end
