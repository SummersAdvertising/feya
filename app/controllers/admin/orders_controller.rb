class Admin::OrdersController < AdminController
  before_filter :count_orders
  layout "admin"

  def index
  	case params[:type]
  	when "new", "processing", "finish"
  		#do nothing
  	else
  		params[:type] = "new"
  	end

  	@orders = Order.where(["status = ?", params[:type]])
  end

  def show
  	@order = Order.where(["orders.id = ?", params[:id]]).select("orders.*, members.email").joins('LEFT OUTER JOIN members on members.id = orders.member_id').first
  end

  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])

        #send email

        format.html { redirect_to admin_order_path(@order), notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

end