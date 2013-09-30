class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :total, :count

  def count
    transactions.count
  end

  def total
    transactions.sum(:amount)
  end

protected
  def transactions
    txns = object.transactions
    txns = txns.to_date options[:to] if options[:to]
    txns = txns.from_date options[:from] if options[:from]
    txns
  end
end