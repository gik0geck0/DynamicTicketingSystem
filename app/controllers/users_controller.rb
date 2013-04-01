class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    puts "Creating User: ", params[:user]
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Account Successfully Created"
    else
      render "new"
    end
  end

  def show
    if session[:user_id] == nil
      redirect_to root_url, :notice => "Please Log In"
    else
      #@user = User.get_current_user session[:user_id]
      @user = User.find(params[:id])

      respond_to do |format|
        format.html
        format.json { render json: @user }
      end
    end
  end
end
