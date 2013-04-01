class SessionsController < ApplicationController
  def new
  end

  def create
    puts "Params are: ", params
    puts "Logging in:", params[:email], params[:password]
    user = User.authenticate(params[:email][0], params[:password][0])

    if user
      session[:user_id] = user.id
      #redirect_to root_url, :notice => "Logged in"
      redirect_to root_url + "users/#{session[:user_id]}"
    else
      flash.now.alert = "Invalid login"

      # Reset the login parameters
      params[:email] = nil
      params[:password] = nil
      params[:password_confirmation] = nil
      render "new"
    end
  end

  def exit
    reset_session
    redirect_to root_url
  end
end
