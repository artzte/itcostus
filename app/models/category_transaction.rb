class CategoryTransaction < ActiveRecord::Base
  validates_presence_of :transaction, :matcher, :category
  belongs_to :transaction
  belongs_to :matcher
  belongs_to :category
end
