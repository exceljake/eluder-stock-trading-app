class ApplicationController < ActionController::Base

  def admin_access_restriction
    unless current_user.role == "admin"
      redirect_to trader_dashboard_path
    end 
  end

  def trader_access_restriction
    unless current_user.role == "trader"
      redirect_to admin_dashboard_path
    end
  end

  def compute_overall_worth(current_user)
    overall_worth = 0 
    current_user.properties.each do |property|
      price = Stock.find(property.stock_id).latest_price 
      overall_worth += property.quantity * price 
    end 
    overall_worth
  end 
end
