class Category < ActiveRecord::Base
  has_many :category_transactions
  has_many :transactions, through: :category_transactions
  has_many :matches, through: :category_transactions
  has_many :matchers

  TYPE_UNASSIGNED = 'unassigned'

  def unassigned?
    self.system_type == TYPE_UNASSIGNED
  end

  def transactions
    if unassigned?
      Transaction
        .joins("LEFT OUTER JOIN category_transactions ON category_transactions.transaction_id = transactions.id")
        .where("category_transactions.id IS NULL")
    else
      super
    end
  end

  def self.unassigned
    where(system_type: TYPE_UNASSIGNED).first
  end

  def self.user
    where(system_type: nil)
  end

  def self.budgetary
    where(reporting_type: 'budget')
  end

  def month_summaries
    if unassigned?
      connection
        .select_rows %Q{
          select date_format(t.posted_at, "%Y-%m"), sum(t.amount) from transactions t
          left join category_transactions ct ON ct.transaction_id = t.id
          where ct.id IS NULL
          group by year(t.posted_at), month(t.posted_at)
        }
    else
      connection
        .select_rows %Q{
          select date_format(t.posted_at, "%Y-%m"), sum(t.amount) from transactions t
          inner join category_transactions ct ON ct.transaction_id = t.id AND ct.category_id = #{id}
          group by year(t.posted_at), month(t.posted_at)
        }
    end
  end
end
