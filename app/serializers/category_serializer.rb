class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :usage, :count, :amount

  has_many :matchers
  has_many :transactions

  def count
    object.transactions.count
  end

  def sum
    object.transactions.sum(:amount)
  end

  def amount
    object.transactions.sum(:amount)
  end

  def usage
    object.system_type
  end
end
