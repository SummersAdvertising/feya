class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_admin
  	unless(session[:admin])
  		redirect_to admin_login_path
  	end
  end
end
