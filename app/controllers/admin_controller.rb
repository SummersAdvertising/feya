#encoding: utf-8
class AdminController < ApplicationController
	before_filter :is_admin, :except => [:login, :checkAdmin]

	def login
		@admin = Admin.new
		
		respond_to do | format |
			if session[:admin]
				redirect_to admin_root_path 
			else
				format.html { render :layout => nil }
			end
		end
	end

	def checkAdmin
		@admin = Admin.new(params[:admin])
		@dbData = Admin.where("email = ?", @admin.email).first

		respond_to do |format|
			if(@dbData && pswordCheck(@admin.password, @dbData.password))
				session[:admin] = @dbData
				format.html { redirect_to admin_root_path }
			else
				flash[:warning] = "帳號或密碼輸入錯誤。"
				format.html { redirect_to admin_login_path }
			end
		end
	end

	def logout
		session[:admin] = nil
		respond_to do |format|
			format.html { redirect_to admin_login_path }
		end	
	end

	private
	def pswordCheck(fromUser, fromDb)
		Digest::SHA1.hexdigest(fromUser) == fromDb
	end
end