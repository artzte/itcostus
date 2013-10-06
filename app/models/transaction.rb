require 'CSV'


# Grouped uncategorized transactions
# select description, sum(amount), count(id) as count from transactions 
# where category is null
# group by left(description, 10)
# order by count DESC

class Transaction < ActiveRecord::Base

  has_one :category_transaction
  has_one :category, through: :category_transaction
  has_one :matcher, through: :category_transaction

  attr_accessor :category_id, :matcher_id

  after_find do
    self.category_id = attributes['category_id']
    self.matcher_id = attributes['matcher_id']
  end

  def self.from_date date
    where("posted_at >= ?", date)
  end

  def self.to_date date
    where("posted_at < ?", date)
  end

  def self.with_matcher
    joins('LEFT JOIN category_transactions ON category_transactions.transaction_id = transactions.id')
      .joins('LEFT JOIN matchers ON category_transactions.matcher_id = matchers.id')
      .select('transactions.*, category_transactions.category_id AS category_id, matchers.id AS matcher_id')
  end

  def split_words
    @split_words ||= self.description.split.reject{|w| w.blank?}.collect(&:downcase)
  end

  def self.unassigned
    joins("left join category_transactions on category_transactions.transaction_id = transactions.id")
      .where("category_transactions.id IS NULL")
  end

  def self.run_matchers overwrite = true
    transactions = Transaction.with_matcher
    if overwrite
      CategoryTransaction.delete_all
    else
      transactions = transactions.where(category: nil)
    end

    match_attempts = Matcher.all
    count = transactions.length
    count_matched = 0

    transactions.each do |transaction|
      winner = nil
      CategoryTransaction.where(transaction_id: transaction.id).delete_all
      match_attempts.each do |matcher|
        new_category = matcher.match(transaction)
        if new_category
          winner = matcher
          CategoryTransaction.create transaction: transaction, matcher: winner, category: new_category
          count_matched += 1
          break
        end
      end
      if winner
        puts "matcher #{winner.id} matched #{transaction.description}"
      else
        puts "nothing matched #{transaction.description}"
      end
    end

    puts "matched #{count_matched}/#{count}"

    count_matched
  end

  def self.import filename, account
    CSV.foreach(filename, {:headers => true, :header_converters => :symbol}) do |row, i|
      description = if row[:extdesc].blank?
          row[:description]
        else
          row[:extdesc]
        end
      description = "#{description} #{row[:check_number]}" if row[:check_number].present?
      transtype = row[:trandesc]||"CC Debit"
      transaction_id = row[:transaction_id]

      exists = Transaction
        .where(account: account)
        .where(transaction_id: transaction_id)
        .first
        # .where(_transaction_date: row[:transaction_date])
        # .where(_amount: row[:amount])
        # .where(_description: description)
        # .where(_transtype: transtype)

      # Don't rewrite existing transactions
      next if exists

      time = DateTime.strptime row[:transaction_date], "%m/%d/%Y %l:%M:%S %p"

      transaction_type = if /Credit|Deposit/.match(transtype)
        "Credit"
      else
        "Debit"
      end
      
      Transaction.create posted_at: time,
        transaction_id: transaction_id,
        account: account,
        amount: row[:amount].to_f,
        transaction_type: transaction_type,
        description: description.gsub(/Ext Credit Card (Credit|Debit)\s*/i, '')
    # rescue Exception => e
    #   puts row.inspect if row
    #   puts e.inspect
    end
  end
end
