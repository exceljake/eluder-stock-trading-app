class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :properties, dependent: :destroy

  validates :overall_worth, presence:true 
end
