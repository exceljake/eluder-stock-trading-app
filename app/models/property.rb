class Property < ApplicationRecord
  belongs_to :portfolio
  belongs_to :stock

  validates :quantity, presence: true 
  
  default_scope { order(quantity: :desc) }
end
