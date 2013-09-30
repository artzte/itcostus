class MatchersController < ApplicationController
  def index
    render json: Matcher.all
  end
end
