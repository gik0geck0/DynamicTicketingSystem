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

    usr_id = params[:ticket][:uid].to_i
    sts_id = params[:ticket][:sid].to_i
    usr = User.find_by_id usr_id
    sts = Status.find_by_id sts_id
    puts "UID: #{usr_id} Usr: #{usr} SID: #{sts_id} Status: #{sts}"
    params[:ticket][:user] = User.find_by_id params[:ticket][:uid].to_i
    params[:ticket][:status] = Status.find_by_id params[:ticket][:sid].to_i

    puts "Creating ticket #{params[:ticket]}"
    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
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
    
    @tickets = Ticket.find_all_by_user_id(session[:user_id])
  end

  def update
    # TODO: Add updates to ticket. Also needs model for updates/notes/etc
  end
end
