class RepoController < ApplicationController

  before_action :ensure_access_token, :except => :oauth2_callback

  def index
    repos = oauth2_client.get('https://api.github.com/user/repo').parsed
    @names = repos.map {|repo| repo[:name] }
  end

  # TODO: This ought to be in a AuthorisationController or somesuch...
  #
  def oauth2_callback
    # Swap Auth token for an access token
    token = oauth2_client.auth_code.get_token(params[:code])

    # Remember the access token
    session[:access_token] = token.token
    redirect_to :index
  end
end
