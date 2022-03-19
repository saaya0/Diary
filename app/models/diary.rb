class Diary < ApplicationRecord
  belongs_to :genre

  validates :title, length: { in: 1..20 }
  validates :genre_id, presence: true
  validates :sentence, length: { in: 1..500 }
  validates :learning_time, format: { with: /\A[0-9]+\z/ }
end
