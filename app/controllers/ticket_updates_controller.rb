class TicketUpdatesController < ApplicationController
  def create
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

    params[:ticket_update][:ticket] = Ticket.find(params[:ticket_id])
    params[:ticket_update][:updater] = User.find(session[:user_id])
    if params[:ticket_update][:oid]
      params[:ticket_update][:owner] = User.find(params[:ticket_update][:oid])
      params[:ticket_update].delete(:oid)
    end
    if params[:ticket_update][:sid]
      params[:ticket_update][:status] = Status.find(params[:ticket_update][:sid])
      params[:ticket_update].delete(:sid)
    end
    params[:ticket_update][:time_logged] = params[:ticket_update][:time_logged].to_f + 0
    params[:ticket_update][:revision] ||= 0

    respond_to do |format|
      @ticket_update = TicketUpdate.new(params[:ticket_update])
      if @ticket_update.save
        puts "Ticket Update successfully created"
        format.html { redirect_to Ticket.find(params[:ticket_id]), notice: 'Update successfully added to ticket' }
        format.json { render json: @ticket_update, status: :created, location: @ticket_update }
        
      else
        puts "Ticket Update creation failed", @ticket_update.errors.map { |attr, msg| "#{attr}: #{msg}" }
        # TODO: This doesn't rediret correctly
        format.html { render action: "new" }
        format.json { render json: @ticket_update.errors, status: :unprocessable_entity }
      end
    end

    return
  end

  def new
    if not session[:user_id]
      redirect_to root_url + "log_in", notice: 'Please login'
      return
    end

    @ticket = Ticket.find(params[:ticket_id])
    @ticket_update = TicketUpdate.new
  end
end
