require 'test_helper'

describe Matcher do

  setup do
    @category = Category.create name: "Test"

    @descriptions = [
      "joes grocery store 102133",
      "joes grocery store 100222",
      "corner gas station 33322",
      "janes hardware emporium west 39th",
    ]

    @descriptions.each do |t|
      Transaction.create! description: t
    end
  end

  it "matches full string" do
    m = Matcher.create! words: "joes grocery store 102133", category: @category
    m.run Transaction.all

    CategoryTransaction.count.must_equal 1
    CategoryTransaction.first.transaction.description.must_equal @descriptions.first
  end

  it "matches some words" do
    m = Matcher.create! words: "joes 102133", category: @category
    m.run Transaction.all

    CategoryTransaction.count.must_equal 1
    CategoryTransaction.first.transaction.description.must_equal @descriptions.first
  end

  it "matches twist" do
    m = Matcher.new words: "TWIST SEATTLE WA US"
    t = Transaction.new description: "TWIST                    SEATTLE      WA US"
    m.match(t).must_equal true

    t = Transaction.new description: "UNITED ENERGY            FLETCHER     NC US"
    m.match(t).must_equal false
  end


end


