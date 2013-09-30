class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :system_type
      t.timestamps
    end
    add_index :categories, :name, unique: true
    
    create_table :category_transactions do |t|
      t.references :matcher
      t.references :category
      t.references :transaction
    end
    add_index :category_transactions, :category_id
    add_index :category_transactions, :transaction_id
    add_index :category_transactions, :matcher_id
  end
end
