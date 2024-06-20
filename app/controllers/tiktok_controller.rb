# app/controllers/tiktok_controller.rb
class TiktokController < ApplicationController
  def auth
    redirect_to "https://ads.tiktok.com/open_api/oauth2/authorize?client_id=#{ENV['TIKTOK_CLIENT_ID']}&response_type=code&scope=ad_accounts&redirect_uri=#{ENV['TIKTOK_REDIRECT_URI']}", allow_other_host: true
  end

  def callback
    response = HTTParty.post("https://ads.tiktok.com/open_api/oauth2/access_token/", {
      body: {
        client_id: ENV['TIKTOK_CLIENT_ID'],
        client_secret: ENV['TIKTOK_CLIENT_SECRET'],
        code: params[:code],
        grant_type: 'authorization_code',
        redirect_uri: ENV['TIKTOK_REDIRECT_URI']
      },
      headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    })

    if response.code == 200
      tiktok_data = JSON.parse(response.body)
      current_user.tiktok_accounts.create(
        tiktok_user_id: tiktok_data['data']['user_id'],
        tiktok_access_token: tiktok_data['data']['access_token']
      )
      redirect_to ad_companies_path, notice: 'TikTok account connected successfully.'
    else
      error_message = JSON.parse(response.body)['message']
      redirect_to ad_companies_path, alert: "Failed to connect TikTok account: #{error_message}"
    end
  end
end
