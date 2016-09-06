class Favorite < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user

  validates :user_id, presence: true
  validates :stock_id, presence: true
end
