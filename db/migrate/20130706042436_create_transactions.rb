class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :_transaction_date
      t.string :_description
      t.string :_transtype
      t.string :_amount
      t.string :_transaction_id
      t.string :account
      t.timestamp :posted_at
      t.string :description
      t.decimal :amount, :precision => 8, :scale => 2
      t.string :transaction_type
      t.string :category
      t.string :category_override
      t.timestamps
    end

    create_table :category_matchers do |t|
      t.string :category
      t.text :value
      t.string :matched_column
      t.text :matcher_type
    end
  end
end
