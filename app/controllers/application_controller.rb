class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected
  def get_category id
    @category = case id
    when 'unassigned'
      nil
    else
      Category.find id
    end
  end

  def get_to_from
    @from = DateTime.parse params[:from] rescue nil
    @to = DateTime.parse params[:to] rescue nil
  end
end
