class ApplicationController < ActionController::Base

  protected

  def ensure_access_token
    unless session[:access_token]
      redirect_to oauth2_client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/repo/oauth2_callback')
    end
  end

  def oauth2_client
    OAuth2::Client.new(
      Rails.application.credentials[:github][:client_id],
      Rails.application.credentials[:github][:client_secret],
      :authorize_url => '/login/oauth/authorize',
      :token_url => '/login/oauth/access_token',
      :site => 'https://github.com'
    )
  end

end
