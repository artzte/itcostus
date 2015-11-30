class CategoryTransaction < ActiveRecord::Base
  validates_presence_of :transaction, :matcher, :category
  belongs_to :linked_transaction, foreign_key: 'transaction_id', class_name: Transaction
  belongs_to :matcher
  belongs_to :category

  before_destroy do
    if matcher.transactions.count == 1
      matcher.delete
    end
  end
end
