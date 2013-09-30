class TransactionsController < ApplicationController
  respond_to :json

  before_filter only: [:index] do
    get_to_from
  end
  
  def index
    transactions = Transaction.with_matcher

    transactions = transactions.from_date @from if @from
    transactions = transactions.to_date @to if @to    

    render json: transactions 
  end

end
