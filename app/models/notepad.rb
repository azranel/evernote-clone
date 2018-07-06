class Notepad < ApplicationRecord
  has_many :notes

  validates :title, presence: true,
              length: { maximum: 20},
              uniqueness: true
end
