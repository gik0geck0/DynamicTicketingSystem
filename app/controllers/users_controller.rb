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
end
