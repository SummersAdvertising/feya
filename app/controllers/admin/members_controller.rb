class Admin::MembersController < AdminController
  layout "admin"
  
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
end
