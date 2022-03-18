class Diary < ApplicationRecord
  belongs_to :genre

  validates :title, length: { in: 1..10 }
  validates :genre_id, presence: true
  validates :sentence, length: { in: 1..200 }
end
