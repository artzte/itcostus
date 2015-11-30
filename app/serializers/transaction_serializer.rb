class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :account, :posted_at, :description, :note, :amount, :transaction_type

  belongs_to :category
  has_many :matcher

  def matcher
    object.matcher_id
  end

  def category
    object.category_id
  end
end
