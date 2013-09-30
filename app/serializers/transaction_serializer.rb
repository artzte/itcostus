class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :_transaction_date, :_description, :_transtype, :_amount, :_transaction_id, :account, :posted_at, :description, :amount, :transaction_type, :matcher_id, :category_id
end