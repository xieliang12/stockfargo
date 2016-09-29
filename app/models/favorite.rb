class Favorite < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :stock_id, presence: true
end
