class Matcher < ActiveRecord::Base
  has_many :category_transactions, dependent: :destroy
  has_many :transactions, through: :category_transactions
  belongs_to :category

  validates_format_of :words, with: /\w{2,}/, message: 'must be nonblank string with at least a three-character word present', unless: Proc.new{|m| m.transaction_id.present?}
  validates_presence_of :category

  after_update do 
    if words_changed?
      @split_words = nil
    end
  end

  after_update do
    if words_changed? or category_id_changed?
      category_transactions.delete_all
      run Category.unassigned.transactions
    end
  end

  # creates a word list to match a transaction against. The terms are scrubbed
  # of non-word characters.
  def split_words
    @split_words ||= words
      .downcase
      .split
      .collect{|w| w.gsub /\W/, ''}
  end

  def match transaction, force = false
    return true if force 

    if transaction_id?
      return transaction.id == self.transaction_id
    end

    return false unless words.present?

    common = split_words & transaction.split_words
    return false unless common.present?

    # ensure all common phrases are present
    return false unless split_words - common == []

    # successful match if the transaction contains all the words in the matcher
    return true
  end

  def run transactions, force = false
    transactions = [transactions].flatten
    matched = []
    transactions.each do |t|
      if force || match(t)
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

  def self.text_based
    where(transaction_id: nil)
  end

  def self.run transactions
    matchers = Matcher.order("char_length(words) DESC")
    matchers.each do |matcher|
      matcher.run transactions
      transactions.reload
    end
  end

end

