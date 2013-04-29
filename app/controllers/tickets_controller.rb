class TicketsController < ApplicationController
  def new
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

    @ticket = Ticket.new

    #respond_to do |format|
    #  format.html
    #  format.json
    #end
  end

  def create
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

    params[:ticket][:user] = User.find_by_id params[:ticket][:uid].to_i
    params[:ticket][:status] = Status.find_by_id params[:ticket][:sid].to_i
    puts "Usr: #{params[:ticket][:user]} ; Status: #{params[:ticket][:status]}"

    respond_to do |format|
      puts "Creating ticket #{params[:ticket]}"
      if Ticket.create(params[:ticket])
        puts "Ticket successfully created"
        format.html { redirect_to @ticket, notice: 'Ticket Successfully Created' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        puts "Ticket creation failed", @ticket.errors.map { |attr, msg| msg }
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end
    @ticket = Ticket.find_by_id(params[:id])
    puts "Showing ticket:", @ticket
    puts "All tickets:", Ticket.all

    respond_to do |format|
      format.html
      format.json { render json: @ticket }
    end
  end

  def index
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end
    
    @tickets = Ticket.all.select { |t| t.get_current_owner().id == session[:user_id] }
  end

  def edit
    puts "params are: ", params
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:user])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end
end
