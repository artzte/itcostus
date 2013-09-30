class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end
    create_table :category_transactions do |t|
      t.references :matcher
      t.references :category
      t.references :transaction
    end
    CategoryMatcher.all.each do |cm|
      Category.create name: cm.category
    end
  end
end
