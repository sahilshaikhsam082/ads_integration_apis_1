# app/controllers/ad_companies_controller.rb
class AdCompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Any data preparation for the view can be done here
  end

  def connect
    company = params[:company]
    case company
    when 'google'
      connect_to_google
    when 'shopify'
      connect_to_shopify
    when 'facebook'
      connect_to_facebook
    when 'tiktok'
      redirect_to tiktok_auth_path and return
    else
      render json: { error: 'Unknown company' }, status: :bad_request and return
    end

    render json: { message: "#{company.capitalize} connected successfully" }
  end

  private

  def fetch_tiktok_ad_accounts
    @tiktok_account = current_user.tiktok_accounts.find(params[:id])
    @ad_accounts = @tiktok_account.fetch_ad_accounts
  end

  def connect_to_google
    # Example logic to connect to Google Ads API
    # Make an API request to Google Ads and handle the response
  end

  def connect_to_shopify
    # Example logic to connect to Shopify API
    # Make an API request to Shopify and handle the response
  end

  def connect_to_facebook
    # Example logic to connect to Facebook Ads API
    # Make an API request to Facebook Ads and handle the response
  end
end
