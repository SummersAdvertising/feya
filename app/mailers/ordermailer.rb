#encoding: utf-8
class Ordermailer < ActionMailer::Base
  default from: "\"霏亞國際美容教育機構\" <service@feya-spa.com.tw>"
  def newOrder(receiver, order)
  	@order = order

  	mail(:to => [ receiver ], :subject => "訂單成立通知")  	
  end
  
  def new_order_notice( order )  	
  	@order = order
  	
  	mail( :to => Admin.where( :mail_flag => true ).pluck( :email ), :subject => "新訂單指定貨到付款通知" )
  	
  end
  
  def remittance_notice( order )
  	@order = order
  	
  	mail( :to => order.member.email, :subject => "訂單付款方式須知" )  	
  	
  end
  
  def payment_notice( order )
  	@order = order
  	
  	mail( :to => Admin.where( :mail_flag => true ).pluck( :email ), :subject => "匯款完成通知" )
  	
  end
  
  def runoutofproduct(traceitems)
    @traceitems = Stock.where(:id => traceitems).select('products.name, stocks.*').joins("LEFT OUTER JOIN products on products.id = stocks.product_id")

    mail(:to => Admin.first.email, :subject => "商品補貨通知")    
  end

  def statuschange(receiver, order)
  	@order = order

    case @order.status
    when "check"
      @status = "已收款。"
    when "processing"
      @status = "處理中。"
    when "deliver"
      @status = "已寄送。"
    when "cancel"
      @status = "已取消。"
    end

  	mail(:to => receiver, :subject => ("[進度通知]訂單" + @status) )
  	
  end

  def refund(receiver, refund)
    @refund = refund
    @order = Order.find(@refund.order_id)
    mail(:to => [receiver, Admin.first.email], :subject => ("[訂單異動申請]訂單編號：" + (@order.ordernum ? @order.ordernum : "") ) )
  end

end
