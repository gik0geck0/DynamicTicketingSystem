class UsersController < ApplicationController
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

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

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
