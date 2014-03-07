# encoding: utf-8
class Admin::MembersController < AdminController
  layout "admin"
  
  def index
    @members = Member.order("created_at DESC").page( params[ :page ] ).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
  
  def destroy
  	@member = Member.find( params[ :id ] )
  	
  	@member.destroy
  	
  	respond_to do | format |
  		format.html { redirect_to admin_members_path, notice: '成功刪除使用者。' }
  	end
  	
  end
  
end
