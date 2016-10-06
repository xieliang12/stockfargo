class Favorite < ActiveRecord::Base
  belongs_to :stock
  belongs_to :user
  has_many :posts
  has_and_belongs_to_many :tags, uniq: true

  validates :user_id, presence: true
  validates :stock_id, presence: true

  def self.tagged_with(name)
    Tag.find_by_name!(name).favorites
  end
  
  def tag_list
    tags.map(&:name)
  end

  def tag_list=(names)
    names.split(",").each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end
end
