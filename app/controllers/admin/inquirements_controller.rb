class Admin::InquirementsController < AdminController
  # GET /inquirements
  # GET /inquirements.json
  def index
    @inquirements = Inquirement.order( 'created_at DESC' ).page( params[ :page ] ).per( 20 )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inquirements }
    end
  end

  # GET /inquirements/1
  # GET /inquirements/1.json
  def show
    @inquirement = Inquirement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inquirement }
    end
  end

  # DELETE /inquirements/1
  # DELETE /inquirements/1.json
  def destroy
    @inquirement = Inquirement.find(params[:id])
    @inquirement.destroy

    respond_to do |format|
      format.html { redirect_to admin_inquirements_url }
      format.json { head :no_content }
    end
  end
end
