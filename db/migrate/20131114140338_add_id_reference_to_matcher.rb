class AddIdReferenceToMatcher < ActiveRecord::Migration
  def change
    add_column :matchers, :transaction_id, :string
  end
end
