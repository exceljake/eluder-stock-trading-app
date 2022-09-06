class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :action, presence: true, inclusion: { in: ["buy", "sell"] } 
  validates :quantity, presence: true 
  validates :price, presence: true 
  validates :total_amount, presence: true 

  default_scope { order(created_at: :desc) }

  scope :buy, -> { where(action: "buy") }
  scope :sell, -> { where(action: "sell") }
end
