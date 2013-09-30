class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.string :account
      t.timestamp :posted_at
      t.string :description
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :transaction_type
      t.references :category_override
      t.timestamps
    end
    add_index :transactions, :posted_at
  end
end
