class Search < ActiveRecord::Base
  belongs_to :user

  validates :search_name, presence: true
  validates :user_id, presence: true
end
