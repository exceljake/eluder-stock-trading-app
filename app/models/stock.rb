class Stock < ApplicationRecord
  has_many :transactions
  has_many :properties

  default_scope { order(symbol: :asc) }
end
