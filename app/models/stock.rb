class Stock < ActiveRecord::Base
  has_many :holdings
  has_many :favorites
  accepts_nested_attributes_for :favorites, allow_destroy: true
  accepts_nested_attributes_for :holdings, allow_destroy: true
  def symbol_with_name
    symbol+", "+company_name
  end
end
