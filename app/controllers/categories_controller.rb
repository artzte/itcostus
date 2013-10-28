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
    @category.category_transactions.load
    render json: @category, to: @to, from: @from
  end

end
