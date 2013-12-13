class Admin::MembersController < AdminController
  layout "admin"
  
  def index
    @members = Member.order("created_at DESC").page( params[ :page ] ).per(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
end
