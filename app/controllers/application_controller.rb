class ApplicationController < ActionController::API

protected
  def get_to_from
    @from = DateTime.parse params[:from] rescue nil
    @to = DateTime.parse params[:to] rescue nil
  end
end
