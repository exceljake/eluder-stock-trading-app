class AccountMailer < ApplicationMailer
  default from: "Eluder Accounts Team"

  def register_email
    @user = params[:user]
    mail(to: email_address_with_name(@user.email, "#{@user.first_name} #{@user.last_name}"), subject: "Welcome to Eluder")
  end

  def create_email
    @user = params[:user]
    @password = params[:password]
    mail(to: email_address_with_name(@user.email, "#{@user.first_name} #{@user.last_name}"), subject: "Welcome to Eluder")
  end

  def approve_email
    @user = params[:user]
    mail(to: email_address_with_name(@user.email, "#{@user.first_name} #{@user.last_name}"), subject: "Account Approved")
  end
end
