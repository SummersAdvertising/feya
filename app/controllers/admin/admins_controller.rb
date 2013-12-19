# encoding: utf-8
class Admin::AdminsController < AdminController
	def index
		@admins = Admin.all
		@admin = Admin.new
	end
	
	def create
		@admin = Admin.new( params[ :admin ] )
	
		respond_to do | format |
			if @admin.save
				format.html { redirect_to admin_admins_path, notice: '新增管理員成功' }
			else
				flash[ :warning ] = @admin.errors.messages.values.flatten.join('<br>')
				format.html { render :index }
			end
		end
	
	end
	
	def edit
		@admin = Admin.find( params[ :id ] )
	end
	
	def update
	
		if params[ :admin ][ :password ].empty?
			params[ :admin ].delete( :password)
			params[ :admin ].delete(:password_confirmation)
		end
		
		@admin = Admin.find( params[ :id ] )
		
		respond_to do | format |
			if @admin.update_attributes( params[ :admin ] )
				format.html { redirect_to admin_admins_path, notice: '更新管理員成功' }
			else
				flash[ :warning ] = @admin.errors.messages.values.flatten.join('<br>')
				format.html { render :edit }
			end
		end
		
	end
	
	def destroy
	
		@admin = Admin.find( params[ :id ] )
		@admin.destroy
		
		respond_to do | format |
			format.html { redirect_to admin_admins_path, notice: '刪除管理員成功' }
		end
	
	end

end
