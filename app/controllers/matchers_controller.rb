class MatchersController < ApplicationController
  before_filter only: [:show, :update, :destroy] do
    @matcher = Matcher.find params[:id]
  end

  def index
    render json: Matcher.includes(:category_transactions).sorted
  end

  def create
  	matcher = Matcher.new matcher_params
    if matcher.save
      matcher.run Transaction.unassigned
      render json: matcher
    else
      render json: matcher, status: :bad_request
    end
  end

  def match_transactions
    transactions = Transaction
      .where(id: match_transactions_params[:transaction_ids])
      .includes :category_transaction
    category = Category.find match_transactions_params[:category_id]

    # destroy any attached matchers
    CategoryTransaction
      .where(transaction_id: transactions.collect(&:id))
      .destroy_all

    # clear any attached matchers, then build a new matcher and connect it
    transactions.each do |transaction|
      matcher = Matcher.create category: category, transaction_id: transaction.transaction_id
      matcher.run transaction, true
    end

    render json: transactions
  end

  def show
    render json: @matcher
  end

  def update
    @matcher.attributes = matcher_params
    if @matcher.update_attributes matcher_params
      @matcher.category_transactions.load
    end
    render json: @matcher
  end

  def destroy
    @matcher.destroy
    render nothing: true
  end

protected

  def matcher_params
    params.require(:matcher).permit(:category_id, :words)
  end

  def match_transactions_params
    params.require(:matcher).permit(:category_id, :transaction_ids => [])
  end

end
