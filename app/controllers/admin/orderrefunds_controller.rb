#encoding: UTF-8
class Admin::OrderrefundsController < AdminController
  layout "admin"
  
  def index
    case params[:type]
    when "new"
      @status = "未處理"
    when "done"
      @status = "已處理"
    else
      @status = "未處理"
    end

    @orderrefunds = Orderrefund.where(["orderrefunds.status = ?", @status]).select("orderrefunds.*, orders.buyername, orders.ordernum").joins("LEFT OUTER JOIN orders on orders.id = orderrefunds.order_id").order("orderrefunds.created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orderrefunds }
    end
  end

  def done
    @orderrefund = Orderrefund.find(params[:id])
    @orderrefund.status = "已處理"
    @orderrefund.save
    respond_to do |format|
      format.html { redirect_to admin_orderrefunds_path() }
      format.json { render json: @orderrefund }
    end
  end
end
