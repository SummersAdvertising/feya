class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_admin
  	unless(session[:admin])
  		redirect_to admin_login_path
  	end
  end

  def is_member
  	unless(member_signed_in?)
  		session["member_return_to"] = "/orders/check"
  		redirect_to new_member_session_path
  	end
  end

  def record_login_redirect_path
  	session["member_return_to"] = "#{request.fullpath}"
  end

  def after_sign_in_path_for(resource)
  	request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
  	request.referrer
  end
end
