class Category < ActiveRecord::Base
  has_many :category_transactions
  has_many :transactions, through: :category_transactions
  has_many :matches, through: :category_transactions
  has_many :matchers

  TYPE_UNASSIGNED = 'unassigned'

  def unassigned?
    self.system_type == TYPE_UNASSIGNED
  end

  def transactions
    if unassigned?
      Transaction
        .joins("LEFT OUTER JOIN category_transactions ON category_transactions.transaction_id = transactions.id")
        .where("category_transactions.id IS NULL")
    else
      super
    end
  end

  def self.unassigned
    where(system_type: TYPE_UNASSIGNED).first
  end

  def self.user
    where(system_type: nil)
  end

end
