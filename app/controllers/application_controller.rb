class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_admin
  	unless(session[:admin])
  		redirect_to admin_login_path
  	end
  end

  def is_member
  	unless(member_signed_in?)
  		session["member_return_to"] = "#{request.fullpath}"
  		redirect_to new_member_session_path
  	end
  end

  def count_orders
    @countnew = Order.where(["status = ?", "new"]).count
    @countcheck = Order.where(["status = ?", "check"]).count
    @countprocessing = Order.where(["status = ?", "processing"]).count
    @countdeliver = Order.where(["status = ?", "deliver"]).count
    @countcancel = Order.where(["status = ?", "cancel"]).count
  end

  def count_cartitems
    if(cookies[:cart])
      @cartitems = JSON.parse(cookies[:cart]) 
      @cartitems_count = @cartitems.length
    else
      @cartitems_count = 0
    end
    
  end

  def record_login_redirect_path
  	session["member_return_to"] = "#{request.fullpath}"
  end

  def after_sign_in_path_for(resource)
  	request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
  	(request.referrer == "#{request.protocol}#{request.host_with_port}"+check_orders_path) ? root_path : request.referrer
  end
end
