# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    redirect_to new_user_session_path, status: :see_other
  end

  
  protected
  def after_sign_in_path_for(resource)
    if resource.role == "trader"
      trader_dashboard_path
    else 
      admin_dashboard_path
    end
  end
end
