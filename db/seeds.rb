# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create name: 'Unassigned', system_type: Category::TYPE_UNASSIGNED
%w{Grocery Restaurant Utilities Mortgage/Rent Insurance Transportation Children Entertainment Gear Shopping Cash Household Home-Improvement Loans Fees}.each do |category|
	Category.create name: category
end