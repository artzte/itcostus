class CreateMatchers < ActiveRecord::Migration
  def change
    create_table :matchers do |t|
      t.string :words
      t.references :category
      t.timestamps
    end
  end
end
