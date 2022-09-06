class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_one :portfolio, dependent: :destroy
  has_many :properties, through: :portfolio
  has_many :transactions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true, inclusion: { in: ["trader", "admin"] }
  validates :status, presence: true, inclusion: { in: ["pending","approved"] }
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  default_scope { order(last_name: :asc) }
  scope :traders, -> { where(role: "trader") }
  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }

  before_create :set_initial_balance
  before_validation :set_role, :set_status
  before_save :set_capitalize
  
  def set_capitalize
    self.first_name = self.first_name.capitalize
    self.last_name = self.last_name.capitalize
  end

  def set_initial_balance
    self.balance = 10000
  end

  def set_role
    self.role = self.role ||= "trader"
  end

  def set_status
    self.status = self.status ||= "pending"
  end
end
