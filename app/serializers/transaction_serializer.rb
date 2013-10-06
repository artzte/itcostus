class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :account, :posted_at, :description, :amount, :transaction_type
  attributes :matcher_id, :category_id

  def matcher_id
    object.category_transaction && object.category_transaction.matcher_id
  end

  def category_id
    object.category_transaction && object.category_transaction.category_id
  end

end