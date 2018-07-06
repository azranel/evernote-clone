class Notepad < ApplicationRecord
  has_many :notes

  validates :title, presence: true,
              length: { maximum: 50},
              uniqueness: true
end
