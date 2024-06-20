
class FacebookController < ApplicationController
  def auth
    redirect_to "https://www.facebook.com/v12.0/dialog/oauth?client_id=#{ENV['FACEBOOK_APP_ID']}&redirect_uri=#{ENV['FACEBOOK_REDIRECT_URI']}&scope=ads_management,ads_read", allow_other_host: true
  end

  def callback
    response = HTTParty.post("https://graph.facebook.com/v12.0/oauth/access_token", {
      query: {
        client_id: ENV['FACEBOOK_APP_ID'],
        client_secret: ENV['FACEBOOK_APP_SECRET'],
        code: params[:code],
        redirect_uri: ENV['FACEBOOK_REDIRECT_URI']
      },
      headers: { 'Content-Type' => 'application/json' }
    })

    if response.code == 200
      facebook_data = JSON.parse(response.body)
      current_user.facebook_accounts.create(
        facebook_user_id: facebook_data['user_id'],
        facebook_access_token: facebook_data['access_token']
      )
      redirect_to ad_companies_path, notice: 'Facebook account connected successfully.'
    else
      error_message = JSON.parse(response.body)['error']['message']
      redirect_to ad_companies_path, alert: "Failed to connect Facebook account: #{error_message}"
    end
  end
end
