class Matcher < ActiveRecord::Base
  has_many :category_transactions
  has_many :transactions, through: :category_transactions
  belongs_to :category

  validates_format_of :words, with: /\w{3,}/, message: 'must be nonblank string with at least a three-character word present'
  validates_presence_of :category

  after_update do 
    if words_changed?
      @split_words = nil
    end
  end

  after_update do
    if words_changed? or category_id_changed?
      CategoryTransaction.where(matcher_id: id).delete_all
      run Category.unassigned.transactions
    end
  end

  def split_words
    @split_words ||= words.downcase.split
  end

  def match transaction
    return false unless words.present?

    common = split_words & transaction.split_words
    return false unless common.present?

    # ensure all common phrases are present
    return false unless split_words - common == []

    # successful match if the transaction contains all the words in the matcher
    return category
  end

  def run transactions
    matched = []
    transactions.each do |t|
      if match(t)
        CategoryTransaction.create! matcher: self, transaction: t, category: category
        matched << t
      end
    end
    matched
  end

  def self.sorted
    joins("LEFT JOIN categories ON categories.id = matchers.category_id")
    .order("categories.name, matchers.words")
  end

end

