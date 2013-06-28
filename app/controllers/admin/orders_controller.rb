#encoding: UTF-8 
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
    @orders = Order.where(["status = ?", @order.status])
  end

  def update
    @order = Order.where(["orders.id = ?", params[:id]]).select("orders.*, members.email").joins('LEFT OUTER JOIN members on members.id = orders.member_id').first
    @originStatus = @order.status

    params[:orderitem].each do |orderitem|
      @orderitem = Orderitem.where(:id => orderitem[0]).select("orderitems.* ,products.name").joins('LEFT OUTER JOIN stocks on stocks.id = orderitems.stock_id LEFT OUTER JOIN products on products.id = stocks.product_id').first
      @refundSum = 0
      if(@orderitem.amount != orderitem[1].to_i)
        @orderlog = Orderlog.new
        @orderlog.order_id = @order.id
        @orderlog.description = @orderitem.name + ((orderitem[1].to_i - @orderitem.amount) > 0 ? "增加" : "減少") + (@orderitem.amount - orderitem[1].to_i).abs.to_s + "個。"

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

        @substract = (@refundSum / 200).floor

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
        @orderlog.description = "退貨扣除購物金：" + @substract.to_s + "點"
        @orderlog.save
      end
    end

    respond_to do |format|
      if (@order.status != params[:order][:status] && @order.update_attributes(params[:order]))
        @orderlog = Orderlog.new
        @orderlog.order_id = @order.id
        @orderlog.description = "訂單變更狀態為：" + params[:order][:status]
        @orderlog.save

        format.html { redirect_to admin_order_path(@order), notice: 'Order was successfully updated.' }
        format.json { head :no_content }

        case(@order.status)
        when "processing"
          Ordermailer.statusprocessing(@order.email, @order).deliver
        when "finish"
          Ordermailer.statusfinish(@order.email, @order).deliver
        end

      else
        @order.status = @originStatus

        format.html { render "show" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

end