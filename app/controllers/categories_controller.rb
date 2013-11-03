class CategoriesController < ApplicationController
  
  respond_to :json

  before_filter do
    get_to_from
  end
  
  def index
    render json: Category.includes(:category_transactions), to: @to, from: @from
  end

  def show
    get_category params[:id]
    @category.transactions.with_matcher.with_denormalized_category_and_matcher.order(:posted_at).load
    render json: @category, to: @to, from: @from, transactions: true
  end

end
