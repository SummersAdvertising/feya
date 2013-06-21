class Admin::OrderrefundsController < AdminController
  layout "admin"
  
  def index
    @orderrefunds = Orderrefund.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orderrefunds }
    end
  end

  def show
    @orderrefund = Orderrefund.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orderrefund }
    end
  end
end
