class AddReportingTypeToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :reporting_type, :string
  end
end
