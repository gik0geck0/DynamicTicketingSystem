class Ticket::TicketUpdateController < ApplicationController
  def create
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

    respond_to do |format|
      puts "Creating ticket #{params[:ticket_update]}"
      if Ticket.create(params[:ticket_update])
        puts "Ticket Update successfully created"
        format.html { redirect_to @ticket_update, notice: 'Ticket Successfully Created' }
        format.json { render json: @ticket_update, status: :created, location: @ticket_update }
      else
        puts "Ticket Update creation failed", @ticket_update.errors.map { |attr, msg| msg }
        format.html { render action: "new" }
        format.json { render json: @ticket_update.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

    @ticket_update = TicketUpdate.new
  end
end
