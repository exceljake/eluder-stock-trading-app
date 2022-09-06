class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_access_restriction
  before_action :set_account, only: [:show, :edit, :update, :destroy, :approve]

  def index
    @pending = User.traders.pending
    @approved = User.traders.approved
  end

  def show
    @account.portfolio.update(overall_worth: compute_overall_worth(@account)) if @account.portfolio
  end

  def new
    @account = User.new
  end

  def create
    @account = User.new(account_user_params)
    @account.status = "approved"
    password = generate_random_password(10)
    @account.password = password
    if @account.save
      AccountMailer.with(user: @account, password: password).create_email.deliver_now
      flash[:notice] = "Trader Account has been created successfully"
      redirect_to account_path(@account)
    else
      flash.now[:alert] = "Oh no! Something went wrong. Check inputs carefully."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @account.update(account_user_params)
      flash[:notice] = "Trader Account has been updated successfully"
      redirect_to account_path(@account)
    else
      flash.now[:alert] = "Oh no! Something went wrong. Check inputs carefully."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account.destroy
    flash[:alert] = "Trader Account has been deleted successfully"
    redirect_to accounts_path, status: :see_other
  end

  def approve
    @account.update(status: "approved")
    AccountMailer.with(user: @account).approve_email.deliver_now
    flash[:notice] = "Trader account has been approved"
    redirect_to account_path(@account)
  end


  private
  def set_account 
    @account = User.find(params[:id])
  end

  def account_user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def generate_random_password(num)
    arr = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    password = ""
    num.times { password += arr.shuffle[(rand*arr.length).floor] }
    password
  end
end
