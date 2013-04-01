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
      redirect_to root_url + "profile"
    else
      flash.now.alert = "Invalid login"

      # Reset the login parameters
      params[:email] = nil
      params[:password] = nil
      params[:password_confirmation] = nil
      render "new"
    end
  end

  def view
    # Profile screen. We also don't want to show all sessions ;-)
    puts "Looking up current user with user_id = #{session[:user_id]}"
    if not defined? session[:user_id]
      redirect_to root_url, :notice => "Please Log in"
    else
      @user = User.get_current_user session[:user_id]
      puts "Current_user is #{@user}"
    end
  end
end
