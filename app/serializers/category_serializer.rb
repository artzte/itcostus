class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :system_type, :matcher_ids, :count

  def attributes
    data = super
    if options[:transactions]
      data[:transactions] = transactions
    end
    data
  end

  def count
    object.transactions.count
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
    txns = if object.unassigned?
      Transaction
        .joins("LEFT JOIN category_transactions ct ON (ct.transaction_id = transactions.id)")
        .where("ct.id IS NULL")
    else
      object.transactions
    end
    txns = txns.to_date options[:to] if options[:to]
    txns = txns.from_date options[:from] if options[:from]
    txns.sorted
  end
end