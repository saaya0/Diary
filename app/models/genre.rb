class Genre < ApplicationRecord
  has_many :diaries

  validates :name, length: { in: 3..10 }, uniqueness: true
end
