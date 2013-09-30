class AddIndexToCategoryTransactions < ActiveRecord::Migration
  def change
    add_index :category_transactions, :category_id
    add_index :category_transactions, :transaction_id

    add_index :transactions, :posted_at
    add_index :categories, :name, unique: true
  end
end
