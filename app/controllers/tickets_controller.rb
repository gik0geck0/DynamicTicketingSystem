class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @ticket = Ticket.new(params[:ticket])

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket Successfully Created' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @ticket = Ticket.find_by_id(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @ticket }
    end
  end

  def update
    # TODO: Add updates to ticket. Also needs model
  end
end
