class MatchersController < ApplicationController
  def index
    render json: Matcher.all
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

  def update

  end

protected

  def matcher_params
    params.require(:matcher).permit(:category_id, :words)
  end

end
