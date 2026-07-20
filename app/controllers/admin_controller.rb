class AdminController < ApplicationController
  before_action :require_account

  def show
    authorize current_account, :admin?
  end
end
