#encoding: utf-8
class Ordermailer < ActionMailer::Base
  default from: "mailer@example.com"
  def new(receiver, order)
  	@order = order

  	mail(:to => [ receiver, Admin.first.email ], :subject => "訂單成立通知")
  	
  end

  def statusprocessing(receiver, order)
  	@order = order
  	mail(:to => receiver, :subject => "[進度通知]訂單處理中")
  	
  end

  def statusfinish(receiver, order)
  	@order = order

  	mail(:to => receiver, :subject => "[進度通知]訂單已完成")
  	
  end

end
