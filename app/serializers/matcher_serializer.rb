class MatcherSerializer < ActiveModel::Serializer
  attributes :id, :category_id, :words, :transaction_ids

  def transaction_ids
  	Matcher.connection.select_values %Q{
  		  SELECT txn.id
        FROM transactions txn
        INNER JOIN category_transactions ct ON ct.transaction_id = txn.id AND ct.matcher_id = #{object.id}
      }
  end
end
