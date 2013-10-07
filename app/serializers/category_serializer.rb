class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :system_type, :matcher_ids

  def attributes
    data = super
    trans_ids = transaction_ids
    data[:count] = transaction_ids.length
    data[:transaction_ids] = transaction_ids
    data
  end
    
  def total
    transactions.sum(:amount)
  end

  def transaction_ids
    join_sql = if object.unassigned?
        "LEFT JOIN category_transactions ct ON (ct.transaction_id = txn.id) AND (ct.category_id IS NULL)"
      else
        "INNER JOIN category_transactions ct ON (ct.transaction_id = txn.id) AND (ct.category_id = #{object.id})"
      end

    Category.connection.select_values %Q{
        SELECT txn.id
        FROM transactions txn
        #{join_sql}
      }
  end

  def matcher_ids
    Matcher.connection.select_values %Q{
        SELECT matchers.id
        FROM matchers
        WHERE matchers.category_id = #{object.id}
      }
  end

protected
  def transactions
    txns = object.transactions
    txns = txns.to_date options[:to] if options[:to]
    txns = txns.from_date options[:from] if options[:from]
    txns
  end
end