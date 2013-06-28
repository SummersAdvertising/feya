class Admin::OrderrefundsController < AdminController
  layout "admin"
  
  def index
    @orderrefunds = Orderrefund.select("orderrefunds.*, orders.buyername, orders.ordernum").joins("LEFT OUTER JOIN orders on orders.id = orderrefunds.order_id")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orderrefunds }
    end
  end

  def show
    @orderrefund = Orderrefund.where(:id => params[:id]).select("*").joins("LEFT OUTER JOIN orders on orders.id = orderrefunds.order_id").first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orderrefund }
    end
  end
end
