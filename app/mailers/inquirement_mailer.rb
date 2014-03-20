# encoding: utf-8
class InquirementMailer < ActionMailer::Base
  
  default from: "\"霏亞國際美容教育機構\" <service@feya-spa.com.tw>"
  
  def send_notice(inquirement)
  	@inquirement = inquirement
  	
  	mail(:to => Admin.pluck( :email ),
  	     :subject => "[霏亞國際官網] 收到使用者詢問囉！")
  	
  end
end
