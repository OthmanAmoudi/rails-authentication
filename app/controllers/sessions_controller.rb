# this class handles the Login/Logout features
class SessionsController < ApplicationController
  def new
    puts 'FFF'

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # log user in and redirect them , show welcome message
      log_in user
      redirect_to user
    else
      # Error message flash
      render 'new', alert: 'invalid email/ password'
    end
  end

  def destroy
  end
end
