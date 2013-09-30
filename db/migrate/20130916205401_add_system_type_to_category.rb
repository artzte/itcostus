class AddSystemTypeToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :system_type, :string
    Category.reset_column_information
    Category.create system_type: Category::TYPE_UNASSIGNED
  end
end
