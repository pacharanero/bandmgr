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

  def edit
    @account = Account.find(params[:id])
    authorize @account
  end

  def update
    @account = Account.find(params[:id])
    authorize @account

    updates = account_params.to_h
    scrub_blank_keys!(updates, :ai_openai_api_key, :ai_anthropic_api_key)

    if @account.update(updates)
      redirect_to @account, notice: "Account updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def account_params
      params.require(:account).permit(:name, :slug, :ai_provider, :ai_openai_api_key, :ai_anthropic_api_key, :ai_local_url)
    end

    def scrub_blank_keys!(updates, *keys)
      keys.each do |key|
        updates.delete(key) if updates[key].to_s.strip.empty?
      end
    end
end
