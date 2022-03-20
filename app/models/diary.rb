class Diary < ApplicationRecord
  belongs_to :genre

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } #今日の日記投稿数

  validates :title, length: { in: 1..20 }
  validates :genre_id, presence: true
  validates :sentence, length: { in: 1..500 }
  validates :learning_time, format: { with: /\A[0-9]+\z/ } #半角数字有効

end
