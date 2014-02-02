class TransactionsController < ApplicationController
  respond_to :json

  before_filter only: [:index] do
    get_to_from
  end
  
  def index
    transactions = Transaction.with_category_transaction.with_matcher.order(:posted_at)

    transactions = transactions.from_date @from if @from
    transactions = transactions.to_date @to if @to    

    render json: transactions 
  end

  def update
    transaction = Transaction.find(params[:id])
    transaction.update_attributes(transaction_params)
    render json: transaction
  end

protected
  def transaction_params
    params.require(:transaction).permit(:note)
  end

end
