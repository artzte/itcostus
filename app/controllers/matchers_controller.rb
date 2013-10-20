class MatchersController < ApplicationController
  before_filter only: [:show, :update] do
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

end
