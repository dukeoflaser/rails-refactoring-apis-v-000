class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create

    github = GithubService.new
    access_token = github.authenticate!(ENV['GITHUB_CLIENT'], ENV['GITHUB_SECRET'], params[:code])

    session[:github] = github
    session[:token] = access_token
    session[:username] = github.get_username

    redirect_to '/'
  end
end
