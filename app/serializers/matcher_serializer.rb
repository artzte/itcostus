class MatcherSerializer < ActiveModel::Serializer
  attributes :id, :category_id, :words

  def attributes
    attrs = super
    if options[:transactions]
      attrs[:transaction_ids] = transaction_ids
    end
    unless object.valid?
      attrs[:errors] = object.errors.messages
    end
    attrs
  end

  def transaction_ids
  	Matcher.connection.select_values %Q{
  		  SELECT txn.id
        FROM transactions txn
        INNER JOIN category_transactions ct ON ct.transaction_id = txn.id AND ct.matcher_id = #{object.id}
      }
  end
end
