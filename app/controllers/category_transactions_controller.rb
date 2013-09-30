class CategoryTransactionsController < ApplicationController
  before_filter do
    get_category params[:category_id]
    get_to_from
  end

  def index
    if @category
      transactions = @category.transactions
    else
      transactions = Transaction.unassigned
    end
    transactions = transactions.from_date @from if @from
    transactions = transactions.to_date @to if @to

    render json: transactions
  end
end
