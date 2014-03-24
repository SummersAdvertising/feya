#encoding: UTF-8 
class Admin::OrdersController < AdminController
  before_filter :count_orders
  layout "admin"

  def index
  	case params[:type]
  	when "new", "check", "processing", "deliver", "cancel"
  		#do nothing
  	else
  		params[:type] = "new"
  	end

  	@orders = Order.where(["status = ?", params[:type]]).order("created_at DESC").page(params[:page])
  end

  def show
  	@order = Order.where(["orders.id = ?", params[:id]]).select("orders.*, members.email").joins('LEFT OUTER JOIN members on members.id = orders.member_id').first
    @orders = Order.where(["status = ?", @order.status]).order("created_at DESC").page(params[:page])
  end

  def update
    @order = Order.where(["orders.id = ?", params[:id]]).select("orders.*, members.email").joins('LEFT OUTER JOIN members on members.id = orders.member_id').first
    @originStatus = @order.status

    params[:orderitem].each do |orderitem|
      @orderitem = Orderitem.where(:id => orderitem[0]).first
      @refundSum = 0
      if(@orderitem.amount != orderitem[1].to_i && orderitem[1].to_i > 0 )
        @orderlog = @order.orderlogs.new
        @orderlog.description = @orderitem.itemname.to_s + ((orderitem[1].to_i - @orderitem.amount) > 0 ? ": 追加" : ": 退訂") + (@orderitem.amount - orderitem[1].to_i).abs.to_s + "個。"

        if(@orderlog.save)
          #substract
          if(@orderitem.amount > orderitem[1].to_i)
            @refundSum = @refundSum + (@orderitem.amount - orderitem[1].to_i) * @orderitem.itemprice
          end

          @orderitem.amount = orderitem[1].to_i
          @orderitem.save
        end
      end

      if(@refundSum > 0 && @order.discountpoint > 0 )

        @substract = 0 #(@refundSum / 200).floor

        if(@order.discountpoint > @substract)
          @order.discountpoint = @order.discountpoint - @substract
        else
          @substract = @order.discountpoint
          @order.discountpoint = 0
        end

        @order.save
        
        @member = Member.find(@order.member_id)
        @member.discountpoint = (@member.discountpoint - @substract) > 0 ? (@member.discountpoint - @substract) : 0
        @member.save

        @orderlog = @order.orderlogs.new
        @orderlog.description = ""
        @orderlog.save
      end
    end

    respond_to do |format|
      format.html { redirect_to admin_order_path(@order, :page => params[:page]), notice: 'Order was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def expire
  
  	Order.where( "updated_at < ? AND status = ?", (Time.now - 3.day), 'new' ).update_all( { :status => 'hidden' } )
  	
  	respond_to do | format |
  		format.html { redirect_to admin_orders_path( :type => :new ), notice: '超過三天未處理的新訂單已清除' }
  	end
  
  end

end