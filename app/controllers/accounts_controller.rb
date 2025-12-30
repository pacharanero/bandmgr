class AccountsController < ApplicationController
  def new
    @account = Account.new
    authorize @account
  end

  def create
    @account = Account.new(account_params)
    @account.slug = @account.slug.presence || @account.name.to_s.parameterize
    authorize @account

    if @account.save
      @account.memberships.create!(user: current_user, role: :owner)
      Current.account = @account
      redirect_to @account, notice: "Account created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @account = Account.find(params[:id])
    authorize @account
  end

  private
    def account_params
      params.require(:account).permit(:name, :slug)
    end
end
