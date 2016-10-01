class Post < ActiveRecord::Base
  belongs_to :favorite
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :post_type, presence: true
  validates :text, presence: true
  scope :persisted, lambda { where.not(id: nil) }
end
