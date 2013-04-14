class TicketsController < ApplicationController
  def new
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

    @ticket = Ticket.new

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

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

  def update
    # TODO: Add updates to ticket. Also needs model for updates/notes/etc
  end
end
