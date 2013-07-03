#encoding: UTF-8 
class Admin::Changestatus::OrdersController < AdminController
	before_filter :find_order

  def check
    if(@order.status == "new" && @order.paytype == "匯款" )
    	@order.status = "check"
    	@order.save

      logstatus_mail(@order, "已收款")
    end

    respond_to do |format|
      format.html { redirect_to  admin_order_path(@order), notice: 'Order was successfully created.' }
      format.json { render json: @order }
    end
    
  end

  def processing
  	if((@order.status == "check" && @order.paytype == "匯款" ) || (@order.status == "new" && @order.paytype != "匯款" ))
    	@order.status = "processing"
    	@order.save

      logstatus_mail(@order, "處理中")
    end

    respond_to do |format|
      format.html { redirect_to  admin_order_path(@order), notice: 'Order was successfully created.' }
      format.json { render json: @order }
    end
    
  end

  def deliver
  	if(@order.status == "processing" && params[:order][:shippingway].length>0 && params[:order][:shippingcode].length>0)
  		@order.shippingway = params[:order][:shippingway]
  		@order.shippingcode = params[:order][:shippingcode]
    	@order.status = "deliver"
    	@order.save

      logstatus_mail(@order, "已出貨")

    	respond_to do |format|
    		format.html { redirect_to  admin_order_path(@order), notice: 'Order was successfully created.' }
    		format.json { render json: @order }
    	end

    else
    	respond_to do |format|
    		format.html { redirect_to  admin_order_path(@order), alert: '請填寫運送方式及追蹤碼。' }
    		format.json { render json: @order }
    	end
    end

  end

  def cancel
  	@order.status = "cancel"
  	@order.save

    logstatus_mail(@order, "已取消")

  	respond_to do |format|
      format.html { redirect_to  admin_order_path(@order), notice: 'Order was successfully created.' }
      format.json { render json: @order }
    end    
  end

  def logstatus_mail(order, status)
    @order = order
    @orderlog = @order.orderlogs.new
    @orderlog.description = "訂單變更狀態為：" + status
    @orderlog.save

    Ordermailer.delay.statuschange(Member.find(@order.member_id).email, @order)
  end
  
  def find_order
  	@order = Order.find(params[:order_id])  	
  end
end