
class TiktokAccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tiktok_account, only: [:fetch_ad_accounts]

  def fetch_ad_accounts
    ad_accounts = @tiktok_account.fetch_ad_accounts
    render json: ad_accounts
  end

  private

  def set_tiktok_account
    @tiktok_account = current_user.tiktok_accounts.find(params[:id])
  end
end
