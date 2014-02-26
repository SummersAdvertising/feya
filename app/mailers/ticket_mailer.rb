# encoding: utf-8
class TicketMailer < ActionMailer::Base
  default from: "\"霏亞國際美容教育機構\" <service@feya-spa.com.tw>"
  
  def send_notice(ticket)
  	@ticket = ticket
  	
  	mail(:to => Admin.pluck( :email ),
  	     :subject => "[霏亞國際官網] 收到使用者加盟請求囉！")
  	
  end
end
