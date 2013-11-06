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
    Rails.logger.info match_transactions_params
    transactions = Transaction
      .where(id: match_transactions_params[:transaction_ids])
      .includes :category_transaction
    category = Category.find match_transactions_params[:category_id]

    # clear any attached matchers, then build a new matcher and connect
    # it manually
    transactions.each do |transaction|
      transaction.category_transaction.destroy if transaction.category_transaction
      matcher = Matcher.create category: category, words: transaction.description
      transaction.create_category_transaction matcher: matcher, category: category
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
